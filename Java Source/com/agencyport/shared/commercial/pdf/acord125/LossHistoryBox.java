/*
 * Created on Mar 11, 2005
 *
 */
package com.agencyport.shared.commercial.pdf.acord125;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.APException;
import com.agencyport.shared.pdf.AdditionalDataSupport;
import com.agencyport.shared.pdf.IAcordConstants;

/**
 * Prints the Underlying Insurance Information
 * @author AgencyPort Inc.
 *
 */
public class LossHistoryBox extends AdditionalDataSupport {

	/**
	 * Default Constructor
	 */
	public LossHistoryBox() {
		super(4);
	}
	
	/**
	 * decides between the regular page and the overflow page
	 * @param pdfDocument
	 * @param apData
	 * @throws APException
	 */
	public  void process (PdfDocument pdfDocument, APDataCollection apData) throws APException{
		String[] values = null;
		
		int lossCount = apData.getCount("CommlPolicy.Loss");
		if (lossCount < 1 ) { 
			pdfDocument.printField("X", "Loss.None");
		}

		for (int i = 0; i < lossCount; i++) {
			values = getValues(apData, i);
			if (i < maxSizeAllowed){
				printInfo(pdfDocument, values, i);
			}else {
				if (i == maxSizeAllowed) { 
					additionalPageContent.add("ADDITIONAL LOSS INFORMATION : ");
					additionalPageContent.add("");
				}	
				
				formatAsAdditionalPageInfo(values, i);
				additionalPageContent.add(" ");
			}
		}

											
		printLossHistoryAttached(pdfDocument, apData);
	}
	
	/**
	 * @param pdfDocument
	 * @param apData
	 */
	public void printLossHistoryAttached(PdfDocument pdfDocument, APDataCollection apData) {
		int count = apData.getCount("FileAttachmentInfo");
		for (int i = 0; i < count; i++) {
			String type = apData.getFieldValue("FileAttachmentInfo.AttachmentTypeCd", i, "");
			if ("LHI".equals(type)) {
				pdfDocument.printField(IAcordConstants.CHECKED, "Loss.Attached");
				break;
			}
		}
	}
/**
 * Obtains the loss history
 * @param apData
 * @param i
 * @return array of Strings
 */
	public String[] getValues(APDataCollection apData, int i){
		String[] values = new String[7];
		int index = 0;
		
		values[index] = apData.getFieldValue("CommlPolicy.Loss.LossDt", i, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.LOBCd", i, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.Loss.LossDesc", i, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.Loss.ReportedDt", i, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.Loss.TotalPaidAmt.Amt", i, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.Loss.ProbableIncurredAmt.Amt", i, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.Loss.ClaimSettledInd", i, "");
				
		return values;
	}
	/**
	 * Prints the loss history information on the pdf
	 * @param pdfDocument
	 * @param values
	 * @param i
	 */
	private void printInfo(PdfDocument pdfDocument, String[] values, int i){
		int index = 0;
		
		String lossDt=values[index];
		pdfDocument.printField(lossDt.substring(5,7)+"/"+lossDt.substring(8,10)+"/"+lossDt.substring(0,4),"Loss.Date." + (i+1));
		
		index++;
		pdfDocument.printField(getLineOfBusiness(values[index]),"Loss.Line." + (i+1));
		index++;
		pdfDocument.printField(values[index],"Loss.Description." + (i+1));
		index++;
		String claimDt=values[index];
		pdfDocument.printField(claimDt.substring(5,7)+"/"+claimDt.substring(8,10)+"/"+claimDt.substring(0,4),"Loss.DateClaim." + (i+1));
		index++;
		pdfDocument.printField(values[index], "Loss.AmountPaid." + (i+1));
		index++;
		pdfDocument.printField(values[index], "Loss.AmountReserved." + (i+1));
		index++;
		String claimStatus = values[index];
		if ("0".equals(claimStatus)){
			pdfDocument.printField(IAcordConstants.CHECKED, "Loss.ClaimStatus.Open." + (i+1));
		}else if ("1".equals(claimStatus)){
			pdfDocument.printField(IAcordConstants.CHECKED, "Loss.ClaimStatus.Closed." + (i+1));
		}
	}
	/**
	 * determines the line of business 
	 * @param lobCd
	 * @return String
	 */
	private String getLineOfBusiness(String lobCd) {
		String line = "";
		
		if ("GARAG".equals(lobCd)){
			line = "Gar & Dealer";
		}else if ("CGL".equals(lobCd)){
			line = "Gen. Liab";
		}else if ("AUTOB".equals(lobCd)){
			line = "Bus. Auto";
		}else if ("CFIRE".equals(lobCd)){
			line = "Comm. Fire";
		}else if ("CPKGE".equals(lobCd)){
			line = "Comm Package";
		}else if ("CRIM".equals(lobCd) || "CRIME".equals(lobCd)){
		    line = "Crime";
        }else{
			//refactored to remove cyclomatic complexity.
			line = getLineOfBusinessContinued(lobCd, line);
		}
		return line;
	}

	/**
	 * @param lobCd
	 * @param line
	 * @return String
	 */
	private String getLineOfBusinessContinued(String lobCd, String line) {
		
		String lineTemp=line;
		 if ("INMRC".equals(lobCd)){
			lineTemp = "Comml IM";
        }else if ("PROPC".equals(lobCd)){
        	lineTemp= "Comm Prop";
        }else if ("BOP".equals(lobCd)){
        	lineTemp = "Bus. Owner";
        }else if ("UMBRC".equals(lobCd) || "UMBRL".equals(lobCd) || "EXLIA".equals(lobCd)){
        	lineTemp = "Comm. Umb.";
        }else if ("EQPFL".equals(lobCd)){
        	lineTemp = "Equip Float";	
        }else if ("EDP".equals(lobCd)){
        	lineTemp = "EDP";		
        }
		return lineTemp;
	}
	/**
	 * prints data on the overflow page
	 * @param values
	 * @param index
	 */
	private void formatAsAdditionalPageInfo(String[] values, int index){
		for (int seq = 0; seq < values.length; seq++) {
			if (seq == 0) {
				String lossDt=values[seq];
				additionalPageContent.add("  Date Of Occurrence      : " + lossDt.substring(5,7)+"/"+lossDt.substring(8,10)+"/"+lossDt.substring(0,4));
			} else if (seq == 1) {
				additionalPageContent.add("  Line                    : " + getLineOfBusiness(values[seq]));
			} else if (seq == 2) {
				additionalPageContent.add("  Description Of Occurence: " + values[seq]);
			} else if (seq == 3) {
				String claimDt=values[seq];
				additionalPageContent.add("  Date Of Claim           : " +claimDt.substring(5,7)+"/"+claimDt.substring(8,10)+"/"+claimDt.substring(0,4));
			} else if (seq == 4) {
				additionalPageContent.add("  Amount Paid             : " + values[seq]);
			} else if (seq == 5) {
				additionalPageContent.add("  Amount Reserved         : " + values[seq]);
			} else if (seq == 6) {
				String status = "Closed";
				if ("0".equals(values[seq])){
					status = "Open";
				}
				additionalPageContent.add("  Claim Status            : " + status);
			}
		}
	}
	
}
