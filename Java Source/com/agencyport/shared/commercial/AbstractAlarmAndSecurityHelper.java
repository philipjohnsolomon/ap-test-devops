/*
 * Created on February 21, 2007 by rnannapaneni AgencyPort Insurance
 */
package com.agencyport.shared.commercial;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.agencyport.data.IDataConstants;
import com.agencyport.domXML.ElementPathExpression;
import com.agencyport.domXML.view.IView;
import com.agencyport.domXML.view.ViewRepository;
import com.agencyport.html.elements.BaseElement;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.html.optionutils.ParseValueText;
import com.agencyport.logging.LoggingManager;
import com.agencyport.pagebuilder.Page;
import com.agencyport.shared.APException;
import com.agencyport.widgets.SpecialFieldHelper;

/**
 * The AbstractAlarmAndSecurityHelper class
 */
public abstract class AbstractAlarmAndSecurityHelper extends SpecialFieldHelper {
	/**
	 * The <code>LOGGER</code> is my Logger
	 */
	private static final Logger LOGGER =
		LoggingManager.getLogger(AbstractAlarmAndSecurityHelper.class.getPackage().getName());
	
	//	 Based on the Page is being visited.
	/**
	 * The <code>initalizationFlag_in</code> is the initialization flag.
	 */
	protected int initalizationFlagIn;	
	/**
	 * The <code>COMMLSUBLOCATION</code>is Commercial Sub Location
	 */
	protected static final String COMMLSUBLOCATION = "CommlSubLocation";
	/**
	 * The <code>ALARM_SECURITY</code>is the type of Alarm Security
	 */
	protected static final String ALARM_SECURITY = "CommlSubLocation.AlarmAndSecurity";
	
	/**
	 * The <code>DATE_VIEW_ID</code> is the date formatter
	 */
	protected static final String DATE_VIEW_ID = "commonViews.xml:DateFormatter";
	
	/**
	 * The <code>tempAlarmtypeCd</code>temporary variable to store repeating String.
	 */
	private static String tempAlarmTypeCd="[AlarmTypeCd='";
	/**
	 * @return object of type IView
	 */
	protected IView getDateView(){
		IView aView = null;
		
		try {
			aView = ViewRepository.getView(DATE_VIEW_ID);
		} catch (RuntimeException e) {
			aView = null;
			LOGGER.log(Level.FINE,"Unable to retrive the Date view:" + e.toString(),e);
		}
		return aView;
	}
	/*
	 * Over-write the default value implementation of base class
	 */	 
	@Override
	 protected String getDefaultValueForDisplay(){		
		 if(initalizationFlagIn == IDataConstants.DEFAULT_VALUES_ONLY_DISPLAY_INITIALIZATION){
			 return null;
		 }
		 return super.getDefaultValueForDisplay();
	}
	
	/*
	 * get a hold on the initialization flag
	 */ 
	 @Override
	public void setSpecialDisplayFields(Page page, int initializationFlag) throws APException {
		initalizationFlagIn = initializationFlag;
		super.setSpecialDisplayFields(page, initializationFlag);		
	}
	
	/**
	 * Populate the display value in the screen field
	 */
	@Override
	protected void setSpecialDisplayFieldValue(BaseElement baseEl,
			String xpathToForeignAggregate, FieldInfoEntry fieldInfoEntry){
		int[] idArray = indexMgr.getCurrentIdArray(COMMLSUBLOCATION);
		String alarmTypeCode = getExistingAlarmType(idArray);
		if(alarmTypeCode.length() <= 0){
			//Set default value based on the condition
			baseEl.setValue(""); 
			return;
		}
		
		
		String viewId = null;
		if(baseEl.getId().endsWith("ULCertificateExpirationDt")){
			viewId = DATE_VIEW_ID;
		}
		if (baseEl.getId().endsWith(".AlarmAndSecurity.AlarmTypeCd")){				
			baseEl.setValue(alarmTypeCode);
		} else {			
			String xpath = ALARM_SECURITY + tempAlarmTypeCd + alarmTypeCode
					+ "']." + fieldInfoEntry.xPathTrailerElementPath;
			String value = apData.getFieldValue(xpath, idArray, "");
			
			String displayValue = getDefaultValueForDisplay();
			displayValue = setSpecialDisplayFieldValueTry(idArray, viewId, xpath, value, displayValue);
			baseEl.setValue(displayValue);
		}
	}
	/**
	 * @param idArray
	 * @param viewId
	 * @param xpath
	 * @param value
	 * @param displayValue
	 * @return String
	 */
	private String setSpecialDisplayFieldValueTry(int[] idArray, String viewId, String xpath, String value, String displayValue) {
		String displayValueTemp="";
		String valueTemp="";
		try {
			valueTemp=value;
			displayValueTemp=displayValue;
			if(value.length() > 0){
				if(viewId != null ){
					IView aView = ViewRepository.getView(viewId);
					valueTemp = aView.read(apData, idArray, displayValue, xpath);
				}
				displayValueTemp = valueTemp;
			}
		} catch (APException e) {
			LOGGER.log(Level.FINE,e.toString(),e);
		}
		return displayValueTemp;
	}
	
