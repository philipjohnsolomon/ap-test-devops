package com.agencyport.shared.pdf;

import java.util.ArrayList;
import java.util.List;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;


public class QuestionnaireBox {	
	
	/**
	 * The explanation boxes are not present on the form, or at least we don't want to fill them in
	 */
	static public final int EXPLANATION_MODE_OVERFLOW_DIRECT = 0;
	
	/**
	 * The explanation boxes are there, but we want to always push answers to overflow
	 */
	static public final int EXPLANATION_MODE_OVERFLOW_WITH_TIP = 1;
	
	/**
	 * Try to fit the explanations in the boxes; only those that don't fit are pushed to overflow
	 */
	static public final int EXPLANATION_MODE_OVERFLOW_ASNEEDED = 2;

	/**
	 * Try to fit the explanations in the boxes; if they don't all fit, push them all to overflow
	 */
	static public final int EXPLANATION_MODE_OVERFLOW_GROUPED = 3;

	/**
	 * Trim the text to always fit in the explanation boxes
	 */
	static public final int EXPLANATION_MODE_TRUNCATED = 4;

	/**
	 * "Standard" interface assuming the static text doesn't need to be overridden
	 * @param pdfDocument
	 * @param apData
	 * @param overflowData
	 * @param questionAnswerParentPath the ACORD parent of the QuestionAnswer nodes
	 * @param GQ Array of CoverageCd & Overflow Label pairs
	 * @param explanationMode see EXPLANATION_MODE constants
	 */
	public static void process(PdfDocument pdfDocument, APDataCollection apData, List overflowData, String questionAnswerParentPath, String[][] GQ, int explanationMode) {
		QuestionnaireBox it = new QuestionnaireBox( pdfDocument, apData, questionAnswerParentPath );
		it.process(overflowData, GQ, explanationMode );
	}
	
	private PdfDocument pdfDocument;
	private APDataCollection apData;

	private String questionAnswerParentPath;
	private String questionnaireId = "Form.GeneralInformation";
	private String seeOverflowTipText = "See Overflow Page";
	private String overflowExplanationFormat = "%1. %2: %3\n ";
	private String defaultExplanation = "EXPLANATION MISSING";
	private String overflowHeader = "\nGENERAL INFORMATION EXPLANATIONS\n ";
	private String overflowFooter = null;


	protected QuestionnaireBox( PdfDocument pdfDocument_in, APDataCollection apData_in, String questionAnswerParentPath_in ) {
		this.pdfDocument = pdfDocument_in;
		this.apData = apData_in;
		this.setQuestionAnswerParentPath(questionAnswerParentPath_in);
	}

	/**
	 * Process the list of questions.
	 * 1) If EXPLANATION_MODE_OVERFLOW_GROUPED, check for overflow and fall back to ASNEEDED or WITH_TIP mode.
	 * 2) Emit the Yes/No checks and Explanations
	 * 3) Write any accumulated overflow to the overflow buffer
	 * @param overflowData
	 * @param GQ
	 * @param explanationMode
	 */
	protected void process( List overflowData, String[][] GQ, int explanationMode ) {
		
		if( EXPLANATION_MODE_OVERFLOW_GROUPED == explanationMode ) {
			
			//
			// "grouped" mode will push ALL of the explanations to overflow 
			// IF they all won't fit in the explanation boxes;
			// to support this, we walk thru all the questions, 
			// looking for the first explanation that would overflow...
			//
			
			// assume they'll all fit, overflow won't be necessary:
			explanationMode = EXPLANATION_MODE_OVERFLOW_ASNEEDED;
			
			for( int i = 0; i < GQ.length; i++ ) {
				
				if( processGQ( GQ[i][0], i+1, EXPLANATION_MODE_OVERFLOW_GROUPED, null, null )) {
					
					// if return value indicates overflow, reset our mode and break out
					explanationMode = EXPLANATION_MODE_OVERFLOW_WITH_TIP;
					break;
					
				}
			}
		}
		
		List additionalPageContent = new ArrayList();

		for( int i = 0; i < GQ.length; i++ ) {
			processGQ( GQ[i][0], i+1, explanationMode, GQ[i][1], additionalPageContent );
		}

		addOverflowContent( overflowData, additionalPageContent );
	}
	
