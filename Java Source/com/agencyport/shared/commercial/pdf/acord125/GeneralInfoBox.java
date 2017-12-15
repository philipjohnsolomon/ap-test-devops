/*
 * Created on Mar 11, 2005
 *
 */
package com.agencyport.shared.commercial.pdf.acord125;

import java.util.List;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.APException;
import com.agencyport.shared.pdf.AdditionalDataSupport;
import com.agencyport.shared.pdf.IAcordConstants;
import com.agencyport.shared.pdf.RemarksBox;

/**
 * @author AgencyPort Inc.
 *
 */
public class GeneralInfoBox  extends AdditionalDataSupport{

	/**
	 * Default Constructor
	 */
	public GeneralInfoBox() {
		super(0);
	}
	/**
	 * Prints the General Information Questionnaire
	 * @param pdfDocument
	 * @param apData
	 * @throws APException
	 */
	public void process(PdfDocument pdfDocument, APDataCollection apData) throws APException{
		String answer;
		
		answer = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL34\"].YesNoCd", "");	
		if (answer.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd1a" + answer);		
		}
		answer = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL35\"].YesNoCd", "");
		if (answer.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd1b" + answer);		
		}
		answer = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL47\"].YesNoCd", "");
		if (answer.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd2" + answer);		
		}
		answer = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL41\"].YesNoCd", "");
		if (answer.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd3" + answer);		
		}
		answer = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL39\"].YesNoCd", "");
		if (answer.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd4" + answer);		
		}
		answer = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL22\"].YesNoCd", "");
		if (answer.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd5" + answer);		
		}
		answer = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL06\"].YesNoCd", "");
		if (answer.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd6" + answer);		
		}
		answer = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL07\"].YesNoCd", "");
		//refactored to reduce Cyclomatic complexity
		processContinued(pdfDocument, apData, answer);
		RemarksBox generalInfoRemarks = new RemarksBox(105,(List)additionalPageContent);
		generalInfoRemarks.process(pdfDocument, apData,"applInformationViews.xml:RemarkText.Questionnaire",
									"GENERAL INFORMATION REMARKS","Remarks");
		
	}
	/**
	 * @param pdfDocument
	 * @param apData
	 * @param answer
	 */
	private void processContinued(PdfDocument pdfDocument, APDataCollection apData, String answer) {
		
		String answerTemp = answer;
		if (answerTemp.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd7" + answerTemp);		
		}
		answerTemp = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL08\"].YesNoCd", "");
		if (answerTemp.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd8" + answerTemp);		
		}
		answerTemp = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL09\"].YesNoCd", "");
		if (answerTemp.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd9" + answerTemp);		
		}
		answerTemp = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL14\"].YesNoCd", "");
		if (answerTemp.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd10" +answerTemp);		
		}
		answerTemp = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"GENRL40\"].YesNoCd", "");
		if (answerTemp.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd11" +answerTemp);	
		}
		if ("YES".equals(answerTemp)) {
			answerTemp = apData.getFieldValue(
					"CommlPolicy.AdditionalInterest[AdditionalInterestInfo.NatureInterestCd='TR']" + 
					".GeneralPartyInfo.NameInfo.CommlName.CommercialName", "");
			if (answerTemp.length() > 0){
				pdfDocument.printField(answerTemp,
						"CommlPolicy.AdditionalInterest[AdditionalInterestInfo.NatureInterestCd='TR']" + 
						".GeneralPartyInfo.NameInfo.CommlName.CommercialName");			
		}
		}
		answerTemp = apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd=\"CUMBR17\"].YesNoCd", "");
		if (answerTemp.length() > 0){
			pdfDocument.printField(IAcordConstants.CHECKED,
					"CommlPolicy.QuestionAnswer.QuestionCd.YesNoCd12" + answerTemp);		
		}
	}
}
