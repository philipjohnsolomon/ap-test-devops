/*
 * Created on Feb 28, 2006 by Mark AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.endorse.servlets;

import java.sql.Connection;

import com.agencyport.database.provider.DatabaseResourceAgent;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.logging.ExceptionLogger;
import com.agencyport.preconditions.PreConditions;
import com.agencyport.servlets.base.CMDBaseProcessDataEntry;
import com.agencyport.shared.APException;
import com.agencyport.trandef.validation.TransactionValidationManager;
import com.agencyport.trandef.validation.TransactionValidationReport;
import com.agencyport.webshared.IWebsharedConstants;
import com.agencyport.workitem.factory.WorkItemFactory;
import com.agencyport.workitem.impl.WorkItemException;
import com.agencyport.workitem.model.IWorkItem;
import com.agencyport.workitem.model.IWorkItemManager;
import com.agencyport.workitem.model.IWorkItemStatus;
import com.agencyport.workitem.model.IWorkItemStatusManager;

/**
 * The CMDProcesspolicyChangeSummary class
 */
public class CMDProcesspolicyChangeSummary extends CMDBaseProcessDataEntry {
	
	/**
	 * This method simply sets the work item status on the work item. A real implementation
	 * needs to deal with the policy admin system in both submit and cancel scenarios.
	 * @param status is the work item status to set on this work item
	 * @param conn is the database connection
	 * @throws APException 
	 */
	private void updateWorkItemStatus(String status, Connection conn) throws APException{
		
		try {
			IWorkItem workItem =  controlData.getWorkItem();
		
			IWorkItemStatusManager wism = WorkItemFactory.createWorkItemStatusManager();
			IWorkItemStatus workItemStatus = wism.get(status);
			workItem.setWorkItemStatus(workItemStatus);
		
			IWorkItemManager wim = WorkItemFactory.createWorkItemManager();
			wim.persist(conn, workItem,getSecurityProfile());
		}catch (WorkItemException e) {
		
			ExceptionLogger.log(e, this.getClass(), "updateWorkItem");
		}
	}
	
	/* (non-Javadoc)
	 * @see com.agencyport.servlets.base.APCommand#executeCustomUpdateDataAccess(int, java.sql.Connection)
	 */
	@Override
	protected void executeCustomUpdateDataAccess(int dataAccessType, Connection conn) throws APException {
		    if(isButtonPressed("Undo All Changes")){
		    	APDataCollection apData = dataManager.getAPDataCollection();
		    	apData.revertCurrentDocumentBackToOriginalDocument();
		    	PreConditions pc = dataManager.getPreConditions();
		    	if ( pc != null ){
		    		pc.updatePersistableState(apData);
		    	}
		    	dataManager.executeUpdate(conn);
		    	controlData.setTransactionValidationTrackingRecord(null);
		    	request.removeAttribute(IWebsharedConstants.TRANSACTION_VALIDATION_TRACKING_RECORD);
		    	DatabaseResourceAgent dra = new DatabaseResourceAgent(this);
		    	try{
		    		TransactionValidationManager tvm = new TransactionValidationManager(dataManager, dataManager.getAPDataCollection(), dra);
		    		TransactionValidationReport tvr = tvm.create(page.getOwningTransaction());

		    		adjustMenu(tvr, null, false, dra);
		    		adjustRosterAggregateSavedAttributes(tvr, dra);
		    	}catch (APException apex){
		       		dra.rollback(this);
		            throw apex;
				}finally{
		    		dra.closeDatabaseResources(this);
		    	}
		    }else if (isButtonPressed("Submit")){
		    	updateWorkItemStatus("TRANSFERTOADMIN", conn);
		    }else if (isButtonPressed(IWebsharedConstants.CANCEL)){
		    	updateWorkItemStatus(IWorkItemStatus.DELETE, conn);
		    }
		
	}
	/* (non-Javadoc)
	 * @see com.agencyport.servlets.base.APCommand#determineNextPage()
	 * Every button leads back to the WIP except for the undo changes button
	 *  
	 */
	@Override
	protected String determineNextPage() {
	   String nextPage = null;
	    if(isButtonPressed("Undo All Changes")){
	        nextPage = "/FrontServlet?PAGE_NAME=" + page.getId() + "&METHOD=Display"; 
	    }else {
	    	nextPage = determineSaveAndExitNextPage();
	    }
	    if ( nextPage != null ){
	    	return nextPage;
	    }else{
	    	return super.determineNextPage();
	    }
	}
	    
}
