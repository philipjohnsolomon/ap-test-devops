/*
 * Created on Dec 5, 2006 by Sathish, AgencyPort Insurance, Inc.
 *
 *
 * 5/27/09 - Alex Gillmor
 */
package com.agencyport.shared.utils;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import com.agencyport.data.DataManager;
import com.agencyport.data.IndexManager;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.ElementPathExpression;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.shared.APException;
import com.agencyport.webshared.ControlData;
import com.agencyport.webshared.HTMLDataContainer;
import com.agencyport.webshared.IWebsharedConstants;

/**
 * 
 * This helper class returns a coverage present in the AP Data Collection from a list of allowed option values.
 * 
 * e.g.: One of the following values are allowed for EXNON coverages. G or N, P or E, I or S
 *  It is assumed that there will be always only one of the allowed values will be present in the APData.
 * 


 *
 */
public  class OptionHelper {
	
	/**
	 * The <code>htmlDataContainer</code>is a private object of HTMLDataContainer.
	 */
	private HTMLDataContainer htmlDataContainer;
	/**
	 * The <code>apData</code>is a private Object of APDataCollection Object.
	 */
	private APDataCollection apData;
	/**
	 * The <code>controlData</code> is a private Object of ControlData class.
	 */
	private ControlData		 controlData;
	/**
	 * The <code>dataManager</code>is a private Object of DataManager class.
	 */
	private DataManager 	 dataManager;
	
	/**
	 * 
	 */
	public OptionHelper(){
		
	}
	
	/**
	 * @param dataBundle
	 * @throws APException
	 */
	public void init(Map dataBundle) throws APException{
		
		this.htmlDataContainer = (HTMLDataContainer) dataBundle.get(IWebsharedConstants.HTML_DATA_CONTAINER);
		this.apData 			  = (APDataCollection) dataBundle.get(IWebsharedConstants.APDATACOLLECTION);	
		this.controlData 	  = (ControlData) dataBundle.get(IWebsharedConstants.CONTROL_DATA);
		this.dataManager 	  = (DataManager)controlData.get(IWebsharedConstants.DATAMANAGER);
		
	}
	
	/**
	 * @param controlData
	 * @param apData
	 * @throws APException
	 */
	public void init(ControlData controlData, APDataCollection apData) throws APException{
		
		this.apData 		  = apData;	
		this.controlData 	  = controlData;
		this.dataManager 	  = (DataManager)controlData.get(IWebsharedConstants.DATAMANAGER);
		
	}
	

	/**
	 * @param dataManager
	 * @param apData
	 */
	public void init(DataManager dataManager, APDataCollection apData){
		this.apData 		= apData; 			  	
		this.dataManager 	= dataManager;
	}
	
	/**
	 * @param baseXPath
	 * @param predicateXPath
	 * @param allowedValues
	 * @return String
	 */
	public String getOptionValue(String baseXPath, String predicateXPath, String[] allowedValues){
		return getOptionValue(baseXPath, predicateXPath , allowedValues, IXMLConstants.VIEW_CURRENT_DOCUMENT);
	}
	
	/**
	 * @param xPathWithPredicates
	 * @return String
	 */
	private String getXPathWithOutPredicates(String xPathWithPredicates){
		//input: PersAutoLineBusiness.PersVeh.Coverage[CoverageCd='EXNON'].Option
		//output: PersAutoLineBusiness.PersVeh.Coverage.Option
		
		ElementPathExpression inXpathExpression = new ElementPathExpression(xPathWithPredicates);
		return inXpathExpression.getExpressionWithOnlyElementHierarchy();
		
		
	}
	
	/**
	 * @param xPathWithPredicates
	 * @param knownIds
	 * @return int array
	 */
	private int[] getIDArryForXPath(String xPathWithPredicates, int[] knownIds){

		ElementPathExpression inXpath = new ElementPathExpression(xPathWithPredicates);
		return apData.normalizeXPathExpressionToIdArray(inXpath, knownIds);

		
	}
	
	/**
	 * 
	 * @param baseXPath 
	 * @param predicateXPath 
	 * @param allowedValues 
	 * @param viewType 
	 * @return String
	 */
	public String getOptionValue(String baseXPath, String predicateXPath ,String[] allowedValues, int viewType){
		
		int saveView   = apData.getViewType();
		//default value
		String retVal  = ""; 

		try {
			//Change to correct view type
			if (viewType != saveView){
				apData.changeViewType(viewType);
			}
			
			//Search on the given XPath
			for (int i = 0; i < allowedValues.length; i++){
				int count = apData.getCount(baseXPath + getPredicate(predicateXPath, allowedValues[i]));
				if (count > 0){
					retVal = allowedValues[i];
					//stop searching
					break;
				}				
			}
		} finally {
			apData.changeViewType(saveView);
		}
		
		return retVal;
	}
	
	/**
	 * @param rosterSource
	 * @param middleXPath
	 * @param predicateXPath
	 * @param allowedValues
	 * @return String
	 */
	public String getOptionValue(String rosterSource, String middleXPath, String predicateXPath ,String[] allowedValues){
	
		return getOptionValue(rosterSource, middleXPath, predicateXPath , allowedValues, IXMLConstants.VIEW_CURRENT_DOCUMENT);
		
	}
	
