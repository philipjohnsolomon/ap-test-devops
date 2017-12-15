package com.agencyport.shared.commercial.pdf.acord125;

import java.util.Map;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.preconditions.PreConditions;
import com.agencyport.shared.pdf.IAcordConstants;
import com.agencyport.webshared.DynamicAggregateManager;
/**
 * @author djenner
 *
 */
public final class PolicyBox {
	
	/**
	 * Default Constructor
	 */
	private PolicyBox(){
		
		
	}

	/**
	 * @param pdfDocument
	 * @param apData
	 * @param lineOfBusiness
	 * @param preConditions
	 */
	public static void process(PdfDocument pdfDocument, APDataCollection apData, String lineOfBusiness, 
			PreConditions preConditions) {
		
		APDataCollection pcData = preConditions.getDataCollection();
		String listEntry = "xmlreader:codeListRef.xml:commlLineOfBusinessCodes";
		
		String lobDesc  = OptionsMap.lookupDisplayValue(lineOfBusiness, listEntry, "", null);		
		
		pdfDocument.printField(lobDesc, "Policy.PolicyName");
		
		if("CPKGE".equalsIgnoreCase(lineOfBusiness) || 
				"PKG".equalsIgnoreCase(lineOfBusiness)){
			Map indicatorsMap = DynamicAggregateManager.generateChosenIndicatorsMap(apData);
			if(indicatorsMap == null){
				return;
			}
			
			
			if(indicatorsMap.containsKey("CPP_PROPC_indicator")){
				printSelectedLOBCodes(pdfDocument, "PROPC");
			}
			if(indicatorsMap.containsKey("CPP_CGL_indicator")){
				printSelectedLOBCodes(pdfDocument, "CGL");
			}
			
		}else {	
			
			printSelectedLOBCodes(pdfDocument, lineOfBusiness);
			if ("INMRC".equalsIgnoreCase(lineOfBusiness)) {
				printIMClasses(pdfDocument, pcData);
			}
		}
	}
	
	/**
	 * @param pdfDocument
	 * @param preConditionData
	 */
	private static void printIMClasses(PdfDocument pdfDocument, APDataCollection preConditionData){
		
		if (preConditionData.getFieldValue(IAcordConstants.ANNUAL_TRANSIT, "").length() > 0) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.5");
		}
		if (preConditionData.getFieldValue(IAcordConstants.BUILDERS_RISK, "").length() > 0) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.7");
		}
		if (preConditionData.getFieldValue(IAcordConstants.COMPUTER_EQUIPMENT, "").length() > 0) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.8");
		}
		if (preConditionData.getFieldValue(IAcordConstants.CONTRACTORS_EQUIPMENT, "").length() > 0) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.6");
		}
		if (preConditionData.getFieldValue(IAcordConstants.INSTALLATION, "").length() > 0) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.7");
		}		
	}
	/**
	 * @param pdfDocument
	 * @param lineOfBusiness
	 */
	private static void printSelectedLOBCodes(PdfDocument pdfDocument, String lineOfBusiness){
//		 indicates sections attached. (kaushik .. default to Umbrella?)
		if ("UMBRL".equalsIgnoreCase(lineOfBusiness) || 
				"EXLIA".equalsIgnoreCase(lineOfBusiness) ||
				"UMBRC".equalsIgnoreCase(lineOfBusiness)) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.16");
		}else if ("PROPC".equalsIgnoreCase(lineOfBusiness)) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.1");
		}else if ("CGL".equalsIgnoreCase(lineOfBusiness)) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.9");
		}else if("AUTOB".equalsIgnoreCase(lineOfBusiness)) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.10");
		}else if("GARAG".equalsIgnoreCase(lineOfBusiness)) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.12");
		}else if("CRIME".equalsIgnoreCase(lineOfBusiness)) {
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Section.4");
		}
	}
}