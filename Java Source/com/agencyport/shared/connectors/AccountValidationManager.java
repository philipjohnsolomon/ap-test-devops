/*
 * Created on Sept 13, 2014 by zhe AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.connectors;

import com.agencyport.account.AccountManagementFeature;
import com.agencyport.account.AccountRelationshipManager;
import com.agencyport.connector.ConnectorDataBundle;
import com.agencyport.connector.IConnectorConstants;
import com.agencyport.connector.Outcome;
import com.agencyport.connector.impl.ConnectorManager;
import com.agencyport.id.Id;
import com.agencyport.locale.IResourceBundle;
import com.agencyport.locale.ResourceBundleManager;
import com.agencyport.shared.APException;
import com.agencyport.shared.locale.ISharedLocaleConstants;
import com.agencyport.workitem.model.ILOBWorkItem;
import com.agencyport.workitem.model.IWorkItem;
import com.agencyport.workitem.model.WorkItemType;

/**
 * AccountValidationManager checks if a work item has an associated account
 * 
 */
public class AccountValidationManager extends ConnectorManager {

	private boolean postProcess = true;

	/**
	 * constructor
	 */
	public AccountValidationManager() {
		
	}

	/** 
     * {@inheritDoc}
    */
    @Override
	public Outcome execute(ConnectorDataBundle dataBundle) throws APException {
		
    	if(AccountManagementFeature.get().isOn() && AccountManagementFeature.get().isEnforced()){
    		
    		IWorkItem workItem = dataBundle.getControlData().getWorkItem();
    		Id accountId = ILOBWorkItem.NULL_ACCOUNT_ID;
    		if(null != workItem && WorkItemType.REGULAR_LOB_WORK_ITEM_TYPE.equals(workItem.getWorkItemType())){			
    			AccountRelationshipManager accountManager = new AccountRelationshipManager();
    			accountId =  accountManager.getAccountForWorkItem(workItem.getWorkItemId());			
    		}
    		if(ILOBWorkItem.NULL_ACCOUNT_ID.equals(accountId)){

				IResourceBundle sharedRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ISharedLocaleConstants.SHARED_BUNDLE);
				this.getMessageMap().addMessage(
						IConnectorConstants.MESSAGE_ERROR_LITERAL, 
						null,
						null, 
						sharedRB.getString("message.workitem.account.validation")
						); 
				postProcess = false;
				return Outcome.CONDITIONS_MET;
    		}
    	}
		return Outcome.CONDITIONS_NOT_MET;
	}

    /** 
     * {@inheritDoc}
    */
    @Override
	public boolean postProcess(ConnectorDataBundle dataBundle) {
		return postProcess;
	}

}
