package com.agencyport.shared.pdf.endorse;

import java.util.ArrayList;
import java.util.List;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.html.elements.BaseElement;
import com.agencyport.pagebuilder.Page;
import com.agencyport.pdf.core.AcordPDFManager;
import com.agencyport.pdf.core.FieldDefinition;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.policysummary.changemanagement.AggregateLevelChangeDetail;
import com.agencyport.policysummary.changemanagement.FieldLevelChangeDetail;
import com.agencyport.policysummary.changemanagement.PageLevelChangeDetail;
import com.agencyport.policysummary.changemanagement.PolicyChangeSummarizer;
import com.agencyport.shared.APException;
import com.agencyport.shared.pdf.IPdfConstants;
import com.agencyport.shared.pdf.OverflowPageControl;
import com.agencyport.trandef.Transaction;
import com.agencyport.utils.text.HtmlTransliterator;


/**
 * @author Mark Powers
 *
 */
/**
 * The PolicyChangePDFManager class supports the standard AgencyPort pdf based view
 * of the policy change summarizer object model.
 */
public class PolicyChangePDFManager extends AcordPDFManager {
	/**
	 * The FormDefinition class will aid in the printing of the policy change PDF.
	 * This PDF is actually made up of 3 different PDF's :
	 * General format, Questionnaire format and Remark format
	 */
	private static class FormDefinition {
		/**
		 * The <code>type</code>
		 */
		private int type;
		/**
		 * The <code>form</code>
		 */
		private String form;
		/**
		 * The <code>layout</code>
		 */
		private String layout;
		/**
		 * The <code>maxLinesPerPage</code>
		 */
		private int maxLinesPerPage;
		/**
		 * The <code>layoutPage</code>
		 */
		private int layoutPage;
	}

	/**
	 * The <code>PAGE_TYPE_GENERAL</code> is the index for the general form.
	 */
	private static final int PAGE_TYPE_GENERAL = 0;
	/**
	 * The <code>PAGE_TYPE_QUESTION</code> is the index for the question form.
	 */
	private static final int PAGE_TYPE_QUESTION = 1;
	/**
	 * The <code>PAGE_TYPE_REMARK</code> is the index for the remarks form.
	 */
	private static final int PAGE_TYPE_REMARK = 2;
	
	/**
	 * The <code>MAX_REMARK_TEXT_WIDTH</code> is the max width for remark text.
	 */
	private static final int MAX_REMARK_TEXT_WIDTH = 125;
	
	/**
	 * The <code>formDefinitions</code> contains the form definitions for the 3 basic form types.
	 */
	private FormDefinition[] formDefinitions;
	/**
	 * The <code>remarks</code> contains the list of remarks for this policy.
	 */
	private List<String> remarks = new ArrayList<String>();
	
	/**
	 * The <code>policyChangeSummarizer</code> is the policy change summarizer for this policy.
	 */
	private PolicyChangeSummarizer policyChangeSummarizer;
	/**
	 * The <code>transaction</code> is the transaction for this work item.
	 */
	private Transaction transaction;
	/**
	 * The <code>isCommercial</code> reflects whether or not the work item is a commercial product line or not. 
	 */
	private boolean isCommercial;
	
	/**
	 * The <code>VALUE_CHANGED</code> is a string constant
	 */
	private static final String VALUE_CHANGED = "Value.Changed.";
	
	/**
	 * @param apData
	 * @param pdfDocument
	 * @param summary
	 * @param transaction
	 * @param isCommercial
	 */
	public PolicyChangePDFManager(APDataCollection apData, PdfDocument pdfDocument, PolicyChangeSummarizer summary, Transaction transaction, boolean isCommercial) {
	
		this.apData = apData;	
		this.pdfDocument = pdfDocument;
		this.policyChangeSummarizer = summary;
		this.transaction = transaction;
		this.isCommercial = isCommercial;
		
		// Set up form definition array
		setupDefinitions();
	}
	
