/*
 * Created on Feb 8, 2007 by AgencyPort Insurance
 */
package com.agencyport.shared.commercial;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.agencyport.connect.conversion.distributed.AgencyConnectConversionStepData;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.shared.APException;

/**
 * This class implements the common upload mappings for the Commercial Lines.
 * Cases like qualifiers such as 'FOT' as a unitmesurment code for Building exposures.
 * Agency  Connect is unable to qualify with units. 
 * <br>
 * 
 * @author AgencyPort Insurance
 *
 */
public class CommlCommonDataConverter  {
	
	/**
	 * The <code>LOCATION_XPATH</code>xpath of location.
	 */
	private static final String LOCATION_XPATH = "Location";
	/**
	 * The <code>COMMLSUBLOCATION_XPATH</code>xpath of comml sublocation
	 */
	private static final String COMMLSUBLOCATION_XPATH = "CommlSubLocation" ;
	/**
	 * The <code>PROP_QUALIFIER</code>value of prop qualifier.
	 */
	private static final String PROP_QUALIFIER = "Prop";
	/**
	 * The <code>FOT_QUALIFIER</code>value of fot qualifier.
	 */
	private static final String FOT_QUALIFIER = "FOT";
	/**
	 * The <code>FTK_QUALIFIER</code>value of ftk qualifier.
	 */
	private static final String FTK_QUALIFIER = "FTK";
	/**
	 * The <code>SMI_QUALIFIER</code>value of smi qualifier.
	 */
	private static final String SMI_QUALIFIER = "SMI";
	

	/**
	 * The <code>LENGTH_TIME_IN_BUSINESS</code>string value of length of time in business.
	 */
	private static final String LENGTH_TIME_IN_BUSINESS = "CommlPolicy.CommlPolicySupplement.LengthTimeInBusiness.NumUnits";
	/**
	 * The <code>BUSINESS_START_DT</code>business start date.
	 */
	private static final String BUSINESS_START_DT = "CommlPolicy.CommlPolicySupplement.CommlParentOrSubsidiaryInfo[MiscParty.MiscPartyInfo.MiscPartyRoleCd='ParentCompany'].BusinessStartDt";
	/**
	 * The <code>DATE_FORMAT_YYYY_MM_DD</code>date format.
	 */
	private static final String DATE_FORMAT_YYYY_MM_DD = "yyyy-MM-dd";
	
	/**
	 * The <code>NUM_UNITS</code>is a String constant for repeating string.
	 */
	private static final String NUM_UNITS = ".NumUnits";
	
	/**
	 * The <code>UNIT_MEASUREMENT_CD</code>is a String constant for repeating string.
	 */
	private static final String UNIT_MEASUREMENT_CD = ".UnitMeasurementCd";
	
	/**
	 * This method will apply the common conversion required for Commercial lines.
	 * 
	 * 
	 * @param apData
	 * @param stepData
	 * @throws APException
	 */
	public void alterImportData(APDataCollection apData,
			AgencyConnectConversionStepData stepData) throws APException{
		
		// update the TaxTypeCd with 'Prop' for Locations		
		qualifyLocationTaxCd(apData);
		
		//update the UnitMeasurementCd with 'FTK' for all buildings.
		qualifyBuildingAreaUnitMeasureCd(apData);
		
		// update the UnitMeasurementCd with 'FOT' for all buildings.
		qualifyBuildingExposureDistance(apData);
		
		// update the UnitMeasurementCd with 'FOT' for all buildings.
		qualifyDistanceToHydrantUnitMeasureCd(apData);
		
		// update the UnitMeasurementCd with 'SMI' for all buildings.
		qualifyDistanceToFireStationUnitMeasureCd(apData);
		
		// update the Business Start Date
		updateBusinessStartDate(apData);

	}
	
	/**
	 * Portal is expecting to qualify the TaxCd with 'Prop'.
	 * If only TaxCd is available and  TaxTypeCd is not there, then only
	 * this method will update the TaxTypeCd with 'Prop' qualifier.
	 * 
	 * @param apData data to alter
	 * @throws APException 
	 */
	public void qualifyLocationTaxCd(APDataCollection apData) throws APException{
		int count = apData.getCount(LOCATION_XPATH);
		for(int i = IXMLConstants.ID_BASE; i < (count + IXMLConstants.ID_BASE); i++){
			if(apData.getCount(LOCATION_XPATH + ".TaxCodeInfo", i) == 1 ){
				String taxCd = apData.getFieldValue(LOCATION_XPATH + ".TaxCodeInfo.TaxCd", i , "");
				String taxTypeCd = apData.getFieldValue(LOCATION_XPATH + ".TaxCodeInfo.TaxTypeCd", i , "");	
				
				//  only TaxCd is available and  TaxTypeCd is not there
				if(taxCd.length() > 0 && taxTypeCd.length() <= 0){
					apData.setFieldValue(LOCATION_XPATH + ".TaxCodeInfo.TaxTypeCd", i, PROP_QUALIFIER);
				}
			}
		}
	}
	
	/**
	 * @param apData
	 * @param commlSubLocIndex
	 * @param directionTypeCd
	 * @throws APException
	 */
	private void updateBuildingExposure(APDataCollection apData, 
			int commlSubLocIndex, String directionTypeCd) throws APException{
		String buildingExposureXpath  = COMMLSUBLOCATION_XPATH +
										".BldgExposures[DirectionTypeCd='" +
										directionTypeCd + "'].Distance";
		
		String distance = apData.getFieldValue(buildingExposureXpath + NUM_UNITS, commlSubLocIndex, "");
		String qualifier = apData.getFieldValue(buildingExposureXpath +UNIT_MEASUREMENT_CD, commlSubLocIndex, "");
		if(distance.length() > 0 && qualifier.length() <= 0){
			apData.setFieldValue(buildingExposureXpath +UNIT_MEASUREMENT_CD, commlSubLocIndex, FOT_QUALIFIER);
		}
	}
	