	/**
	 * For roaster page type
	 * @param rosterSource 
	 * @param middleXPath 
	 * @param predicateXPath 
	 * @param allowedValues 
	 * @param viewType 
	 * @return String
	 */
	public String getOptionValue(String rosterSource, String middleXPath, String predicateXPath ,String[] allowedValues, int viewType){
		/*
		ex:
		PersAutoLineBusiness.PersVeh
		Coverage[CoverageCd='EXNON'].Option
		OptionCd
		
		*/
		
		IndexManager idxMgr = dataManager.getIndexManager();
		int [] rosterIDArray = idxMgr.getCurrentIdArray(rosterSource);

		String baseXPathWithPred = rosterSource + "." + middleXPath;
		
		int[] wholeIDArray = getIDArryForXPath(baseXPathWithPred, rosterIDArray);
		
		String baseXPath = getXPathWithOutPredicates(baseXPathWithPred);
		
		//Now replace the wholeIDArray for the portion of rosterID

		
		int saveView   = apData.getViewType();
		//default value
		String retVal  = ""; 

		try {
			//Change to correct view type
			if (viewType != saveView){
				apData.changeViewType(viewType);
			}
			
			//Search on the given XPath
			for (int i = 0; i < allowedValues.length; i++){
				int count = apData.getCount(baseXPath + getPredicate(predicateXPath, allowedValues[i]), wholeIDArray);
				if (count > 0){
					retVal = allowedValues[i];
					//stop searching
					break;
				}				
			}
		} finally {
			apData.changeViewType(saveView);
		}
		
		return retVal;
	}
	
	
	/**
	 * This method will update the user selected option value. If previous option
	 * exists, it will update the same aggregate. 
	 * 
	 * @param rosterSource	
	 * @param middleXPath	
	 * @param predicateXPath
	 * @param storedValue			Stored option value
	 * @param userSelecletedValue	User Selected value on the screen
	 * @param viewType
	 */
	public void updateOptionValue(String rosterSource, String middleXPath, String predicateXPath, 
			String storedValue, String userSelecletedValue, int viewType){
			
		
		IndexManager idxMgr = dataManager.getIndexManager();
		
		// eg: CommlAutoLineBusiness.CommlRateState
		int [] rosterIDArray = idxMgr.getCurrentIdArray(rosterSource);

		// eg: ommlAutoLineBusiness.CommlRateState.CommlAutoHiredInfo.CommlCoverage
		String baseXPathWithPred = rosterSource + "." + middleXPath;		
		int[] wholeIDArray = getIDArryForXPath(baseXPathWithPred, rosterIDArray);	
		
		// eg: ommlAutoLineBusiness.CommlRateState.CommlAutoHiredInfo.CommlCoverage.CoverageCd
		String baseXPath = getXPathWithOutPredicates(baseXPathWithPred);
		
		
		
		int saveView   = apData.getViewType();
		try {
			//Change to correct view type
			if (viewType != saveView){
				apData.changeViewType(viewType);
			}
			
			int[] existingIdArrayWithOutqualifier = null;
			
			if(storedValue.length() > 0){
				String path = baseXPath +  getPredicate(predicateXPath, storedValue);				
				ElementPathExpression currentXPath = new ElementPathExpression(path);
				existingIdArrayWithOutqualifier = apData.normalizeXPathExpressionToIdArray(currentXPath, wholeIDArray);
			}
			
			if(userSelecletedValue.length() > 0 ){
				if(existingIdArrayWithOutqualifier != null){
					apData.setFieldValue(baseXPathWithPred + "." + predicateXPath, existingIdArrayWithOutqualifier, userSelecletedValue );
				}else{
					String addPath = baseXPathWithPred +  getPredicate(predicateXPath, userSelecletedValue) + "." + predicateXPath;
					apData.setFieldValue(addPath, wholeIDArray, userSelecletedValue );
				}			
			}else{		
				if(existingIdArrayWithOutqualifier != null && apData.getCount(baseXPath, existingIdArrayWithOutqualifier) > 0){
					apData.deleteElement( baseXPathWithPred, existingIdArrayWithOutqualifier);
				}
			}
			
			
		} finally {
			apData.changeViewType(saveView);
		}
		
		
	}
	
	

	/*
	 * 
	 */
	/**
	 * @param name
	 * @param value
	 * @return String
	 */
	private String getPredicate(String name, String value){
		return "[" + name + "='"+ value +"']"; 
	}
	
	/**
	 * Convert List to String Array
	 * @param inList
	 * @return String array
	 */
	public String[] getStringArrayFromList(List inList){
		
		String [] outArray = new String[inList.size()]; 
		   
		   Iterator it = inList.iterator();
		    for (int i = 0; it.hasNext(); i++) {
		    	String tempVal = String.valueOf(it.next());
		    	StringTokenizer stk = new StringTokenizer(tempVal, "|");
		    	outArray[i] = stk.nextToken();
		    }
			
		    return outArray;
	}

}
