package com.agencyport.shared.commercial.pdf.acord125;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.apps.common.utils.CustomDateUtil;
import com.agencyport.shared.pdf.AdditionalDataSupport;
import com.agencyport.shared.pdf.IAcordConstants;
import com.agencyport.shared.pdf.PDFUtility;

/**
 * @author djenner
 *
 */
public class ApplicantBox extends AdditionalDataSupport {

	
	/**
	 * The <code>PHONE_NUMBER_CONSTANT</code>is a string constant
	 */
	private static final String PHONE_NUMBER_CONSTANT = "\"].PhoneNumber";
	/**
	 * Default Constructor
	 */
	public ApplicantBox() {
		super(0);
	}
	/**
	 * Handles all the applicant related information
	 * @param pdfDocument
	 * @param apData
	 */
	public void process(PdfDocument pdfDocument, APDataCollection apData) {
		
		
		StringBuilder insuredName = new StringBuilder().append(apData.getFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.NameInfo.CommlName.CommercialName", ""));
		String dba = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.NameInfo.SupplementaryNameInfo[SupplementaryNameCd='DBA'].SupplementaryName", "");
		int insuredCount = apData.getCount("InsuredOrPrincipal"); 
		for (int i = 0; i < insuredCount; i++) {
			String applicantName = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.NameInfo.CommlName.CommercialName", i, "");

			String applicantRole = apData.getFieldValue("InsuredOrPrincipal.InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd", i, "");
			
			// print all other than Insured now
			if (! "Insured".equalsIgnoreCase(applicantRole)) {
				if (insuredName.length() > 0) {
					insuredName.append("\n");
				}
				insuredName.append(applicantName);
			}
		}
		
		PdfBox box = pdfDocument.getBox("ApplicantName");
		box.addText(insuredName.toString());
		if (dba.length() > 0){
			box.addText("DBA: " + dba);
		}
		box.print();
			
	
		StringBuilder insuredEmail = new StringBuilder().append(apData.getFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.Communications.EmailInfo.EmailAddr", ""));

		insuredCount = apData.getCount("InsuredOrPrincipal"); 
		
		//for loop extracted to method to reduce Cyclomatic complexity.
		processInsuredEmailExtractor(apData, insuredCount, insuredEmail);
		pdfDocument.printField(insuredEmail.toString(), "Applicant.Email");
		
	
		String taxId = apData.getFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.NameInfo.TaxIdentity.TaxId", "");
		pdfDocument.printField(taxId, "InsuredOrPrincipal.TaxId");

	
		pdfDocument.printField(apData.getFieldValue(
				"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.Communications.PhoneInfo[PhoneTypeCd = \"" + IAcordConstants.PHONE_TYPE_PHONE + PHONE_NUMBER_CONSTANT, ""),
				"Applicant.Phone");

		String addr1 = apData.getFieldValue( 
				"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.Addr.Addr1", "");
		String addr2 = apData.getFieldValue(		
				"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.Addr.Addr2", "");
		String city = apData.getFieldValue(		
				"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.Addr.City", "");
		String state = apData.getFieldValue(
				"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.Addr.StateProvCd", "");
		String zip = apData.getFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.Addr.PostalCode", "");

		box = pdfDocument.getBox("InsuredOrPrincipal.Address");

		box.addText(addr1);
		if (addr2.length() > 0) {
			box.addText(addr2);
		}
		box.addText(city + " " + state  + " " + zip);
		box.print();


	
		pdfDocument.printField(apData.getFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.NameInfo.NonTaxIdentity.NonTaxIdTypeCd", ""),"InsurerId");

		String busStartDt=apData.getFieldValue("CommlPolicy.CommlPolicySupplement.CommlParentOrSubsidiaryInfo[MiscParty.MiscPartyInfo.MiscPartyRoleCd='ParentCompany'].BusinessStartDt", "");
		String busStartDtFmt= CustomDateUtil.format(busStartDt, CustomDateUtil.DATE_FORMAT_YYYY_DASH_MM_DASH_DD, 
				CustomDateUtil.DATE_FORMAT_MM_DASH_DD_DASH_YYYY);
		
		pdfDocument.printField(busStartDtFmt,"Accounting.StartDate");
		

		pdfDocument.printField(apData.getFieldValue(
						"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd=\"InspectionContact\"].GeneralPartyInfo.NameInfo.CommlName.CommercialName", ""),
						"Inspection.Name");
		pdfDocument.printField(apData.getFieldValue(
				"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd=\"InspectionContact\"].GeneralPartyInfo.Communications.PhoneInfo[PhoneTypeCd=\"" + "Phone" + PHONE_NUMBER_CONSTANT, ""),
				"Inspection.Phone");
		pdfDocument.printField(apData.getFieldValue(
				"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd=\"InspectionContact\"].GeneralPartyInfo.Communications.EmailInfo.EmailAddr", ""),
				"Inspection.Email");

		
		pdfDocument.printField(apData.getFieldValue(
		"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd=\"AC\"].GeneralPartyInfo.NameInfo.CommlName.CommercialName", ""),
		"Accounting.Name");
		pdfDocument.printField(apData.getFieldValue(
		"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd=\"AC\"].GeneralPartyInfo.Communications.PhoneInfo[PhoneTypeCd=\"" + "Phone" + PHONE_NUMBER_CONSTANT, ""),
		"Accounting.Phone");
		pdfDocument.printField(apData.getFieldValue(
				"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd=\"AC\"].GeneralPartyInfo.Communications.EmailInfo.EmailAddr", ""),
				"Accounting.Email");
		pdfDocument.printField(apData.getFieldValue(
				"CommlPolicy.CommlPolicySupplement.CommlParentOrSubsidiaryInfo[MiscParty.MiscPartyInfo.MiscPartyRoleCd=\"AC\"].BusinessStartDt", ""),
				"Accounting.StartDate");
		pdfDocument.printField(apData.getFieldValue(
				"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.Communications.WebsiteInfo[CommunicationUseCd='Business'].WebsiteURL", ""),
				"Applicant.Website");

		String legalEntity = apData.getFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd=\"Insured\"].GeneralPartyInfo.NameInfo.LegalEntityCd", "");
		//refactored to reduce Cyclomatic complexity.
		processContinued(pdfDocument, legalEntity);
	}
	/**
	 * @param pdfDocument
	 * @param legalEntity
	 */
	private void processContinued(PdfDocument pdfDocument, String legalEntity) {
		if ("IN".equalsIgnoreCase(legalEntity)) {
			pdfDocument.printField("X", "LegalEntity.Ind" );
		} else if ("PT".equalsIgnoreCase(legalEntity)) {
			pdfDocument.printField("X", "LegalEntity.Partner" );
		} else if ("CP".equalsIgnoreCase(legalEntity)) {
			pdfDocument.printField("X", "LegalEntity.Corp" );
		} else if ("JV".equalsIgnoreCase(legalEntity)) {
			pdfDocument.printField("X", "LegalEntity.Joint" );	
		} else if ("SS".equalsIgnoreCase(legalEntity)) {
			pdfDocument.printField("X", "LegalEntity.Sub" );
		} else if ("NP".equalsIgnoreCase(legalEntity)) {
			pdfDocument.printField("X", "LegalEntity.NonProfit" );			
		} else if ("LL".equalsIgnoreCase(legalEntity)) {
			pdfDocument.printField("X", "LegalEntity.LLC" );
		}else {
		    String title = getLegalEntityTextFromCode(legalEntity);
			additionalPageContent.add("APPLICANT INFORMATION : ");
			additionalPageContent.add(" ");
			additionalPageContent.add("  Legal Entity:    " + title);
			additionalPageContent.add(" ");
		}
	}
	/**
	 * @param apData
	 * @param insuredCount
	 * @param insuredEmail
	 */
	private void processInsuredEmailExtractor(APDataCollection apData, int insuredCount, StringBuilder insuredEmail) {
		for (int i =0; i< insuredCount; i++) {
			String applicantEMail = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.Communications.EmailInfo.EmailAddr", i, "");
			String applicantRole = apData.getFieldValue("InsuredOrPrincipal.InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd", i, "");
			// print all other than Insured now
			if (! "Insured".equalsIgnoreCase(applicantRole)) {
				if (insuredEmail.length() >0) {
					insuredEmail.append("\n");
				}
				insuredEmail.append(applicantEMail);
			}
		}
	}
	/**
	 * obtains legal entity name from the code value
	 * @param cd
	 * @return String
	 */
	public static String getLegalEntityTextFromCode(String cd){
		return PDFUtility.translateCodeToText("applInfoCodeListRef.xml", "legalEntity", cd);
	}


}