	/**
	 * Updates the BuildingExposure distance UnitMeasurementCd code with ' FOT'. 
	 * 
	 * @param apData
	 * @throws APException
	 */
	public void qualifyBuildingExposureDistance(APDataCollection apData) throws APException{
		int count = apData.getCount(COMMLSUBLOCATION_XPATH);
		for(int i = IXMLConstants.ID_BASE; i < (count + IXMLConstants.ID_BASE); i++){
			updateBuildingExposure(apData, i, "Left");
			updateBuildingExposure(apData, i, "Right");
			updateBuildingExposure(apData, i, "Front");
			updateBuildingExposure(apData, i, "Rear");
			
		}
		
	}
	
	/**
	 * Updates the BuildingArea UnitMeasurementCd code with 'FTK'. 
	 * 
	 * @param apData
	 * @throws APException
	 */
	public void qualifyBuildingAreaUnitMeasureCd(APDataCollection apData) throws APException{
		
		int count = apData.getCount(COMMLSUBLOCATION_XPATH);
		String buildingAreaXpath  = COMMLSUBLOCATION_XPATH +".Construction.BldgArea";
		
		for(int i = IXMLConstants.ID_BASE; i < (count + IXMLConstants.ID_BASE); i++){
			String area = apData.getFieldValue(buildingAreaXpath + NUM_UNITS, i, "");
			String qualifier = apData.getFieldValue(buildingAreaXpath +UNIT_MEASUREMENT_CD, i, "");
			
			if(area.length() > 0 && qualifier.length() <= 0){
				apData.setFieldValue(buildingAreaXpath +UNIT_MEASUREMENT_CD, i, FTK_QUALIFIER);
			}
			
		}
		
	}
	
	/**
	 * Updates the DistanceToHydrant UnitMeasurementCd code with 'FTK'. 
	 * 
	 * @param apData
	 * @throws APException
	 */
	public void qualifyDistanceToHydrantUnitMeasureCd(APDataCollection apData) throws APException{
		
		int count = apData.getCount(COMMLSUBLOCATION_XPATH);
		String buildingAreaXpath  = COMMLSUBLOCATION_XPATH +".BldgProtection.DistanceToHydrant";
		
		for(int i = IXMLConstants.ID_BASE; i < (count + IXMLConstants.ID_BASE); i++){
			String area = apData.getFieldValue(buildingAreaXpath +NUM_UNITS, i, "");
			String qualifier = apData.getFieldValue(buildingAreaXpath +UNIT_MEASUREMENT_CD, i, "");
			
			if(area.length() > 0 && qualifier.length() <= 0){
				apData.setFieldValue(buildingAreaXpath +UNIT_MEASUREMENT_CD, i, FOT_QUALIFIER);
			}
			
		}
		
	}
	
	/**
	 * Updates the DistanceToHydrant UnitMeasurementCd code with 'FTK'. 
	 * 
	 * @param apData
	 * @throws APException
	 */
	public void qualifyDistanceToFireStationUnitMeasureCd(APDataCollection apData) throws APException{
		
		int count = apData.getCount(COMMLSUBLOCATION_XPATH);
		String buildingAreaXpath  = COMMLSUBLOCATION_XPATH +".BldgProtection.DistanceToFireStation";
		
		for(int i = IXMLConstants.ID_BASE; i < (count + IXMLConstants.ID_BASE); i++){
			String area = apData.getFieldValue(buildingAreaXpath +NUM_UNITS, i, "");
			String qualifier = apData.getFieldValue(buildingAreaXpath +UNIT_MEASUREMENT_CD, i, "");
			
			if(area.length() > 0 && qualifier.length() <= 0){
				apData.setFieldValue(buildingAreaXpath +UNIT_MEASUREMENT_CD, i, SMI_QUALIFIER);
			}
			
		}
		
	}
	
	/**
	 * Updates the Business start date in the following scenarios.
	 * <p>
	 * <ul>
	 * 	<li>Uploaded value of Business start date is only Year. Then it will concatinate "-01-01"
	 * </ul>Calculated from LengthTimeInBusiness and updates the Business start date 
	 * @param apData
	 * @throws APException 
	 */
	public void updateBusinessStartDate(APDataCollection apData) throws APException {
		String businessStartDt = apData.getFieldValue(BUSINESS_START_DT, null);
		String lengthTimeInBusiness = apData.getFieldValue(LENGTH_TIME_IN_BUSINESS, null);
		
		if (businessStartDt != null){
			if (businessStartDt.length() == 4){
				businessStartDt = businessStartDt + "-01-01";
				apData.setFieldValue(BUSINESS_START_DT, businessStartDt);
				return;
			}else if(businessStartDt.length() == 10){
				return;
			}				
		}
		
		if (lengthTimeInBusiness != null){
			Calendar cal = Calendar.getInstance();
			int lenYearsInBusiness = 0;
			try {
				lenYearsInBusiness = Integer.parseInt(lengthTimeInBusiness);
			} catch (NumberFormatException e) {
				lenYearsInBusiness = 0;
			}
			if(lenYearsInBusiness > 0){
				cal.add(Calendar.YEAR, -(Integer.valueOf(lengthTimeInBusiness)));
				cal.set(Calendar.MONTH,Calendar.JANUARY);
				cal.set(Calendar.DAY_OF_MONTH,1);
				String date = new SimpleDateFormat(DATE_FORMAT_YYYY_MM_DD).format(cal.getTime());			
				apData.setFieldValue(BUSINESS_START_DT, date);
			}
		}
	}

}
