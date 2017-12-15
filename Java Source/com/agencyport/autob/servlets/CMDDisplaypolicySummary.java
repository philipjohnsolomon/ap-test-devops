package com.agencyport.autob.servlets;//NOSONAR

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.agencyport.autob.beans.AutobPolicySummary;
import com.agencyport.fileAttachments.FileAttachmentManagerFactory;
import com.agencyport.fileAttachments.IFileAttachmentManager;
import com.agencyport.servlets.base.CMDBaseDisplayPage;
import com.agencyport.servlets.base.IBaseConstants;
import com.agencyport.shared.APException;
import com.agencyport.workitem.model.IWorkItem;

/**
 * The CMDDisplaypolicySummary class manages the instantiation of the policy summary data object and
 * for adding the file attachments to the UI. Notice the use of both the use of the overridden {@link #executeCustomReadDataAccess()} and the
 * #executeCustomReadDataAccess(Connection)} methods. This is to minimize the amount of time
 * the database connection is held open.
 */
public class CMDDisplaypolicySummary extends CMDBaseDisplayPage {
	
	 /** 
	 * {@inheritDoc}
	 */ 
	 @Override
	public void forwardNextPage()
            throws ServletException, IOException {

        setHTTPResponseFields();
        String nextPage = "../autob/policySummary.jsp";

        request.setAttribute(IBaseConstants.NEXT_PAGE, nextPage);

        RequestDispatcher dispatcher = context.getRequestDispatcher(
                IBaseConstants.SITE_SHELL);

        dispatcher.forward(request, response);

        return;
    }

	 /** 
	 * {@inheritDoc}
	 */
	 @Override
	 protected void executeCustomReadDataAccess() 
		     throws APException {
       	IWorkItem workItem = controlData.getWorkItem();		 			
   		AutobPolicySummary summary = new AutobPolicySummary(workItem, dataManager);
       	request.setAttribute("AUTOB_POLICY_SUMMARY", summary);
	 }	 
	 /** 
	 * {@inheritDoc}
	 */
	 @Override
	protected void executeCustomReadDataAccess(Connection conn) 
	     throws APException {
		 IFileAttachmentManager fileAttachmentManager = FileAttachmentManagerFactory.create(conn);
       	fileAttachmentManager.loadFileAttachmentsRoster( controlData);
        	request.setAttribute("FILE_ATTACHMENT_MANAGER", fileAttachmentManager);
	        	
	 }   
}