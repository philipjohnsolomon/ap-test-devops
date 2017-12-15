package com.agencyport.shared.endorse.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.policysummary.changemanagement.PolicyChangeSummarizer;
import com.agencyport.policysummary.changemanagement.PolicyChangeSummarizerFactory;
import com.agencyport.servlets.base.CMDBaseDisplayPDF;
import com.agencyport.shared.APException;
import com.agencyport.shared.pdf.endorse.PolicyChangePDFManager;
import com.agencyport.trandef.Transaction;
import com.agencyport.trandef.TransactionDefinitionManager;
import com.agencyport.workitem.model.IWorkItem;


/**
 * The CMDDisplayPolicyChangePDF class
 */
public class CMDDisplayPolicyChangePDF extends CMDBaseDisplayPDF {
	
	/**
	 * This command will not forward to any page.
	 * The PDF document will be displayed in new window.
	 */
	@Override
	public void forwardNextPage() throws ServletException, IOException {
		return;
	}	

	/* (non-Javadoc)
	 * @see com.agencyport.servlets.base.APCommand#executeCustomReadDataAccess(java.sql.Connection)
	 */
	@Override
	protected void executeCustomReadDataAccess(Connection dbConnection) throws APException {
		APDataCollection apData;
		apData = dataManager.getAPDataCollection();
		PdfDocument pdfDocument = new PdfDocument();
		
		PolicyChangeSummarizer summary = PolicyChangeSummarizerFactory.createPCS(dataManager, null, 
				apData, apData.getMergeManager());
		IWorkItem workItem = controlData.getWorkItem(); 
		summary.setWorkItem(workItem);
		
		Transaction tran = TransactionDefinitionManager.getTransaction(workItem.getTransactionId());
		
		PolicyChangePDFManager manager = new PolicyChangePDFManager(apData, pdfDocument, summary, tran, false);
		manager.createPDF();
		pdfDocument.writeOutputToHTTP(response);
	}	
	
}
