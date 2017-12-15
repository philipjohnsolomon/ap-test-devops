package com.agencyport.shared.commercial;


import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.agencyport.data.DataManager;
import com.agencyport.data.IDataConstants;
import com.agencyport.data.IndexManager;
import com.agencyport.domXML.ElementPathExpression;
import com.agencyport.html.elements.BaseElement;
import com.agencyport.pagebuilder.Page;
import com.agencyport.shared.APException;
import com.agencyport.shared.apps.common.utils.APConstants;
import com.agencyport.webshared.HTMLDataContainer;
import com.agencyport.widgets.SpecialFieldHelper;

/**
 * This class supports the handling of multiple AlarmDescCd for single 
 * AlarmAndSecurity aggregate. As per the requirements, all the attributes belongs
 * to single AlarmAndSecurity aggregate of type 'PREM'. User will select multiple description codes
 * through front end. AlarmDescCd will added or deleted dynamically through this helper class.
 */
public class AlarmSecuritySafeValultHelper extends SpecialFieldHelper {	

	/**
	 * The <code>COMMLSUBLOC_ID_XPath</code> xpath of comml sublocation Id.
	 */
	private static final String COMMLSUBLOC_ID_XPATH = "CommlSubLocation.@id";	
	/**
	 * The <code>COMMLSUBLOC_XPath</code> xpath of comml sublocation
	 */
	private static final String COMMLSUBLOC_XPATH = "CommlSubLocation";
	
	/**
	 * The <code>PREM_ALRM_XPATH</code> xpath of permanent alarm
	 */
	private static final String PREM_ALRM_XPATH		= "AlarmAndSecurity[AlarmTypeCd='PREM']";
	/**
	 * The <code>ALRM_DESC_CD_XPATH</code> xpath of alarm description.
	 */
	private static final String ALRM_DESC_CD_XPATH	= "CommlSubLocation.AlarmAndSecurity.AlarmDescCd";	
	/**
	 * The <code>PREM_ALRM_DESC_CEK</code>xpath of perm alarm cek description.
	 */
	private static final String PREM_ALRM_DESC_CEK = "SP.COMMON.CommlSubLocation.AlarmAndSecurity[AlarmTypeCd='PREM'].AlarmDescCd.CEK";
	/**
	 * The <code>PREM_ALRM_DESC_CEN</code>xpath of perm alarm cen description.
	 */
	private static final String PREM_ALRM_DESC_CEN = "SP.COMMON.CommlSubLocation.AlarmAndSecurity[AlarmTypeCd='PREM'].AlarmDescCd.CEN";
	/**
	 * The <code>PREM_ALRM_DESC_POL</code>xpath of perm alarm pol description.
	 */
	private static final String PREM_ALRM_DESC_POL = "SP.COMMON.CommlSubLocation.AlarmAndSecurity[AlarmTypeCd='PREM'].AlarmDescCd.POL";
	/**
	 * The <code>PREM_ALRM_DESC_LOC</code>xpath of perm alarm location description.
	 */
	private static final String PREM_ALRM_DESC_LOC = "SP.COMMON.CommlSubLocation.AlarmAndSecurity[AlarmTypeCd='PREM'].AlarmDescCd.LOC";
	 
	
	/**
	 * The <code>alarmDescCdFieldsMap</code>map that contains perm alarm descriptions.
	 */
	private static Map<String, String> 	alarmDescCdFieldsMap;
	
	static {
		
		alarmDescCdFieldsMap = new HashMap<String, String>(); 		
		alarmDescCdFieldsMap.put( PREM_ALRM_DESC_CEK, "CEK");
		alarmDescCdFieldsMap.put( PREM_ALRM_DESC_CEN, "CEN");	
		alarmDescCdFieldsMap.put( PREM_ALRM_DESC_POL, "POL");	
		alarmDescCdFieldsMap.put( PREM_ALRM_DESC_LOC, "LOC");	
		
 	}
 	
