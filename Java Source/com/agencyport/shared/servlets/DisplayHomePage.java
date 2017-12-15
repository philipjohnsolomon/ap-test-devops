/*
 * Created on Apr 6, 2004
 *
 */
package com.agencyport.shared.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.agencyport.jsp.JSPHelper;
import com.agencyport.locale.ILocaleConstants;
import com.agencyport.locale.IResourceBundle;
import com.agencyport.locale.ResourceBundleManager;
import com.agencyport.logging.ExceptionLogger;
import com.agencyport.servlets.base.APBaseServlet;
import com.agencyport.servlets.base.IBaseConstants;
import com.agencyport.shared.APException;
import com.agencyport.shared.locale.ISharedLocaleConstants;

/**
 * The DisplayHomePage class displays the home page.
 */
public class DisplayHomePage extends APBaseServlet {

    /**
	 * The <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 93021930219309128L;

	/* (non-Javadoc)
     * @see javax.servlet.http.HttpServlet#doPost(
     * javax.servlet.http.HttpServletRequest, 
     * javax.servlet.http.HttpServletResponse)
     */
	@Override
    public void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException{
    	if ( verifySystem(request, response) ) {  		
    		try {
				JSPHelper jspHelper = JSPHelper.get(request);
				request.setAttribute("urlLinks", jspHelper.getNewWorkItemLinks(false));
				IResourceBundle sharedRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ISharedLocaleConstants.SHARED_BUNDLE);
				IResourceBundle coreProductRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
				request.setAttribute("SHARED_RB", sharedRB.getEntries());
				request.setAttribute("CORE_RB", coreProductRB.getEntries());
			} catch (APException e) {
				ExceptionLogger.log(e, this.getClass(), "doPost");
				APBaseServlet.displayApplicationErrorPage(getServletContext(),
						request, response, e, null);
				return;
			}
            request.setAttribute(IBaseConstants.NEXT_PAGE, "../home/home.jsp");
            forwardNextPage(request, response, IBaseConstants.SITE_SHELL);
    	}
    }

}