	/**
	 * Sets up the form definitions for the various supported form types. 
	 */
	private void setupDefinitions() {
		
		formDefinitions = new FormDefinition[3];
		
		formDefinitions[PAGE_TYPE_GENERAL] = new FormDefinition();
		formDefinitions[PAGE_TYPE_GENERAL].type = PAGE_TYPE_GENERAL;
		formDefinitions[PAGE_TYPE_GENERAL].form = IPdfConstants.POLICY_CHANGE_REQUEST_FORM;
		formDefinitions[PAGE_TYPE_GENERAL].layout = IPdfConstants.POLICY_CHANGE_REQUEST_LAYOUT;
		formDefinitions[PAGE_TYPE_GENERAL].maxLinesPerPage = 20;
		formDefinitions[PAGE_TYPE_GENERAL].layoutPage = 1;
		
		formDefinitions[PAGE_TYPE_QUESTION] = new FormDefinition();
		formDefinitions[PAGE_TYPE_QUESTION].type = PAGE_TYPE_QUESTION;
		formDefinitions[PAGE_TYPE_QUESTION].form = IPdfConstants.POLICY_CHANGE_REQUEST_QUESTION_FORM;
		formDefinitions[PAGE_TYPE_QUESTION].layout = IPdfConstants.POLICY_CHANGE_REQUEST_LAYOUT;
		formDefinitions[PAGE_TYPE_QUESTION].maxLinesPerPage = 10;	
		formDefinitions[PAGE_TYPE_QUESTION].layoutPage = 2;
		
		formDefinitions[PAGE_TYPE_REMARK] = new FormDefinition();
		formDefinitions[PAGE_TYPE_REMARK].type = PAGE_TYPE_REMARK;
		formDefinitions[PAGE_TYPE_REMARK].form = IPdfConstants.POLICY_CHANGE_REQUEST_REMARK_FORM;
		formDefinitions[PAGE_TYPE_REMARK].layout = IPdfConstants.POLICY_CHANGE_REQUEST_LAYOUT;
		formDefinitions[PAGE_TYPE_REMARK].maxLinesPerPage = 60;
		formDefinitions[PAGE_TYPE_REMARK].layoutPage = 3;
	}

	/* (non-Javadoc)
	 * @see com.agencyport.pdf.core.AcordPDFManager#createPDF()
	 */
	@Override
	public void createPDF() throws APException {
		writePages();
	}
	
	/**
	 * Renders all of the pages to the PDF target.
	 * @throws APException
	 */
	private void writePages() throws APException {

		PageLevelChangeDetail[] pageLevelChangeDetails = policyChangeSummarizer.getPageLevelChangeDetails(transaction);
		boolean remarksOnly = false;
		
		int pageIndex = 0;
		for (int i = 0; i < pageLevelChangeDetails.length; i++) {
			
			FormDefinition formDefinition = getFormDefinition(pageLevelChangeDetails[i]);
			
			if (pageLevelChangeDetails[i].hasChanges()) {
				
				remarksOnly = pageContainsOnlyRemarks(pageLevelChangeDetails[i]);
				
				// Don't add a new page if the page only contains remarks.  Remarks will 
				// be dealt with separately
				if (!remarksOnly) {
					pageIndex++;
					setupPage(pageIndex, formDefinition);
				}

				// Let a remarks only page flow through the writePage method so the remarks are saved.
				pageIndex = writePage(pageLevelChangeDetails[i], pageIndex, formDefinition, remarksOnly);
			}
		}
		
		// Now deal with remarks
		writeRemarks(pageIndex);
		
	}
	
	/**
	 * Writes the remarks onto to a specified page.  
	 * @param pageIndex is the page index under consideration.
	 * @throws APException
	 */
	private void writeRemarks(int pageIndex) throws APException {
		int pageIndexTemp = pageIndex;
		int count = remarks.size();
		int numLines = 0;
		FormDefinition formDefinition = formDefinitions[PAGE_TYPE_REMARK];
		String value;
		
		if (count == 0){
			return;
		}
		pageIndexTemp++;
		setupPage(pageIndexTemp, formDefinition);	
		writeHeaderFooter(pageIndexTemp, "Remarks/Agent Comments", false);
		
		PdfBox box = pdfDocument.getBox("Remark.Value");
		
		for (int i = 0; i < remarks.size(); i++) {
			value = (String) remarks.get(i);
						
			List lines = OverflowPageControl.splitStringIntoLines(value, MAX_REMARK_TEXT_WIDTH);
			
			for(int j = 0; j < lines.size(); j++) {	
				numLines++;
				
				if (numLines < formDefinition.maxLinesPerPage) {
					box.addText((String) lines.get(j));
				}else {
					
					// print what you have before starting a new page
					box.print();

					// Need to add an additional page
					pageIndexTemp++;
					setupPage(pageIndexTemp, formDefinition);
					writeHeaderFooter(pageIndexTemp, "Remarks/Agent Comments", true);
					
					// reset counter
					box = pdfDocument.getBox("Remark.Value");
					numLines = 0;
				}
			}
		}	
		
		box.print();		
	}
	