	/**
	 * The <code>specialFields</code> array to hold field information.
	 */
	private static final FieldInfoEntry[] SPECIAL_FIELDS = {		
		new FieldInfoEntry(PREM_ALRM_DESC_CEK, ""),
		new FieldInfoEntry(PREM_ALRM_DESC_CEN, ""),
		new FieldInfoEntry(PREM_ALRM_DESC_POL, ""),
		new FieldInfoEntry(PREM_ALRM_DESC_LOC, "")		
	};

	
	
	//Based on the Page is being visited.
	/**
	 * The <code>initalizationFlagIn</code> is initialization Flag
	 */
	protected int initalizationFlagIn;
	
	/**
	 * Default Constructor
	 */
	public AlarmSecuritySafeValultHelper() {
		
	}
	
	@Override
	protected String createForeignAggregateXPath(){
		return null;
	}

	/**
	 * @param dataManager
	 * @param htmlDataContainer
	 * @throws com.agencyport.shared.APException
	 */
	public AlarmSecuritySafeValultHelper(DataManager dataManager,
			HTMLDataContainer htmlDataContainer) throws APException {
		super(dataManager, htmlDataContainer);	
	}

	/* (non-Javadoc)
	 * @see com.agencyport.widgets.SpecialFieldHelper#getSpecialFieldInfo()
	 */
	@Override
	protected FieldInfoEntry[] getSpecialFieldInfo() {		
		return SPECIAL_FIELDS;
	}

	
	/**
	 * Updates the elements on the foreign aggregate from the screen values.
	 */
	@Override
	public void updateForeignAggregate(){
		int[] currentIdArray = dataManager.getIndexManager().getCurrentIdArray(COMMLSUBLOC_XPATH);			
		String commlSubLocationId = apData.getFieldValue(COMMLSUBLOC_ID_XPATH, currentIdArray, "");
		updateAlarmDescCd(commlSubLocationId);
	}
	
	/**
	 @author ssundaramurthy
	 * @param commlSubLocId 
	 */
	private void updateAlarmDescCd(String commlSubLocId){
		//Determine ID Array for the XPath
		String xPath = "CommlSubLocation[@id='" + commlSubLocId + "']." + PREM_ALRM_XPATH;
		String alarmSecuritySelected =  htmlDataContainer.getStringValue("CommlSubLocation.AlarmAndSecurity[AlarmTypeCd='PREM']");	
		
		if (apData.getCount(xPath) == 0 &&
				(	alarmSecuritySelected.length() <= 0 || alarmSecuritySelected.equalsIgnoreCase(APConstants.NO_IND)) ){
			return;
		}
		if (apData.getCount(xPath) == 0){
			apData.setFieldValue(xPath + ".AlarmTypeCd", "PREM");
		}
			
		ElementPathExpression targetXPath = new ElementPathExpression(xPath);
		int[] targetIdArray =
			apData.normalizeXPathExpressionToIdArray(targetXPath, null);                       
		
		
		Set<String> keySet = alarmDescCdFieldsMap.keySet();
		Iterator<String> it = keySet.iterator();
		while (it.hasNext()){			
			String screenFieldId = (String) it.next();
			String alarmDescCd	 = (String) alarmDescCdFieldsMap.get(screenFieldId);
			String screenValue	 = htmlDataContainer.getStringValue(screenFieldId);	
			if(alarmSecuritySelected.length() <= 0 || alarmSecuritySelected.equalsIgnoreCase(APConstants.NO_IND)){
				screenValue= APConstants.NO_IND;
			}
			updateAlarmDecCdValues(screenValue, alarmDescCd, targetIdArray);
		}
		
	}
	