	/**
	 * Process a particular question
	 * If explanationMode == EXPLANATION_MODE_OVERFLOW_GROUPED, no output is generated (we're only testing for overflow);
	 * otherwise emit the Yes/No checks and if Yes emit the corresponding explanation, possibly on overflow
	 * @param questionCd ACORD QuestionCd value
	 * @param qNumber 1-based question number
	 * @param explanationMode see EXPLANATION_MODE
	 * @param overflowQuestionLabel The label to be used if overflow
	 * @param additionalPageContent The buffer for accumulating overflow
	 * @return whether overflow was/would be generated
	 */
	protected boolean processGQ( String questionCd, int qNumber, int explanationMode, String overflowQuestionLabel, List additionalPageContent ) {
		
		// The overflow variable is used to track whether 
		// the explanation for a "Yes" answer should be pushed to overflow;
		// this is determined primarily by the explanationMode...
		// This is also the return value for this method.
		boolean overflow = false;
		
		String qVal = apData.getFieldValue( getQuestionAnswerYesNoCdPath( questionCd ), "" );
		
		String answerFieldId = null;
		
		boolean needToExplain = false;
		
		if (isAnswerYes(qVal)) {
			needToExplain = true;
			answerFieldId = getQuestionnaireItemYesId( qNumber );
		}
		else if (isAnswerNo(qVal)) {
			answerFieldId = getQuestionnaireItemNoId( qNumber );	
		}
			
		if( EXPLANATION_MODE_OVERFLOW_GROUPED != explanationMode ) {
			if( answerFieldId != null && answerFieldId.length() > 0 ) {
				pdfDocument.printField( IAcordConstants.CHECKED, answerFieldId );
			}
		}
		
		if ( needToExplain ) {
			
			String explanationValue = apData.getFieldValue( getQuestionAnswerExplanationPath( questionCd ), "" );
			
			if (explanationValue.trim().length() < 1 )
				explanationValue = getDefaultExplanation( questionCd );
				
			// first we check whether the mode indicates we should go directly to overflow, 
			// don't do anything with (probably non-existent) explanation box 
			overflow = (EXPLANATION_MODE_OVERFLOW_DIRECT == explanationMode);
			
			if( !overflow ) { // i.e. not going directly to overflow

				// if we get this far, we're dealing with the description box in some way; fetch it
				PdfBox box = pdfDocument.getBox( getQuestionnaireItemDescId( qNumber ) );
				
				// does explanationMode indicate we always write the tip in the explanation box?
				overflow = (EXPLANATION_MODE_OVERFLOW_WITH_TIP == explanationMode);
				
				if( !overflow ) {
					
					boolean wouldCauseOverflow = box.wouldCauseOverflow(explanationValue);
					
					if( EXPLANATION_MODE_OVERFLOW_GROUPED == explanationMode ) {
						return wouldCauseOverflow;
					}
					
					if( wouldCauseOverflow ) {
						switch( explanationMode ) {
							default:
								// whoa-- this should never happen!
							case EXPLANATION_MODE_OVERFLOW_ASNEEDED:
								overflow = true;
								break;
							case EXPLANATION_MODE_TRUNCATED:
								box.addTextTruncate(explanationValue);
								break;
						}
					}
					else {
						box.addText(explanationValue);
					}
						
				}
				
				if( overflow ) {
					// we're pushing the explanation to overflow, 
					// print the tip in the questionnaire box 
					box.addText(getSeeOverflowTipText());
				}

				box.print();

			}
			
			// overflow handling: write the question #, the label, and the explanation to the overflow page 
			if( overflow ) {
				addOverflowExplanation( additionalPageContent, qNumber, overflowQuestionLabel, explanationValue );
			}
		}
		
		return overflow;
		
	}

