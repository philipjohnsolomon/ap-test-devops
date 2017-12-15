package com.agencyport.shared.commercial.pdf.acord125;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.ElementPathExpression;
import com.agencyport.domXML.IdIterator;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.pdf.core.AcordPDFManager;
import com.agencyport.pdf.core.OverflowPageControl;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.preconditions.PreConditions;
import com.agencyport.preconditions.PreConditionsStore;
import com.agencyport.shared.APException;
import com.agencyport.shared.pdf.IAcordConstants;
import com.agencyport.shared.pdf.IPdfConstants;
import com.agencyport.shared.pdf.RemarksBox;

/**
 * @author AgencyPort Inc.
 * Prints the Commercial Umbrella PDF Forms (ACORD 131, ACORD 125)
 *
 */
public class Acord125PDFManager extends AcordPDFManager {

	/**
	 * The <code>NUMBER_OF_ACORD125_PAGES</code>
	 */
	protected static final int NUMBER_OF_ACORD125_PAGES = 2;

	/**
	 * The <code>locationList</code>
	 */
	private  List<LocationInfo> locationList;
	/**
	 * The <code>additionalData</code>
	 */
	private  List<String> additionalData;
	/**
	 * The <code>additionalPageList</code>
	 */
	private  List<String> additionalPageList;
	/**
	 * The <code>lineOfBusiness</code>
	 */
	private  String lineOfBusiness;
	/**
	 * The <code>preConditions</code>
	 */
	private  PreConditions preConditions;
	
	/**
	 * Method Acord125PDFManager.
	 * @param apDataIn
	 * @param pdfDocumentIn
	 */
	public Acord125PDFManager(APDataCollection apDataIn,
							  PdfDocument pdfDocumentIn) {
	
		apData = apDataIn;	
		pdfDocument = pdfDocumentIn;
		formVersion = IPdfConstants.ACORD_125_FORM;
		layoutVersion = IPdfConstants.ACORD_125_LAYOUT;
		preConditions = PreConditionsStore.getPreConditions();
		lineOfBusiness =apDataIn.getFieldValue("CommlPolicy.LOBCd", "");
	}

	/**
	 * Method Acord125PDFManager.
	 * @param apDataIn
	 * @param pdfDocumentIn
	 * @param lineOfBusinessIn
	 */
	public Acord125PDFManager(APDataCollection apDataIn,
			  PdfDocument pdfDocumentIn, String lineOfBusinessIn) {

		apData = apDataIn;	
		pdfDocument = pdfDocumentIn;
		formVersion = IPdfConstants.ACORD_125_FORM;
		layoutVersion = IPdfConstants.ACORD_125_LAYOUT;
		lineOfBusiness =apDataIn.getFieldValue("CommlPolicy.LOBCd", "");
		preConditions = PreConditionsStore.getPreConditions();
	}
	
	/**
	 * Creates a pdf file out of the form data
	 */

	@Override
	public void createPDF() throws APException {
		pdfDocument.addPDFpageSet(formVersion);
		pdfDocument.setLayoutPages(layoutVersion);

		additionalPageList = new ArrayList<String>();
		
		String controllingRateState = apData.getFieldValue("CommlPolicy.ControllingStateProvCd", "");
		if (controllingRateState.length() > 0){
			additionalPageList.add("Controlling Rate State : "  + controllingRateState);
		}
		
		writePage1();
		writePage2();
	
		printGrossRevenueAmount(apData);

		RemarksBox agentRemarks = new RemarksBox(3000,additionalPageList);
		agentRemarks.process(pdfDocument, apData,"applInformationViews.xml:RemarkText.AgentComments",
											"AGENT REMARKS",null);
		
		if ("INMRC".equalsIgnoreCase(lineOfBusiness)) {
			printInlandMarineData();
		}
		
		OverflowPageControl pageControl = new OverflowPageControl(NUMBER_OF_ACORD125_PAGES, pdfDocument, apData);
		pageControl.process(additionalPageList);
	}
	