	/**
	find if the current Alarm Desc Cd value is present in the APData	
		if found and screen value is no, delete the element
		if not found and the screen value is yes, create the element
		Othercases, do nothing
	@author ssundaramurthy
	 * @param screenValue 
	 * @param alarmDescCd 
	 * @param targetIdArray 
	 */
	private void updateAlarmDecCdValues(String screenValue, String alarmDescCd , int [] targetIdArray){
		boolean matchFound = false;
		int [] newTargetIdArray = null;
		int	count = apData.getCount(ALRM_DESC_CD_XPATH, targetIdArray);
		
		// loop thorough all the AlarmDescCd elements
		for (int i=0; i < count; i++){
			newTargetIdArray = IndexManager.appendToIdArray(targetIdArray, i);
			String alarmDescCdFromAPData = apData.getFieldValue(ALRM_DESC_CD_XPATH, newTargetIdArray, "");
			if ( alarmDescCdFromAPData.length() > 0 && alarmDescCdFromAPData.equalsIgnoreCase(alarmDescCd)){
				matchFound = true;
				if (screenValue.equals(APConstants.NO_IND)){
					apData.deleteElement(ALRM_DESC_CD_XPATH, newTargetIdArray);
				}
			}				
		}
		
		if(!matchFound && screenValue.equals(APConstants.YES_IND)){
			newTargetIdArray = IndexManager.appendToIdArray(targetIdArray, count);
			apData.setFieldValue(ALRM_DESC_CD_XPATH, newTargetIdArray, alarmDescCd); 
		}
	}

	/**
	 * Over-written mehod, to provide the actual value 
	 */
	@Override
	protected void setSpecialDisplayFieldValue(BaseElement baseEl, String xpathToForeignAggregate, 
			FieldInfoEntry fieldInfoEntry){   
		String value = "";	
		int[] currentIdArray = dataManager.getIndexManager().getCurrentIdArray(COMMLSUBLOC_XPATH);				
		String commlSubLocId = apData.getFieldValue(COMMLSUBLOC_XPATH+".@id",currentIdArray,"");		
	
		//Alarm Desc Cd
		if (alarmDescCdFieldsMap.containsKey(fieldInfoEntry.screenFieldId)){
			value = getAlarmDescCd(fieldInfoEntry.screenFieldId, commlSubLocId);
		}
		String displayValue = getDefaultValueForDisplay();   
		if(value.length() > 0){
			displayValue = value;
		}
		baseEl.setValue(displayValue);
	}
	
	/**
	 Loop thru all the AlarmDescCd elements and see if the current value is present
	 if yes, return 1, else return 0
	 @author ssundaramurthy
	 * @param screenFieldId 
	 * @param commlSubLocId 
	 * @return String
	 */
	private String getAlarmDescCd(String screenFieldId, String commlSubLocId){
		
		//Determine ID Array for the XPath	
		String xPath = "CommlSubLocation[@id='" + commlSubLocId + "']." + PREM_ALRM_XPATH;
		ElementPathExpression targetXPath = new ElementPathExpression(xPath);
		int[] targetIdArray = apData.normalizeXPathExpressionToIdArray(targetXPath, null);      
				
		int count = apData.getCount(ALRM_DESC_CD_XPATH, targetIdArray);
		String alarmDescCd = (String) alarmDescCdFieldsMap.get(screenFieldId);
		
		for (int i=0; i<count; i++){
			int [] newTargetIdArray = IndexManager.appendToIdArray(targetIdArray, i);
			String alarmDescCdFromAPData = apData.getFieldValue(ALRM_DESC_CD_XPATH, newTargetIdArray, "");
			if ( alarmDescCdFromAPData.length() > 0 && alarmDescCdFromAPData.equalsIgnoreCase(alarmDescCd)){
				return APConstants.YES_IND;
			}
		}		
		return APConstants.NO_IND;
	}
	
	
	
	 // Over-write the default value implemention of base class
	@Override
	 protected String getDefaultValueForDisplay(){		
		 if(initalizationFlagIn == IDataConstants.DEFAULT_VALUES_ONLY_DISPLAY_INITIALIZATION){
			 return null;
		 }
		 return super.getDefaultValueForDisplay();
	}
	
	// get a hold on the initialization flag
	@Override
	public void setSpecialDisplayFields(Page page, int initializationFlag) throws APException {
		initalizationFlagIn = initializationFlag;
		super.setSpecialDisplayFields(page, initializationFlag);		
	}

	
}