	/**
	 * Determines if the page only contains changes on a remarks field. 
	 * @param pageLevelChangeDetail is the page level change detail for the page under consideration.
	 * @return true if the only changes on the page are associated with a remarks field.
	 */
	private boolean pageContainsOnlyRemarks(PageLevelChangeDetail pageLevelChangeDetail) {
		// Remarks are handle in a special way so if the page only contains remarks we can skip it
		AggregateLevelChangeDetail[] aggLevelDetail = pageLevelChangeDetail.getAggregateLevelChangeDetails();
		for ( int ix = 0; ix < aggLevelDetail.length; ix++) {
			
			if ( aggLevelDetail[ix].hasChanges()){
				
				FieldLevelChangeDetail[] fieldChanges = aggLevelDetail[ix].getFieldLevelChangeDetails();
				// There are aggregate level changes but not field changes
				if (fieldChanges.length == 0){
					return false;
				}
				for (int j = 0; j < fieldChanges.length; j++) {
					
					BaseElement baseElement = fieldChanges[j].getBaseElement();
					if (!"textarea".equals(baseElement.getType())) {
						return false;
					}
				}
			}
		}
			
		return true;
	}
	
	/**
	 * @param pageLevelDetail
	 * @return object of type FormDefinition
	 */
	private FormDefinition getFormDefinition(PageLevelChangeDetail pageLevelDetail) {
		
		Page page = pageLevelDetail.getPage();
		
		// Use some fuzzy logic to determine which type of page format to use
		if ("dataEntry".equalsIgnoreCase(page.getType())||page.getId().indexOf("questionnaire") != -1){
				return formDefinitions[PAGE_TYPE_QUESTION];
			}
		
		
		return formDefinitions[PAGE_TYPE_GENERAL];
	}
	
	/**
	 * @param pageIndex
	 * @param formDefinition
	 * @throws APException
	 */
	private void setupPage(int pageIndex, FormDefinition formDefinition) throws APException {
		pdfDocument.addPDFpageSet(formDefinition.form);
		pdfDocument.setLayoutPages(formDefinition.layout);
		pdfDocument.positionPdfOnPage(pageIndex);
		pdfDocument.positionLayoutOnPage(formDefinition.layoutPage);	
	}
	
	/**
	 * @param pageLevelChangeDetail
	 * @param pageIndex
	 * @param formDefinition
	 * @param remarksOnly
	 * @return int
	 * @throws APException
	 */
	private int writePage(PageLevelChangeDetail pageLevelChangeDetail, int pageIndex, FormDefinition formDefinition, boolean remarksOnly) throws APException {
		int pageIndexTemp = pageIndex;
		String section = pageLevelChangeDetail.getLegend();
		
		// If the page only contains remarks don't print a header or footer. 
		if (!remarksOnly){
			writeHeaderFooter(pageIndexTemp, section, false);
		}
		
		int pdfIndex = 0;
		
		AggregateLevelChangeDetail[] aggLevelDetail = pageLevelChangeDetail.getAggregateLevelChangeDetails();
		for ( int ix = 0; ix < aggLevelDetail.length; ix++) {
			
			if ( aggLevelDetail[ix].hasChanges()){
				
				if (aggLevelDetail[ix].getEyeCatcher().length() > 0) {
					
					if (pdfIndex == formDefinition.maxLinesPerPage) {
						
						// We need to add a new page because we have reached the 1 page limit of 20 fields
						pageIndexTemp++;
						newPage(pageIndexTemp, formDefinition, section);
						
						// Reset pdf index
						pdfIndex = 0;
					}
					
					String value = getLimitedLabelText(aggLevelDetail[ix].getEyeCatcher(), VALUE_CHANGED + (pdfIndex + 1));
					printValue(value, VALUE_CHANGED + (pdfIndex + 1));
					pdfDocument.printField(aggLevelDetail[ix].getModInfoActionCodeString(), "Value.Action." + (pdfIndex + 1));
					pdfIndex++;
				}
				
				FieldLevelChangeDetail[] fieldChanges = aggLevelDetail[ix].getFieldLevelChangeDetails();
				for (int j = 0; j < fieldChanges.length; j++) {
					
					BaseElement baseElement = fieldChanges[j].getBaseElement();
					if ("textarea".equals(baseElement.getType())) {
						// Store away this text for printing later - we only need current value
						remarks.add(fieldChanges[j].getFieldLabel());
						remarks.add(" ");
						//Issue id 11370 - special characters like "><' are decoded back to display correctly in the PDF.
						remarks.add(HtmlTransliterator.decode(fieldChanges[j].getCurrentDisplayValue()));
						remarks.add(" ");
						continue;
					}
					
					if (pdfIndex == formDefinition.maxLinesPerPage) {
						
						// We need to add a new page because we have reached the 1 page limit of 20 fields
						pageIndexTemp++;
						newPage(pageIndexTemp, formDefinition, section);
						
						// Reset pdf index
						pdfIndex = 0;
					}
					
					String value = getLimitedLabelText(fieldChanges[j].getFieldLabel(), VALUE_CHANGED + (pdfIndex + 1));
					printValue(value, VALUE_CHANGED + (pdfIndex + 1));
					if (fieldChanges[j].getOriginalDataValue() != null){
						printValue(fieldChanges[j].getOriginalDisplayValue(), "Value.Original." + (pdfIndex + 1));
					}
					printValue(fieldChanges[j].getCurrentDisplayValue(), "Value.Current." + (pdfIndex + 1));
					pdfDocument.printField(fieldChanges[j].getModInfoActionCodeString(), "Value.Action." + (pdfIndex + 1));
					
					pdfIndex++;
				}
			}
		}	
		
		return pageIndexTemp;
	}
	
