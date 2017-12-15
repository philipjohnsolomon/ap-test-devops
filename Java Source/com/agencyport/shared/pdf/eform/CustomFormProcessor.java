/*
 * Created on Sep 29, 2015 by ktamma AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.pdf.eform;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentCatalog;
import org.apache.pdfbox.pdmodel.interactive.form.PDAcroForm;
import org.apache.pdfbox.pdmodel.interactive.form.PDField;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.intkit.core.upload.CommonFactory;
import com.agencyport.logging.LoggingManager;
import com.agencyport.pdf.FDFFormProcessor;
import com.agencyport.pdf.FormDataMap;
import com.agencyport.pdf.GeneralOverfowGetter;
import com.agencyport.pdf.PDFContext;
import com.agencyport.pdf.resource.Form;
import com.agencyport.pdf.resource.PDFFormResourceProvider;
import com.agencyport.service.text.StringUtilities;
import com.agencyport.shared.APException;
import com.agencyport.utils.AppProperties;

/**
 * The AdditionalGeneralOverFlowGetter is our custom class that handles form
 * merging, data population for ACORD FDF forms.
 */
public class CustomFormProcessor extends FDFFormProcessor {

	/**
	 * The <code>UPLOAD_DATA_CONVERTER_CLASS_NAME_PROP</code> is the property
	 * used in <lob>.properties
	 */
	private static final String OVERFLOWGETTER_CLASS_NAME_PROP = "overflowgetter_class_name";
	/**
	 * The <code>LOGGER</code> is a copy of the logger for this package.
	 */
	private static final Logger LOGGER = LoggingManager
			.getLogger(CustomFormProcessor.class.getClass().getName());

	/**
	 * The <code>numberOfLinesPerPage</code> is the number of lines to be
	 * printed per page.
	 */
	private int NUMBEROFLINESPERPAGE = 50;

	/**
	 * {@inheritDoc}
	 */
	@Override
	public void postBuildProcess(PDDocument pdfDocument, PDFContext context,
			Form formArtifact, FormDataMap formData) throws APException {

		List<String> builder = new ArrayList<String>();
		APDataCollection apData = context.getAcordData();
		if ((apData.getLobCode().toString().equals("AUTOB"))|| (apData.getLobCode().toString().equals("BOP"))) {
			NUMBEROFLINESPERPAGE = 35;
		}
		if ("ACORD862".equals(formArtifact.getFormName())|| "ACORD863".equals(formArtifact.getFormName())) {
			return;
		}
		String overFlowGetterClass = AppProperties.getAppProperties()
				.getStringProperty(
						AppProperties.getAppProperties().resolvePropertyName(
								apData.getLobCode().toString(),
								OVERFLOWGETTER_CLASS_NAME_PROP));
		if (!"default".equals(overFlowGetterClass)) {
			GeneralOverfowGetter getOverflow = CommonFactory
					.create(overFlowGetterClass);
			builder = getOverflow.getGeneralOverFlow(apData);
		}
		if (!builder.isEmpty()) {
			List<PDDocument> documents = new ArrayList<PDDocument>();
			String producerName = apData
					.getFieldValue(
							"Producer.GeneralPartyInfo.NameInfo.CommlName.CommercialName",
							" ");
			String customerIdentifier = apData
					.getFieldValue(
							"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].ItemIdInfo.AgencyId",
							" ");
			String totalPages = ""
					+ (((builder.size() + NUMBEROFLINESPERPAGE) - 1) / NUMBEROFLINESPERPAGE);
			String insuredFullName = apData
					.getFieldValue(
							"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.NameInfo.PersonName.GivenName",
							" ")
					+ " "
					+ apData.getFieldValue(
							"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.NameInfo.PersonName.OtherGivenName",
							" ")
					+ " "
					+ apData.getFieldValue(
							"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.NameInfo.PersonName.Surname",
							" ");
			if (StringUtilities.isEmptyOnTrim(insuredFullName)) {
				insuredFullName = apData
						.getFieldValue(
								"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.NameInfo.CommlName.CommercialName",
								" ");
			}
			SimpleDateFormat newFormat = new SimpleDateFormat("mm-dd-yyyy");
			DateFormat format = new SimpleDateFormat("yyyy-mm-dd");
			Date date = null;
			try {
				if (apData.toString().contains("<PersPolicy")) {
					date = format.parse(apData.getFieldValue(
							"PersPolicy.ContractTerm.EffectiveDt", null));
				} else if (apData.toString().contains("<CommlPolicy")) {
					date = format.parse(apData.getFieldValue(
							"CommlPolicy.ContractTerm.EffectiveDt", null));
				}
			} catch (ParseException e1) {

				LOGGER.log(Level.FINE, e1.getMessage(), e1);
			}
			String effectiveDate = newFormat.format(date);
			for (int i = 0; i < builder.size(); i += NUMBEROFLINESPERPAGE) {

				PDDocument resultPDFDocument = PDFFormResourceProvider
						.getPDFDocument("ACORD0101_2008-01_Acroform.pdf");
				PDDocumentCatalog docCatalog = resultPDFDocument
						.getDocumentCatalog();
				PDAcroForm form = docCatalog.getAcroForm();

				int j = NUMBEROFLINESPERPAGE;
				if (i + j > builder.size()) {
					j = builder.size() - i;
				}
				String strValue = builder.subList(i, i + j).toString()
						.replaceAll(",", "");
				strValue = strValue.trim().substring(1, strValue.length() - 1);

				PDField formField;
				try {

					formField = form.getField("AdditionalRemark_RemarkText_A");
					formField.setValue(strValue);
					formField = null;
					formField = form.getField("Producer_FullName_A");
					formField.setValue(producerName);
					formField = null;
					formField = form.getField("Producer_CustomerIdentifier_A");
					formField.setValue(customerIdentifier);
					formField = null;
					formField = form.getField("Form_TotalPageNumber_A");
					formField.setValue(totalPages);
					formField = null;
					formField = form.getField("Form_CurrentPageNumber_A");
					formField.setValue("" + (i + NUMBEROFLINESPERPAGE)
							/ NUMBEROFLINESPERPAGE);
					formField = null;
					formField = form.getField("NamedInsured_FullName_A");
					formField.setValue(insuredFullName);
					formField = null;
					formField = form.getField("Policy_EffectiveDate_A");
					formField.setValue(effectiveDate);
					formField = null;

				} catch (IOException e) {

					LOGGER.log(Level.FINE, e.getMessage(), e);
				}

				// Add Document to List.
				documents.add(resultPDFDocument);

			}

			if ((apData.getLobCode().toString().equals("AUTOB"))
					|| (apData.getLobCode().toString().equals("BOP"))) {
				if (formArtifact.getFormName().equals("ACORD127")
						|| (formArtifact.getFormName().equals("ACORD160")))
					// Merge all created Documents with Main PDF Document.
					merge(pdfDocument, documents);
			}

			else {
				// Merge all created Documents with Main PDF Document.
				merge(pdfDocument, documents);

			}

		}
	}
}
