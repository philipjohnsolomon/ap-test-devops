package com.agencyport.shared.commercial.pdf.acord125;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.pdf.IAcordConstants;
import com.agencyport.shared.pdf.PDFUtility;
/**
 * @author djenner
 *
 */
public final class PackageBox {
	
	/**
	 * 
	 */
	private PackageBox(){
		
		
	}

	/**
	 * @param pdfDocument
	 * @param apData
	 */
	public static void process(PdfDocument pdfDocument, APDataCollection apData) {
		String effDt=apData.getFieldValue("CommlPolicy.ContractTerm.EffectiveDt", "");
		String effDtFmt=effDt.substring(5,7)+"/"+effDt.substring(8,10)+"/"+effDt.substring(0,4);
		String expDt=apData.getFieldValue("CommlPolicy.ContractTerm.ExpirationDt", "");
		String expDtFmt=expDt.substring(5,7)+"/"+expDt.substring(8,10)+"/"+expDt.substring(0,4);
		pdfDocument.printField(effDtFmt,"EffectiveDate");
		pdfDocument.printField(expDtFmt,"ExpirationDate");

		String billingMethod = apData.getFieldValue("CommlPolicy.BillingMethodCd", "");
		printBillingMethod(billingMethod, pdfDocument);
		
		String paymentPlan = apData.getFieldValue("CommlPolicy.PaymentOption.PaymentPlanCd", "");
		printPaymentCode(paymentPlan, "PaymentPlan", pdfDocument);

		printAuditIndicator(pdfDocument, apData);

	}
	
	/**
	 * @param paymentPlan
	 * @param fieldName
	 * @param pdfDocument
	 */
	public static void printPaymentCode(String paymentPlan, String fieldName, PdfDocument pdfDocument) {
		String transCode = "";
		transCode = PDFUtility.translateCodeToText("codeListRef.xml", "paymentPlan", paymentPlan);
		pdfDocument.printField(transCode, fieldName);		
	}
	
	/**
	 * @param pdfDocument
	 * @param apData
	 */
	public static void printAuditIndicator(PdfDocument pdfDocument, APDataCollection apData) {
		String auditInd = apData.getFieldValue("CommlPolicy.CommlPolicySupplement.AuditInd", "");
		String frequency = apData.getFieldValue("CommlPolicy.CommlPolicySupplement.AuditFrequencyCd", "");
		
		String printFreq = PDFUtility.translateCodeToText("applInfoCodeListRef.xml", "audit", auditInd + "/" + frequency );
		if (printFreq.length() == 0){
			printFreq = "No Audit";
		}
		pdfDocument.printField(printFreq, "Audit");	
	}
	
	/**
	 * @param billingMethod
	 * @param pdfDocument
	 */
	public static void printBillingMethod(String billingMethod, PdfDocument pdfDocument) {
		if ( billingMethod.equalsIgnoreCase(IAcordConstants.AGENCY_BILLED)) {
			pdfDocument.printField(IAcordConstants.CHECKED, "AgencyBill");
		} else if ( billingMethod.equalsIgnoreCase(IAcordConstants.COMPANY_POLICY_BILLED)) {
			pdfDocument.printField(IAcordConstants.CHECKED, "DirectBill");
		} else if ( billingMethod.equalsIgnoreCase(IAcordConstants.COMPANY_ACCOUNT_BILLED)) {
			pdfDocument.printField(IAcordConstants.CHECKED, "DirectBill");
		}
	}
}