	/**
	 * creates page1
	 * @throws APException
	 */
	private void writePage1() throws APException {
		pdfDocument.positionPdfOnPage(1);
		pdfDocument.positionLayoutOnPage(1);

		loadLocationInfo();
		PremisesBox premisesBox = new PremisesBox();
		premisesBox.loadPremisesInfo(locationList, apData);
		
		ProducerBox.process(pdfDocument, apData);
		PolicyBox.process(pdfDocument,apData, lineOfBusiness, preConditions);
		
		StatusOfTransactionBox.process(pdfDocument, apData);
		PackageBox.process(pdfDocument, apData);
		
		String currentDate = new SimpleDateFormat("MM-dd-yyyy").format(new Date());		
		pdfDocument.printField(currentDate, "formDate");
		
		ApplicantBox applicantBox = new ApplicantBox();
		applicantBox.process(pdfDocument, apData);
		if (applicantBox.isAdditionalInfoAvailable()) {
			additionalData = applicantBox.getAdditionalPageData();
			additionalPageList.addAll(additionalData);	
		}
		
		premisesBox.process(pdfDocument, apData);
		if (premisesBox.isAdditionalInfoAvailable()) {
			additionalData = premisesBox.getAdditionalPageData();
			additionalPageList.addAll(additionalData);	
		}
		
		NatureOfBusinessBox natureOfBusinessBox = new NatureOfBusinessBox();
		natureOfBusinessBox.process(pdfDocument, apData);
		if (natureOfBusinessBox.isAdditionalInfoAvailable()) {
			additionalData = natureOfBusinessBox.getAdditionalPageData();
			additionalPageList.addAll(additionalData);	
		}
		
		GeneralInfoBox generalInfoBox = new GeneralInfoBox();
		generalInfoBox.process(pdfDocument, apData);
		if (generalInfoBox.isAdditionalInfoAvailable()) {
			additionalData = generalInfoBox.getAdditionalPageData();
			additionalPageList.addAll(additionalData);	
		}		
	}
/**
 * creates page2
 * @throws APException
 */
	private void writePage2() throws APException {
		pdfDocument.positionPdfOnPage(2);
		pdfDocument.positionLayoutOnPage(2);

		PriorCarrierBox priorCarrierBox = new PriorCarrierBox();
		priorCarrierBox.process(pdfDocument, apData);
		if (priorCarrierBox.isAdditionalInfoAvailable()) {
			additionalData = priorCarrierBox.getAdditionalPageData();
			additionalPageList.addAll(additionalData);	
		}

		LossHistoryBox lossHistoryBox = new LossHistoryBox();
		lossHistoryBox.process(pdfDocument, apData);
		if (lossHistoryBox.isAdditionalInfoAvailable()) {
			additionalData = lossHistoryBox.getAdditionalPageData();
			additionalPageList.addAll(additionalData);	
		}
			
		AttachmentBox attachmentBox = new AttachmentBox();
		attachmentBox.process(pdfDocument, apData);
		if (attachmentBox.isAdditionalInfoAvailable()) {
			additionalData = attachmentBox.getAdditionalPageData();
			additionalPageList.addAll(additionalData);	
		}
		
	}
	
