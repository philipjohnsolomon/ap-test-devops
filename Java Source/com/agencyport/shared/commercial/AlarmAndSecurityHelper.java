/*
 * Created on Feb 20, 2007 by rnannapaneni AgencyPort Insurance
 */
package com.agencyport.shared.commercial;


/**
 * The AlarmAndSecurityHelper class
 */
public class AlarmAndSecurityHelper extends AbstractAlarmAndSecurityHelper {
	
	
	/**
	 * The <code>BUGLAR_ALARM_TYPE_CODELISTREF</code> type of burglar alarm.
	 */
	private static final String BUGLAR_ALARM_TYPE_CODELISTREF = "xmlreader:codeListRef.xml:buglarAlarmType";	
	
	
	/**
	 * The <code>specialFields</code> is an array to hold Field Information
	 */
	private static FieldInfoEntry[] specialFields = {
		
		new FieldInfoEntry("SP.BU.CommlSubLocation.AlarmAndSecurity.AlarmTypeCd", "AlarmTypeCd"),
		new FieldInfoEntry("SP.BU.CommlSubLocation.AlarmAndSecurity.AlarmDescCd", "AlarmDescCd"),
		new FieldInfoEntry("SP.BU.CommlSubLocation.AlarmAndSecurity.ULCertificateNumber", "ULCertificateNumber"),		
		new FieldInfoEntry("SP.BU.CommlSubLocation.AlarmAndSecurity.ULCertificateExpirationDt", "ULCertificateExpirationDt"),
		new FieldInfoEntry("SP.BU.CommlSubLocation.AlarmAndSecurity.MiscParty[MiscPartyInfo.MiscPartyRoleCd='AlarmService'].GeneralPartyInfo.NameInfo.CommlName.CommercialName",
				"MiscParty[MiscPartyInfo.MiscPartyRoleCd='AlarmService'].GeneralPartyInfo.NameInfo.CommlName.CommercialName"),
		new FieldInfoEntry("SP.BU.CommlSubLocation.AlarmAndSecurity.ProtectionExtentCd", "ProtectionExtentCd"),
		new FieldInfoEntry("SP.BU.CommlSubLocation.AlarmAndSecurity.ProtectionClassGradeCd", "ProtectionClassGradeCd"),
		new FieldInfoEntry("SP.BU.CommlSubLocation.AlarmAndSecurity.NumWatchPersons", "NumWatchPersons"),
		new FieldInfoEntry("SP.BU.CommlSubLocation.AlarmAndSecurity.WatchPersonsFactorCd", "WatchPersonsFactorCd"),
			
	};
	
	

	@Override
	protected String createForeignAggregateXPath() {		
		return null;
	}

	@Override
	protected FieldInfoEntry[] getSpecialFieldInfo() {
		return specialFields;
	}	
	
	@Override
	protected String getExistingAlarmType(int[] idArray){
		return getExistingAlarmType(BUGLAR_ALARM_TYPE_CODELISTREF, idArray);
		
	}
	
	@Override
	protected String getUserSelectedAlarmType(){
		return htmlDataContainer.getStringValue("SP.BU.CommlSubLocation.AlarmAndSecurity.AlarmTypeCd");
		
	} 

	
}
