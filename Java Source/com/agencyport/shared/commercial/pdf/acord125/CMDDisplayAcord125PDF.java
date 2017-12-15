package com.agencyport.shared.commercial.pdf.acord125;

import java.io.IOException;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.logging.LoggingManager;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.servlets.base.CMDBaseDisplayPDF;
import com.agencyport.shared.APException;
/**
 * Provide access to WorkersComp - ACORD 139 PDF
 */
public class CMDDisplayAcord125PDF extends CMDBaseDisplayPDF {
	/**
	 * The <code>LOGGER</code>is my logger
	 */
	private static final Logger LOGGER = 
		LoggingManager.getLogger(CMDDisplayAcord125PDF.class.getPackage().getName());
	
	/**
	 * This command will not forward to any page.
	 * The PDF document will be displayed in new window.
	 */
	@Override
	public void forwardNextPage() throws ServletException, IOException {
		return;
	}
	@Override
	protected void executeCustomReadDataAccess(
    	Connection dbConnection) throws APException {
		APDataCollection data;
		data = dataManager.getAPDataCollection();
		PdfDocument pdfDocument = new PdfDocument();
		try {		
			Acord125PDFManager manager = new Acord125PDFManager(data, pdfDocument);
			manager.createPDF();
			pdfDocument.writeOutputToHTTP(response);
		}catch (APException apex){
	        LOGGER.log(Level.SEVERE,"APException ==> " 
	                + apex.getMessage(),apex);
	        return;
	    }
	}
	
	
}