	/**
	 * 
	 */
	private void printInlandMarineData(){
		int[] idArrayForXPath = null;
		int additionalInterestNumber = 0;
		ElementPathExpression elementPathExpression =
            new ElementPathExpression("CommlPolicy.AdditionalInterest");
		IdIterator it = new IdIterator(elementPathExpression, apData.getName());
		String additionalInterestType = "";
		String additionalInterestName = "";
		String additionalInterestAddrLine1 = "";
		String additionalInterestAddrLine2 = "";
		String additionalInterestAddrCity = "";
		String additionalInterestAddrStateProvCd = "";
		String additionalInterestAddrPostalCd = "";
		String additionalInterestAccountNumberId = "";
		String additionalInterestClass = "";
		String iMClass = "";
		String remarks = "";
		 while (true) {
	            idArrayForXPath = (int[]) it.findNext(apData);
	            if (idArrayForXPath == null ){
	            	break;
	            }
	            additionalInterestNumber++;
	            additionalInterestType = apData.getFieldValue("CommlPolicy.AdditionalInterest.AdditionalInterestInfo.NatureInterestCd", idArrayForXPath, "");
	            additionalInterestName = apData.getFieldValue("CommlPolicy.AdditionalInterest.GeneralPartyInfo.NameInfo.CommlName.CommercialName", idArrayForXPath, "");
	            additionalInterestAddrLine1 = apData.getFieldValue("CommlPolicy.AdditionalInterest.GeneralPartyInfo.Addr.Addr1", idArrayForXPath, "");
	            additionalInterestAddrLine2 = apData.getFieldValue("CommlPolicy.AdditionalInterest.GeneralPartyInfo.Addr.Addr2", idArrayForXPath, "");
	            additionalInterestAddrCity = apData.getFieldValue("CommlPolicy.AdditionalInterest.GeneralPartyInfo.Addr.City", idArrayForXPath, "");
	            additionalInterestAddrStateProvCd = apData.getFieldValue("CommlPolicy.AdditionalInterest.GeneralPartyInfo.Addr.StateProvCd", idArrayForXPath, "");
	            additionalInterestAddrPostalCd = apData.getFieldValue("CommlPolicy.AdditionalInterest.GeneralPartyInfo.Addr.PostalCode", idArrayForXPath, "");
	            additionalInterestAccountNumberId = apData.getFieldValue("CommlPolicy.AdditionalInterest.AdditionalInterestInfo.AccountNumberId", idArrayForXPath, "");
	            additionalInterestClass = apData.getFieldValue("CommlPolicy.AdditionalInterest.@AP_CommlIMInfoRef", idArrayForXPath, "");
	            if("BuildersRiskPolicy".equalsIgnoreCase(additionalInterestClass)){
	            	additionalInterestClass = "Builders Risk - Policy";
	            }else if ("BuildersRisk".equalsIgnoreCase(additionalInterestClass)) {
	            	additionalInterestClass = "Builders Risk - Job Site";
				}else if ("Transportation".equalsIgnoreCase(additionalInterestClass)) {
	            	additionalInterestClass = "Annual Transit";
				}
	            iMClass = apData.getFieldValue("CommlPolicy.AdditionalInterest.@AP_CommlIMInfoRef", idArrayForXPath, "");
	            remarks = getRemarkText(idArrayForXPath);
	            
	            additionalPageList.add("");
	            additionalPageList.add("ADDITIONAL INTEREST : #" + (additionalInterestNumber));
	            additionalPageList.add("");
	            additionalPageList.add("Additional Interests :- ");
	            additionalPageList.add("Type                        : " + getDisplayValue(additionalInterestType, "xmlreader:inmrcCodeListRef.xml:inmrcAdditionalInterest"));
	            additionalPageList.add("Additional Interest Name    : " + additionalInterestName);
	            additionalPageList.add("Address Line 1              : " + additionalInterestAddrLine1);
	            additionalPageList.add("Address Line 2              : " + additionalInterestAddrLine2);
	            additionalPageList.add("City                        : " + additionalInterestAddrCity);
	            additionalPageList.add("State                       : " + additionalInterestAddrStateProvCd);
	            additionalPageList.add("Zip Code                    : " + additionalInterestAddrPostalCd);
	            additionalPageList.add("Reference #                 : " + additionalInterestAccountNumberId);
	            additionalPageList.add("");
	            additionalPageList.add("Interest Link To :- ");
	            additionalPageList.add("Class                       : " + additionalInterestClass);
	            
				if ((iMClass != null) && (iMClass.length() > 0)){
				
					printInLandMarineDataExtractedMethod(idArrayForXPath, iMClass, remarks);
				}  
		 }
			
	}

