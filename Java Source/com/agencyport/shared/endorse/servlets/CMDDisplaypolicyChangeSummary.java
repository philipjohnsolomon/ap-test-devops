package com.agencyport.shared.endorse.servlets;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.widgets.PolicyType;
import com.agencyport.policysummary.changemanagement.PolicyChangeSummarizer;
import com.agencyport.policysummary.changemanagement.PolicyChangeSummarizerFactory;
import com.agencyport.servlets.base.CMDBaseDisplayPage;
import com.agencyport.servlets.base.IBaseConstants;
import com.agencyport.shared.APException;
import com.agencyport.webshared.IWebsharedConstants;


/**
 * The CMDDisplaypolicyChangeSummary class is an example on how to prepare a 
 * policy change summary object.
 */
public class CMDDisplaypolicyChangeSummary extends CMDBaseDisplayPage {

     /* (non-Javadoc)
     * @see com.agencyport.servlets.base.APCommand#forwardNextPage()
     * Forwards to appropriate
     */
    /** 
     * {@inheritDoc}
     */ 
	@Override
    public void forwardNextPage()
            throws ServletException, IOException {

        setHTTPResponseFields();
        APDataCollection apData = (APDataCollection) dataBundle.get(IWebsharedConstants.APDATACOLLECTION); 
        String nextPage = "../shared/endorse/persPolicyChangeSummary.jsp";
        PolicyType policyType = new PolicyType(apData);
        
        if (policyType.getPolicyType() == PolicyType.COMMERCIAL_POLICY_TYPE){
        	nextPage = "../shared/endorse/commlPolicyChangeSummary.jsp";
        }
        request.setAttribute(IBaseConstants.NEXT_PAGE, nextPage);
        
        RequestDispatcher dispatcher = context.getRequestDispatcher(
                IBaseConstants.SITE_SHELL);
        
        dispatcher.forward(request, response);
    }
     
     /* (non-Javadoc)
     * @see com.agencyport.servlets.base.APCommand#executeCustomReadDataAccess(java.sql.Connection)
     * This gets the current work item, creates the appropriate PolicyChangerSummarizer
     * instance and then bind that instance to the request as an attribute for use
     * by the custom jsp page. 
     */
	@Override
    protected void executeCustomReadDataAccess(Connection conn) 
     	throws APException {
    	
		APDataCollection apData = (APDataCollection) dataBundle.get(IWebsharedConstants.APDATACOLLECTION);
		PolicyChangeSummarizer summary = PolicyChangeSummarizerFactory.createPCS(dataManager, null, 
				apData, apData.getMergeManager());
		summary.setWorkItem(controlData.getWorkItem());
		summary.prepareForView(request, page);
     }
	
} 