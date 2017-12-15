/*
 * Created on Mar 4, 2004
 *
 */
package com.agencyport.shared.servlets;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.agencyport.database.DatabaseAgent;
import com.agencyport.logging.LoggingManager;
import com.agencyport.product.install.InstallerConstants;
import com.agencyport.product.install.database.DatabaseVerifier;
import com.agencyport.shared.APException;
import com.agencyport.utils.AppProperties;
import com.agencyport.webshared.APSession;
import com.agencyport.servlets.base.APBaseServlet;

/**
 * The EntryPointServlet determines what servlet should be invoked when the request consists of only the context path, AgencyPortal/ 
 * for example.  There are three possible redirects that can take place
 *  1) If the Installer is enabled, and the {@link DatabaseVerifier#verifyDatabaseExists() database is not initialized}, there will be a redirect to the Install servlet
 *  2) A non null session results in a redirect to the DisplayHomePage
 *  3) All other cases are sent to the DisplayLogonForm
 */
public class EntryPointServlet extends APBaseServlet {
	
	/**
	 * The <code>LOGGER</code> for this class.
	 */
	private static final Logger LOGGER = LoggingManager.getLogger(EntryPointServlet.class.getName());
	
	/**
	 * The <code>serialVersionUID</code>is the serial version id.
	 */
	private static final long serialVersionUID = -2738248734422846004L;
	

	/**
	 * {@inheritDoc}
	 */
	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public void doPost(HttpServletRequest request, 
						HttpServletResponse response)
					throws ServletException, IOException {
		
		try {
			if ( verifySystem(request, response)){
				
				LOGGER.info(this.getClass().getSimpleName() + "is engaged for request " + request.getRequestURL() + ". Determining where to route request.");
				
				APSession session = APSession.getExistingSession(request, false);
				
				if(AppProperties.getAppProperties().getTrueFalseBooleanProperty(InstallerConstants.INSTALLER_ENABLED_PROPERTY, false)){
					DatabaseVerifier dbverifier = DatabaseVerifier.getInstance();
					
					LOGGER.info("Installer is enabled (" + InstallerConstants.INSTALLER_ENABLED_PROPERTY + " application property). Checking to see if database is already installed.");
					if (!dbverifier.verifyDatabaseExists()){
						LOGGER.info("Database is either not installed or the " + DatabaseAgent.DATABASE_AGENT_CLASS_NAME + " property is not set, redirecting to installer Servlet.");
						sendRedirect(request, response, "/Install");
						return;
					} 
				}
				if (session != null) {
					LOGGER.info("Existing session found, redirecting to Home page. ");
					sendRedirect(request, response, "/DisplayHomePage");
					return;
					
				} else {
					LOGGER.info("No session found and no installer to load, redirecting to Logon page. ");
					sendRedirect(request, response, "/DisplayLogonForm");
					return;
				}
			}
		} catch (APException e) {
			LOGGER.log(Level.FINE,e.getMessage(),e);
			throw new ServletException(e.getMessage());

		}
	}
	
	/**
	 * Sends a redirect to the desired toPath
	 * @param request
	 * @param response
	 * @param toPath the path to redirect to, relative to context root. 
	 * @throws IOException if the response cannot process the redirect URL
	 */
	private void sendRedirect(HttpServletRequest request, HttpServletResponse response, String toPath)  throws IOException{
		StringBuilder relativePath = new StringBuilder();
		relativePath.append(request.getContextPath());
		
		relativePath.append(toPath);
		LOGGER.fine("Sending redirect to path: " + relativePath);
		response.sendRedirect(relativePath.toString());
		
	}
}