	/**
	 * @param idArrayForXPath
	 * @param iMClass
	 * @param remarks
	 */
	private void printInLandMarineDataExtractedMethod(int[] idArrayForXPath, String iMClass, String remarks) {
		if (!iMClass.equals(IAcordConstants.BR_COMML_IM_CLASS_CD)){
			//intentionally left empty
		}else{
			additionalPageList.add("Link                        : " + apData.getFieldValue("CommlPolicy.AdditionalInterest.@AP_LocationRef", idArrayForXPath, ""));
		}
		
		if (!iMClass.equals(IAcordConstants.CONTR_COMML_IM_CLASS_CD)){
			//intentionally left empty
			
		}else{
			additionalPageList.add("Link                        : " + apData.getFieldValue("CommlPolicy.AdditionalInterest.@AP_CommlIMPropertyInfoRef", idArrayForXPath, ""));
			
		}
		
		if (!iMClass.equals(IAcordConstants.CONTR_COMML_IM_CLASS_CD) && !iMClass.equals(IAcordConstants.BR_COMML_IM_CLASS_CD)){
			additionalPageList.add("Description                 : " + remarks);
		}
	}
	
/**
 * Prints gross annual revenue from the agency/applicant information page on the overflow page
 * @param apData
 */
	private void printGrossRevenueAmount(APDataCollection apData) {
		String revenue = apData.getFieldValue(
				"CommlPolicy.CommlPolicySupplement.CommlParentOrSubsidiaryInfo[MiscParty.MiscPartyInfo.MiscPartyRoleCd='ParentCompany'].AnnualGrossReceiptsAmt.Amt",
				"");
		if (revenue.length() != 0) {
			additionalPageList.add("MISCELLANEOUS INFORMATION :");
			additionalPageList.add(" ");
			additionalPageList.add("  Gross Annual Revenues : " + revenue);
			additionalPageList.add(" ");
		}
	}
/**
 * Loads the location information
 *
 */
	private void loadLocationInfo() {
		
		int locationsCount = apData.getCount("Location");
		locationList = (List<LocationInfo>) new ArrayList<LocationInfo>();
		
		for (int j = 0; j < locationsCount; j++) {
			LocationInfo locInfo 	= new LocationInfo();
			locInfo.stateCd 		= apData.getFieldValue("Location.Addr.StateProvCd", j, "");
			locInfo.locationRef 	= apData.getAttributeText ("Location", j, "id");
			locInfo.locationSeq 	= (j+1)+"";
			locInfo.addr1 			= apData.getFieldValue("Location.Addr.Addr1", j, "");
			locInfo.addr2 			= apData.getFieldValue("Location.Addr.Addr2", j, "");
			locInfo.city 			= apData.getFieldValue("Location.Addr.City", j, "");
			locInfo.zip 			= apData.getFieldValue("Location.Addr.PostalCode", j, "");
			locInfo.cityLimits 		= apData.getFieldValue("Location.RiskLocationCd", j, "");
			locInfo.taxCode 		= apData.getFieldValue("Location.TaxCodeInfo[TaxTypeCd='Prop'].TaxCd", j, "");
			locInfo.fireDistrict 	= apData.getFieldValue("Location.FireDistrict", j, "");
			locationList.add(locInfo);
		}
	}

	/**
	 * get the display value for a specific value(key) from a optionList
	 * @param key
	 * @param target
	 * @return String
	 */
	public String getDisplayValue(String key, String target){
		return OptionsMap.lookupDisplayValue(key, target, "", null);
	}
	
	/**
	 * get RemarkText of AddtionalInterest page
	 * @param idArrayForXPath
	 * @return String
	 */
	public String getRemarkText(int[] idArrayForXPath){
		String remarksIdRef = apData.getFieldValue("CommlPolicy.AdditionalInterest.@id", idArrayForXPath, "");
		String path = "RemarkText[@IdRef=\"" + remarksIdRef + "\"]" ;
		return apData.getFieldValue(path, "");
	}
	
}
