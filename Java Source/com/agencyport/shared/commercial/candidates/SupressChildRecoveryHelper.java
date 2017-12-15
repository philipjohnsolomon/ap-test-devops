/**
 * Nov 21, 2006  @author Sathish / Agencyport Insurance Services, Inc.
 */
package com.agencyport.shared.commercial.candidates;

import com.agencyport.data.DataManager;
import com.agencyport.data.IndexManager;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.domXML.Index;
import com.agencyport.shared.APException;

/**
 * @author Sathish
 * Generic Helper to suppress the children from being recovered automatically by the framework, when the parent is recovered.
 * This helper is applicable only to Endorsement scenarios.
 * The suppression works by letting the framework removing all the children by default and we will invoke this helper 
 * to remove each of the child that we don't want to have.
 * Usage: 1. Use this helper in the method executeCustomPostDataStaging() in the class that extends CMDBaseProcessRosterRecover.
 * 		  While calling the helper, pass the Parent XPath(typically this is the Roaster Source), attribute thats used to uniquely 
 * 		  identify the aggregate and the child's XPath (only the portion after the parent's name, not the fully qualified XPath)
 *		  2. If there are multiple child aggregates, then call the helper with the string array of child XPaths 
 *			(We need to do this till we add some intelligence to automatically discover the children and delete them)
 *		 
 */
public class SupressChildRecoveryHelper {
		
	/**
	 * The <code>dataManager</code>is a private DataManager class object.
	 */
	private DataManager dataManager = null;
	
	/**
	 * @param dataManager
	 * @throws com.agencyport.shared.APException
	 */
	public SupressChildRecoveryHelper(DataManager dataManager) throws APException {
		init(dataManager);		
	}

	/**
	 * @param dataManager
	 */
	private void init(DataManager dataManager){
		this.dataManager = dataManager;
	}
	
	/**
	 * Suppress all the given children
	 * @param parentXPath	   The Aggregate that is being recovered.
	 * @param parentSearchAttr The attribute that can identify the parent aggregate
	 * @param childXPaths	   The list of child aggregates that needs to be removed	
	 * @throws APException
	 */
	public void supressChildren(String parentXPath,
			String parentSearchAttr, 
			String[] childXPaths)throws APException{
		
		for (int i = 0; i < childXPaths.length; i++){
			supressChild(parentXPath, parentSearchAttr, childXPaths[i]);
		}
	}
	
	/**
	 * Suppress one child at a time
	 * @param parentXPath		The Aggregate that is being recovered.
	 * @param parentSearchAttr	The attribute that can identify the parent aggregate
	 * @param childXPath		The child aggregates that needs to be removed
	 * @throws APException
	 */
	public void supressChild(String parentXPath,
								String parentSearchAttr, 
								String childXPath)throws APException{
    
		IndexManager ixMgr = dataManager.getIndexManager();
		APDataCollection apData = (APDataCollection) dataManager
									.getAPDataCollection();

		int save = apData.changeViewType(ixMgr.getViewTypeForIndex());
		try{		
			ixMgr.setViewTypeForIndex(IXMLConstants.VIEW_ORIGINAL_DOCUMENT);
			
			// Assumption that the last entry made into the index manager
	    	// is the one that we want to recover.
			Index entry = ixMgr.getLastEntry();
			
	    	// Switch to the document view for which this index entry applies -
	    	// Typically this should be the original document view
			apData.changeViewType(ixMgr.getViewTypeForIndex());
			
			String searchValue = apData.getFieldValue(parentXPath + ".@"  + parentSearchAttr, entry.getIdArray(), "");

			//Switching the document view to the current document view. 
	    	dataManager.getIndexManager().setViewTypeForIndex(IXMLConstants.VIEW_CURRENT_DOCUMENT);
	   	
	    	apData.changeViewType(save);
	    	int childCount = apData.getCount(parentXPath + "[@" + parentSearchAttr + "='" + searchValue + "']." + childXPath);
	    	
	    	// We do not want to recover the children when the parent is recovered
	    	for(int i= childCount-1; i>=0; i--){
	    		String fullXPath = parentXPath + "[@" + parentSearchAttr + "='" + searchValue + "']." + childXPath + "[position()=@id]";
	    		
	    		apData.deleteElement(fullXPath, i);
	    	}	    	
		}finally{
			apData.changeViewType(save);
			ixMgr.setViewTypeForIndex(save);
			
		}

	}
}

