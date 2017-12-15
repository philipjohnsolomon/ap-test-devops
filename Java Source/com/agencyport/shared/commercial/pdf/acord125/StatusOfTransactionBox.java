/**
 * Mar 23, 2006  @author Agencyport Insurance Services, Inc.
 */
package com.agencyport.shared.commercial.pdf.acord125;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.pdf.IAcordConstants;

/**
 * 
 * Fills the Status of the Transaction Section in 125 PDF.
 */
public final class StatusOfTransactionBox {
	
	/**
	 * Default Constructor
	 */
	private StatusOfTransactionBox(){
		
	}
	/**
	 * The <code>QUOTE_RQ</code>
	 */
	private static final String QUOTE_RQ = "QuoteInqRq";
	
	/**
	 * @param pdfDocument
	 * @param apData
	 */
	public static void process(PdfDocument pdfDocument,
			APDataCollection apData) {
		String rootName = apData.getDocument().getRootElement().getName();
		
		if(rootName.indexOf(QUOTE_RQ) != -1){
			pdfDocument.printField(IAcordConstants.CHECKED, "Policy.Status.Quote");
		}
	}
	
	
}