	protected boolean isAnswerYes(String value){
		if(value.trim().equalsIgnoreCase("YES"))
			return true;
		return false;
	}	

	protected boolean isAnswerNo(String value){
		if(value.trim().equalsIgnoreCase("NO"))
			return true;
		return false;
	}
	
	/**
	 * Add the accumulated content (if any) to the overflow buffer with header and footer
	 * @param overflowData
	 * @param additionalPageContent
	 */
	protected void addOverflowContent( List overflowData, List additionalPageContent ) {
		
		if (additionalPageContent != null && additionalPageContent.size()>0) {

			addOverflowHeader( overflowData );
			addOverflowBody( overflowData, additionalPageContent );
			addOverflowFooter( overflowData );
		}

	}

	/**
	 * Add the header to the overflow buffer
	 * @param overflowData
	 */
	protected void addOverflowHeader( List overflowData ) {
		addOverflowParagraphs( overflowData, getOverflowHeader());
	}
	
	/**
	 * Add the specified content to the overflow buffer
	 * @param overflowData
	 * @param additionalPageContent
	 */
	protected void addOverflowBody( List overflowData, List additionalPageContent ) {
		addOverflow( overflowData, additionalPageContent );
	}
	
	/**
	 * Add the footer to the overflow
	 * @param overflowData
	 */
	protected void addOverflowFooter( List overflowData ) {
		addOverflowParagraphs( overflowData, getOverflowFooter());
	}

	/**
	 * Add a "paragraph" (with lines delimited by "\n") to the overflow buffer
	 * @param overflowData
	 * @param paragraph
	 */
	protected void addOverflowParagraphs( List overflowData, String paragraph ) {
		if( paragraph != null ) {
			addOverflowLines( overflowData, paragraph.split("\n"));
		}
	}
	
	/**
	 * Add an array of text to the overlow buffer
	 * @param overflowData
	 * @param lines
	 */
	protected void addOverflowLines( List overflowData, String[] lines ) {
		for( int i = 0; i < lines.length; i++ ) {
			String ln = lines[i];
			addOverflow( overflowData, ln);
		}
		
	}
	
	protected void addOverflow( List overflowData, List more ) {
		overflowData.addAll(more);
	}
	
	protected void addOverflow( List overflowData, String more ) {
		overflowData.add(more);
	}
	
	
	/**
	 * Write an explanation to the overflow buffer
	 * @param additionalPageContent
	 * @param qNumber
	 * @param overflowQuestionLabel
	 * @param explanationValue
	 */
	protected void addOverflowExplanation( List additionalPageContent, int qNumber, String overflowQuestionLabel, String explanationValue ) {
		String format = getOverflowExplanationFormat( qNumber );
		String output = format.replaceAll( "%1", ""+qNumber ).replaceAll( "%2", overflowQuestionLabel ).replaceAll( "%3", explanationValue );
		addOverflowParagraphs( additionalPageContent, output );

	}
	
	/**
	 * Set the format used when emitting explanations on the overflow page
	 * Use the following format codes:
	 * %1 - Question Number
	 * %2 - Label
	 * %3 - Explanation
	 * @param qNumber
	 * @return
	 */
	protected void setOverflowExplanationFormat( String format ) {
		overflowExplanationFormat = format;
	}
	
	/**
	 * Get the format used when emitting explanations on the overflow page
	 * @param qNumber
	 * @return
	 */
	protected String getOverflowExplanationFormat( int qNumber ) {
		return overflowExplanationFormat;
	}

	/**
	 * Get the PDF id for a specific question YES box
	 * @param qNumber
	 * @return
	 */
	protected String getQuestionnaireItemYesId( int qNumber ) {
		return getQuestionnaireItemId( qNumber ) + ".Yes";
	}

	/**
	 * Get the PDF id for a specific question NO box
	 * @param qNumber
	 * @return
	 */
	protected String getQuestionnaireItemNoId( int qNumber ) {
		return getQuestionnaireItemId( qNumber ) + ".No";
	}