	/**
	 * Updates the apData from screen input
	 */
	@Override
	public void updateForeignAggregate(){
		 int[] idArray = indexMgr.getCurrentIdArray(COMMLSUBLOCATION);
		 
		 FieldInfoEntry[] fieldInfoEntries = getSpecialFieldInfo();    	
		
		 String alarmTypeCode = getUserSelectedAlarmType();
		 String existingAlarmTypeCode = getExistingAlarmType(idArray);		 
		 int[] alarmIdArray = null;		 
		 
		 if(existingAlarmTypeCode.length() > 0){
			 alarmIdArray = getIdArayForExistingAlarmType(existingAlarmTypeCode, idArray);
		 }
		 // user not selected any alarm type
		 if(alarmTypeCode.length() <= 0){
			if(existingAlarmTypeCode.length() <= 0){
				return;
			}else{
				// delete the existing AlarmAndSecurity aggregate
				apData.deleteElement(ALARM_SECURITY, alarmIdArray);
				return;
			}
		 }
				
		updateForeignAggregateIteration(idArray, fieldInfoEntries, alarmTypeCode, alarmIdArray);		
	}
	/**
	 * @param idArray
	 * @param fieldInfoEntries
	 * @param alarmTypeCode
	 * @param alarmIdArray
	 */
	private void updateForeignAggregateIteration(int[] idArray, FieldInfoEntry[] fieldInfoEntries, String alarmTypeCode, int[] alarmIdArray) {
		for ( int ix = 0; ix < fieldInfoEntries.length; ix++) {
			
			
			IView aView = null;
			if(fieldInfoEntries[ix].screenFieldId.endsWith("ULCertificateExpirationDt")){
				aView = getDateView();
			}
			String value = htmlDataContainer.getStringValue(fieldInfoEntries[ix].screenFieldId);
			
			String path = ALARM_SECURITY;			
			if(alarmIdArray != null){				
				path = path + "." + fieldInfoEntries[ix].xPathTrailerElementPath;		
				if(aView != null){
					aView.update(apData, alarmIdArray, value, path);
				}else{
					apData.setFieldValue(path, alarmIdArray,  value);
				}
			}else{
				path = path + tempAlarmTypeCd+ alarmTypeCode + "'] ." + fieldInfoEntries[ix].xPathTrailerElementPath;
				if(aView != null){
					aView.update(apData, idArray, value, path);
				}else{
					apData.setFieldValue(path, idArray,  value);
				}
			}    		
		}
	}
	
	
	 /**
	  * Returns the existing alarmType from APDataCollection.
	  * 
	  * @param codeListRef This can be either buglarAlarmType or fireAlarmType
	 * @param idArray array containing alarm id's
	 * @return String
	  */
	 protected String getExistingAlarmType(String codeListRef, int [] idArray){
	 	String alarmTypeCode = ""; 
	 	
	 	List<String> selectList = OptionsMap.getSingleList(codeListRef);
	 	for(int idx=0;idx<selectList.size();idx++){
			String option = (String)selectList.get(idx);
			String value = ParseValueText.getValue(option);
			int cnt = apData.getCount(ALARM_SECURITY + tempAlarmTypeCd + value +"']", idArray);
			if(cnt > 0){
				alarmTypeCode = value;
			}
		}
		return alarmTypeCode;
	 }
	 
	 /**
	  * Returns the Selected 'AlarmAndSecurity' aggregate idArray
	  * 
	  * @param existingAlarmTypeCode
	  * @param knownIdArray
	  * @return int array
	  */
	 protected int [] getIdArayForExistingAlarmType(String existingAlarmTypeCode, int [] knownIdArray){
		ElementPathExpression targetXPath = new ElementPathExpression(ALARM_SECURITY +
				"[AlarmTypeCd=\"" + existingAlarmTypeCode + "\"]");		
		return apData.normalizeXPathExpressionToIdArray(targetXPath, knownIdArray);
		
	 }
	 
	/**
	 * @param filedId is id of the field
	 * @return object of type IView
	 */
	protected IView getViewForField(String filedId){
		IView aView = null;
		Page currentPage = dataManager.getPage();
		BaseElement baseEl = currentPage.getFieldByName(filedId);
		String viewId = baseEl.getViewId();
		if(viewId == null){
			return aView;
		}
		try {
			aView = ViewRepository.getView(viewId);
		} catch (RuntimeException e) {
			LOGGER.log(Level.FINE,e.getMessage(),e);
			aView = null;
	
		}
		return aView;
	}
	
	/**
	 * This method will be implemented by Burglar/Fire alarm code to return
	 * proper value for the existing code. 
	 * 
	 * @param idArray CommlSubLocation idArray from IndexManager
	 * @return Stored alaramTypeCode from apData 
	 */
	protected abstract String  getExistingAlarmType(int [] idArray);
	
	/**
	 * This method will be implemented by Burglar/Fire alarm code to return
	 * proper value for the user input ( html ). 
	 * @return String
	 */
	protected abstract String  getUserSelectedAlarmType();

}