	/**
	 * @param pageIndex
	 * @param formDefinition
	 * @param section
	 * @throws APException
	 */
	private void newPage(int pageIndex, FormDefinition formDefinition, String section) throws APException {
		setupPage(pageIndex, formDefinition);
		writeHeaderFooter(pageIndex, section, true);
	}
	
	/**
	 * @param value
	 * @param field
	 * @return String
	 */
	private String getLimitedLabelText(String value, String field) {
		FieldDefinition fieldDef = pdfDocument.getFieldDefinition(field);
		int maxHeight = fieldDef.getMaxHeight();
		int maxWidth = fieldDef.getMaxWidth();
		
		int maxLength = maxHeight * maxWidth;
		if (value.length() > maxLength){
			return value.substring(0, maxLength - 15) + "...";
		}
		return value;
	}
	
	/**
	 * @param value
	 * @param field
	 */
	private void printValue(String value, String field) {
		PdfBox box = pdfDocument.getBox(field);
		box.addText(value);
		box.print();		
	}
	
	/**
	 * @param pageIndex
	 * @param sectionName
	 * @param pageContinuation
	 */
	private void writeHeaderFooter(int pageIndex, String sectionName, boolean pageContinuation) {
		String sectionNameTemp = sectionName;
		String value = policyChangeSummarizer.getWorkItemId();
		pdfDocument.printField(value, "ReferenceNumber");
		
		value = policyChangeSummarizer.getPolicyNumber();
		if (value != null){
			pdfDocument.printField(value, "PolicyNumber");
		}
		value = policyChangeSummarizer.getTransactionEffectiveDate();
		if (value != null){
			pdfDocument.printField(value, "DateOfChange");
		}
		value = policyChangeSummarizer.getPolicyEffectiveDate();
		if (value != null){
			pdfDocument.printField(value, "EffectiveDate");
		}
		value = policyChangeSummarizer.getPolicyExpirationDate();
		if (value != null){
			pdfDocument.printField(value, "ExpirationDate");
		}
		// Insured
		writeInsured();	
		
		// Producer
		writeProducer();
		
		if (pageContinuation){
			sectionNameTemp += " (Continued)";
		}
		pdfDocument.printField(sectionNameTemp, "Section.Heading");	
		pdfDocument.printField(Integer.toString(pageIndex), "PageNumber");
	}
	
	/**
	 * 
	 */
	private void writeInsured() {
		String name = policyChangeSummarizer.getInsuredName(IXMLConstants.VIEW_CURRENT_DOCUMENT, isCommercial);
		if (name != null){
			pdfDocument.printField(name, "Insured.Info1");
		}
		String[] address = policyChangeSummarizer.getInsuredMailingAddress(IXMLConstants.VIEW_CURRENT_DOCUMENT);
		for (int i = 0; i < address.length; i++) {
			pdfDocument.printField(address[i], "Insured.Info" + (i + 2));
		}
	}

	/**
	 * 
	 */
	private void writeProducer() {
		String name = policyChangeSummarizer.getProducerName(IXMLConstants.VIEW_CURRENT_DOCUMENT);
		if (name != null){
			pdfDocument.printField(name, "Producer.Info1");
		}
		String[] address = policyChangeSummarizer.getProducerAddress(IXMLConstants.VIEW_CURRENT_DOCUMENT);
		for (int i = 0; i < address.length; i++) {
			pdfDocument.printField(address[i], "Producer.Info" + (i + 2));
		}		
	}
}