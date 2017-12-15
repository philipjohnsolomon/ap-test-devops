/*
 * Created on Feb 21, 2007 by rnannapaneni AgencyPort Insurance
 */
package com.agencyport.shared.commercial;



/**
 * The FireAlarmAndSecurityHelper class
 */
public class FireAlarmAndSecurityHelper extends AbstractAlarmAndSecurityHelper {
	
	/**
	 * The <code>FIRE_ALARM_TYPE_CODELISTREF</code>
	 */
	private static final String FIRE_ALARM_TYPE_CODELISTREF = "xmlreader:codeListRef.xml:fireAlarmType";
	
	/**
	 * The <code>specialFields</code>  array to hold field information.
	 */
	private static FieldInfoEntry[] specialFields = {				
		new FieldInfoEntry("SP.FIRE.CommlSubLocation.AlarmAndSecurity.AlarmTypeCd", "AlarmTypeCd"),
		new FieldInfoEntry("SP.FIRE.CommlSubLocation.AlarmAndSecurity.AlarmDescCd", "AlarmDescCd"),
		new FieldInfoEntry("SP.FIRE.CommlSubLocation.AlarmAndSecurity.ItemDefinition[ItemTypeCd='Other'].Manufacturer", "ItemDefinition[ItemTypeCd='Other'].Manufacturer")	
	};
	
	@Override
	protected FieldInfoEntry[] getSpecialFieldInfo() {
		return specialFields;
	}

	@Override
	protected String getExistingAlarmType(int[] idArray) {
		return getExistingAlarmType(FIRE_ALARM_TYPE_CODELISTREF, idArray);
		
	}

	@Override
	protected String getUserSelectedAlarmType() {
		return htmlDataContainer.getStringValue("SP.FIRE.CommlSubLocation.AlarmAndSecurity.AlarmTypeCd");

	}

	@Override
	protected String createForeignAggregateXPath() {		
		return null;
	}
}