	/**
	 * Get the PDF id for a specific question description (aka explanation)
	 * @param qNumber
	 * @return
	 */
	protected String getQuestionnaireItemDescId( int qNumber ) {
		return getQuestionnaireItemId( qNumber ) + ".Desc";
	}

	/**
	 * Get the PDF id for a specific question
	 * @param qNumber
	 * @return
	 */
	protected String getQuestionnaireItemId( int qNumber ) {
		return getQuestionnaireId() + ".Q" + qNumber;
	}
	
	/**
	 * Set the PDF id for the questionnaire
	 */
	protected void setQuestionnaireId( String id ) {
		questionnaireId = id;
	}

	/**
	 * Get the PDF id for the questionnaire
	 * @return
	 */
	protected String getQuestionnaireId( ) {
		return questionnaireId;
	}
	

	/**
	 * Get the ACORD path to the YesNoCd for the specified QuestionCd
	 * @param questionCd
	 * @return
	 */
	protected String getQuestionAnswerYesNoCdPath( String questionCd ) {
		return getQuestionAnswerPath( questionCd ) + ".YesNoCd";
	}
	
	/**
	 * Get the ACORD path to the Explanation for the specified QuestionCd
	 * @param questionCd
	 * @return
	 */
	protected String getQuestionAnswerExplanationPath( String questionCd ) {
		return getQuestionAnswerPath( questionCd ) + ".Explanation";
	}
	
	/**
	 * Get the ACORD path for the specified QuestionCd
	 * @param questionCd
	 * @return
	 */
	protected String getQuestionAnswerPath( String questionCd ) {
		return getQuestionAnswerParentPath( questionCd ) + ".QuestionAnswer[QuestionCd='" + questionCd + "']";
	}
	
	/**
	 * Set the ACORD path that is the default parent for QuestionAnswer nodes
	 */
	protected void setQuestionAnswerParentPath( String path ) {
		questionAnswerParentPath = path; 
	}
	
	/**
	 * Get the ACORD path that is the parent of the specified QuestionAnswer node
	 * @param questionCd
	 * @return
	 */
	protected String getQuestionAnswerParentPath( String questionCd ) {
		return questionAnswerParentPath; 
	}
	
	/**
	 * Get the text emitted when a question is answered yes
	 * but no explanation is present in the input data collection
	 */ 
	protected void setDefaultExplanation( String explanation ) {
		defaultExplanation = explanation;
	}

	/**
	 * Get the text emitted when a question is answered yes
	 * but no explanation is present in the input data collection 
	 * @param questionCd
	 * @return
	 */
	protected String getDefaultExplanation( String questionCd ) {
		return defaultExplanation;
	}

	/**
	 * Set the text emitted in the questionnaire section 
	 * letting the reader know that the explanation is on overflow 
	 */
	protected void setSeeOverflowTipText( String text ) {
		seeOverflowTipText = text;
	}
	
	/**
	 * Get the text emitted in the questionnaire section 
	 * letting the reader know that the explanation is on overflow 
	 * @return
	 */
	protected String getSeeOverflowTipText() { // todo get the default from PdfDocument extension
		return seeOverflowTipText;
	}
	
	/**
	 * Set the text to emit at the top of questionnaire overflow
	 * Use \n to embed line breaks 
	 * @param header
	 */
	protected void setOverflowHeader( String header ) {
		overflowHeader = header;
	}
	
	/**
	 * get the text to emit at the top of questionnaire overflow
	 */
	protected String getOverflowHeader( ) {
		return overflowHeader;
	}

	/**
	 * Set the text to emit at the end of questionnaire overflow
	 * Use \n to embed line breaks
	 * @param header
	 */
	protected void setOverflowFooter( String header ) {
		overflowFooter = header;
	}
	
	/**
	 * get the text to emit at the end of questionnaire overflow
	 * @return
	 */
	protected String getOverflowFooter( ) {
		return overflowFooter;
	}

}