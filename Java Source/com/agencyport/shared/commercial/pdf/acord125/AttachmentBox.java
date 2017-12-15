/*
 * Created on Mar 11, 2005
 *
 */
package com.agencyport.shared.commercial.pdf.acord125;


import java.util.logging.Level;
import java.util.logging.Logger;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.logging.LoggingManager;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.pdf.AdditionalDataSupport;
import com.agencyport.shared.pdf.PDFUtility;

/**
 * Prints the Underlying Insurance Information
 * @author AgencyPort Inc.
 *
 */
public class AttachmentBox extends AdditionalDataSupport {
	
	/**
	 * Default Constructor
	 */
	public AttachmentBox() {
		super(0);
	}
	/**
	 * The <code>LOGGER</code> is my Logger
	 */
	private static final Logger LOGGER =
		LoggingManager.getLogger(AttachmentBox.class.getPackage().getName());
	/**
	 * @param pdfDocument
	 * @param apData
	 */
	public  void process (PdfDocument pdfDocument, APDataCollection apData) {
		String[] values = null;
		String documentType="";
		
		int attachCount = apData.getCount("FileAttachmentInfo");
		for (int i =0; i< attachCount; i++) {
			values = getValues(apData, i);
			
			documentType = apData.getFieldValue("FileAttachmentInfo.AttachmentTypeCd", i, "");
			LOGGER.log(Level.FINE,documentType);
			    
		    if(attachCount > 1){
				if( i == 0){
					pdfDocument.printField("See Additional Pages.", "Attachment.File");
					pdfDocument.printField("X", "Attachment.Avalable");
				}
		    
				 if (i == maxSizeAllowed) {
					additionalPageContent.add("ADDITIONAL ATTACHMENTS INFORMATION : ");
					additionalPageContent.add(" ");
				}	
				 
				formatAsAdditionalPageInfo(values, i);
				additionalPageContent.add("  Document Type  : " + documentType);
				additionalPageContent.add(" ");
			}else{
				pdfDocument.printField("See Additional Pages.", "Attachment.File");
				pdfDocument.printField("X", "Attachment.Avalable");
				
				additionalPageContent.add("ADDITIONAL ATTACHMENTS INFORMATION : ");
				additionalPageContent.add(" ");
				
				formatAsAdditionalPageInfo(values, i);
				additionalPageContent.add("  Document Type  : " + documentType);
				additionalPageContent.add(" ");		    	
		    }
		}
		    
	}
	

	/**
	 * @param apData
	 * @param i
	 * @return String Array
	 */
	public String[] getValues(APDataCollection apData, int i){
		String[] values = new String[2];
		int index = 0;
		
		values[index] = apData.getFieldValue("FileAttachmentInfo.AttachmentFilename", i, "");
		index++;
		values[index] = apData.getFieldValue("FileAttachmentInfo.AttachmentTypeCd", i, "");
		
				
		return values;
	}
	

	
	/**
	 * @param values
	 * @param index
	 */
	private void formatAsAdditionalPageInfo(String[] values, int index){
		additionalPageContent.add("  File           : " + values[0]);
	}
	
	/**
	 * @param cd
	 * @return String
	 */
	public static String getDocumentTypeTextFromCode(String cd){
		return PDFUtility.translateCodeToText("commautoCodeListRef.xml", "commAutoDocumentType", cd);
	}

	
}
