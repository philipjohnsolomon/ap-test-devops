/**
 * Mar 29, 2005  @author Agencyport Insurance Services, Inc.
 */
package com.agencyport.shared.commercial.beans;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.ElementPathExpression;
import com.agencyport.domXML.IdIterator;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.logging.LoggingManager;
import com.agencyport.policysummary.PolicySummarizer;
import com.agencyport.shared.APException;
import com.agencyport.shared.apps.common.utils.NumberFormatter;


/**
 * This class contains the building information. Loads the building information
 * from current work item apData. This bean will be used to print the summary page.
 * 
 */
public class BuildingSummary extends PolicySummarizer{
	/**
	 * The <code>LOGGER</code> is my Logger
	 */
	private static final Logger LOGGER =
		LoggingManager.getLogger(BuildingSummary.class.getPackage().getName());
	/*
	 * CommercialPropertyInfo has the refid's of Location and SubLocation
	 */	
	/**
	 * The <code>subLocationRefId</code> is a private string variable.
	 */
	private String subLocationRefId;
	/**
	 * The <code>locationRefId</code> is a private string variable.
	 */
	private String locationRefId;
	/**
	 * The <code>apData</code>is a private APDataCollection Object.
	 */
	private APDataCollection apData;
	/**
	 * The <code>bldgDescription</code> is a private string variable.
	 */
	private String bldgDescription = "";
	/**
	 * The <code>bldgNumber</code> is a private string variable.
	 */
	private String bldgNumber;
	/**
	 * The <code>locationNumber</code> is a private string variable.
	 */
	private String locationNumber;
	/**
	 * The <code>buldgCoverageList</code>is a private list of type BuildingCoverages.
	 */
	private List<BuildingCoverages> buldgCoverageList = new ArrayList<BuildingCoverages>();
	
	/**
	 * The <code>SELECETED</code>is a string constant.
	 */
	private static final String SELECETED = "Selected";
	/**
	 * The <code>NOT_SELECETED</code>is a string constant.
	 */
	private  static final String NOT_SELECETED = "Not Selected";
	/**
	 * The <code>INCLUDED</code>is a string constant.
	 */
	private static final String INCLUDED = "Included";
	/**
	 * The <code>baseXPath</code>is a string constant.
	 */
	protected static final String BASEXPATH = "CommlPropertyLineBusiness.PropertyInfo.CommlPropertyInfo";
	/**
	 * The <code>COMMLPROPPCODELIST_PREFIX_KEY</code>is a string constant.
	 */
	protected static final String COMMLPROPPCODELIST_PREFIX_KEY = "xmlreader:propcCodeListRef.xml:";
	/**
	 * The <code>SUBJECT_OF_INSURANCE</code>is a string constant.
	 */
	protected static final String SUBJECT_OF_INSURANCE = "subjectOfInsurance";
	/**
	 * The <code>CAUSE_OF_LOSS</code>is a string constant.
	 */
	protected static final String CAUSE_OF_LOSS = "causeLoss";
	
	/**
	 * The <code>COMML_COVERAGE_COVERAGE_CD</code> is a String Constant.
	 */
	private static final String COMML_COVERAGE_COVERAGE_CD = ".CommlCoverage[CoverageCd='";
	
	/**
	 * @param locRefId
	 * @param sublocRefId
	 * @param apData
	 * @throws APException
	 */
	public BuildingSummary(String locRefId, String sublocRefId,
			APDataCollection apData) throws APException{
		locationRefId = locRefId;
		subLocationRefId = sublocRefId;
		this.apData = apData;
		loadBuildingLocationInfo(locRefId, sublocRefId);
		loadBuildingCoverages(locRefId, sublocRefId);
	}
	
	/**
	 * @param apData
	 * @throws APException
	 */
	public BuildingSummary(APDataCollection apData) throws APException{
		this.apData = apData;	
	}
	
	/**
	 * This method populates the building information for a given location/sublocation.
	 * 
	 * @param locRefId
	 * @param sublocRefId
	 * @throws APException
	 */
	private void loadBuildingLocationInfo(String locRefId, String sublocRefId )
		throws APException {
		int locIdx = getAPDataIndexId("Location", "id", locRefId);
		if(locIdx == -1){
			return;		
		}
		int sublocIdx = getAPDataIndexId("Location[" + locIdx + "].SubLocation", "id", sublocRefId);
		int[] ids = {locIdx, 0};
		if(sublocIdx == -1){
			return;
		}
		ids [1] = sublocIdx;
		
		bldgDescription = normalizeDisplayValue(apData.getFieldValue("Location.SubLocation.SubLocationDesc", ids, ""));			
		bldgNumber = normalizeDisplayValue(apData.getFieldValue("Location.SubLocation.ItemIdInfo.InsurerId", ids, ""));
		locationNumber = normalizeDisplayValue(apData.getFieldValue("Location.ItemIdInfo.InsurerId",locIdx,""));
	}
	
	/**
	 * This method populates the building coverages for all the building/sublocations.
	 * 
	 * @param locRefId
	 * @param sublocRefId
	 */
	private void loadBuildingCoverages(String locRefId, String sublocRefId){  
		
    	buldgCoverageList.clear();    	
    	ElementPathExpression xPathExpression = new ElementPathExpression(BASEXPATH);
		IdIterator dataIt = new IdIterator(xPathExpression, apData.getName());
		int[] idArray = null;	
		
    	while ( (idArray = dataIt.findNext(apData)) != null ){
    		
    		String coverageCd = "";    		
    		String subLocationRefIdTemp = apData.getFieldValue(BASEXPATH + ".@SubLocationRef", idArray, "");
    		
    		if(subLocationRefIdTemp.equalsIgnoreCase(sublocRefId)) {
    			
				BuildingCoverages buildingCoverages = new BuildingCoverages(); 
				buildingCoverages.setsOI(getSOIDescription(apData.getFieldValue(BASEXPATH + ".SubjectInsuranceCd", idArray, "")));
				coverageCd = getCauseOfLossCode(BASEXPATH,idArray);
				
				if (coverageCd != null &&  !"".equals(coverageCd ))	{
					
					buildingCoverages.setCauseOfLoss(getCauseOfLossDescription(coverageCd));
					buildingCoverages.setLimit(NumberFormatter.commatize(normalizeDisplayValue(apData.getFieldValue(BASEXPATH + COMML_COVERAGE_COVERAGE_CD+ coverageCd + "'].Limit.FormatInteger", idArray, ""))));
					buildingCoverages.setDeductibleAmt(NumberFormatter.commatize(normalizeDisplayValue(apData.getFieldValue(BASEXPATH + COMML_COVERAGE_COVERAGE_CD + coverageCd + "'].Deductible.FormatInteger", idArray, ""))));
					buildingCoverages.setPctOfCoInsurance(normalizeDisplayValue(apData.getFieldValue(BASEXPATH + COMML_COVERAGE_COVERAGE_CD+ coverageCd + "'].CommlCoverageSupplement.CoinsurancePct", idArray, "")));
				}
				buildingCoverages.setcSPClassCd(normalizeDisplayValue(apData.getFieldValue(BASEXPATH + ".ClassSpecificRatedCd", idArray, "")));
				buildingCoverages.setBlanketNumber(normalizeDisplayValue(apData.getFieldValue(BASEXPATH + ".BlanketNumber", idArray, "")));
				buldgCoverageList.add(buildingCoverages);
    		}
		}
    }
	
	/**
	 * @param srcPath
	 * @param attribute
	 * @param refId
	 * @return int
	 */
	private int getAPDataIndexId(String srcPath, String attribute,  String refId){
		int result = -1;
		int count = apData.getCount(srcPath);
		for(int i = 0 ; i < count; i++){
			String value = apData.getFieldValue(srcPath + ".@" + attribute, i , "");
			if(value.equalsIgnoreCase(refId)){
				return i;
			}
		}
		return result;
	}
	/**
	 * @param coverageType
	 * @param subjectInsuredCd
	 * @return boolean
	 */
	public boolean isBldgCoverageExist(String coverageType, String subjectInsuredCd){
		String srcPath = getCommercialPropertyActualXPath(coverageType, subjectInsuredCd);
		if(apData.getCount(srcPath) > 0){
			return true;
		}
		return false;		
	}
	
	/**
	 * @param coverageType
	 * @param subjectInsuredCd
	 * @return String
	 */
	public String getBldgCoverage(String coverageType, String subjectInsuredCd){
		String srcPath = getCommercialPropertyActualXPath(coverageType, subjectInsuredCd);
		srcPath = srcPath + ".Limit[0].FormatInteger";
		return normalizeDisplayValue(apData.getFieldValue(srcPath, ""));
	}
	
	
	/**
	 * @param coverageCd
	 * @param subjectInsuredCd
	 * @param forDisplay
	 * @return String
	 */
	public String getBuildingValuationCode(String coverageCd, String subjectInsuredCd, boolean forDisplay) {
		if(isBldgCoverageExist(coverageCd, subjectInsuredCd)){
			String srcPath = getCommercialPropertyActualXPath(coverageCd, subjectInsuredCd);
			return normalizeDisplayValue(apData.getFieldValue(srcPath + ".Limit.ValuationCd", ""));
			
		}else{
			return NOT_SELECETED; 
		}
	}
	
	/**
	 * @return Returns the bldgDescription.
	 */
	public String getBldgDescription() {
		return bldgDescription;
	}
	/**
	 * @param bldgDescription The bldgDescription to set.
	 */
	public void setBldgDescription(String bldgDescription) {
		this.bldgDescription = bldgDescription;
	}
	/**
	 * @return Returns the bldgNumber.
	 */
	public String getBldgNumber() {
		return bldgNumber;
	}
	/**
	 * @param bldgNumber The bldgNumber to set.
	 */
	public void setBldgNumber(String bldgNumber) {
		this.bldgNumber = bldgNumber;
	}
	/**
	 * @return Returns the locationRefId.
	 */
	public String getLocationRefId() {
		return locationRefId;
	}
	/**
	 * @param locationRefId The locationRefId to set.
	 */
	public void setLocationRefId(String locationRefId) {
		this.locationRefId = locationRefId;
	}
	/**
	 * @return Returns the subLocationRefId.
	 */
	public String getSubLocationRefId() {
		return subLocationRefId;
	}
	/**
	 * @param subLocationRefId The subLocationRefId to set.
	 */
	public void setSubLocationRefId(String subLocationRefId) {
		this.subLocationRefId = subLocationRefId;
	}	
	
	/**
	 * Each building can be associated with more than one class code.
	 * This method builds all the class code information as a list. 
	 * @return a list of class code info maps.
	 */
	public List<Map<String, String>> getBldgingClassInfo(){
		final List<Map<String, String>> classInfoList = new ArrayList<Map<String, String>>();
		final String baseClassficationPath = "BOPLineBusiness.LiabilityInfo.GeneralLiabilityClassification[@SubLocationRef='" + subLocationRefId +"'";
		int count = apData.getCount(baseClassficationPath + "]");
		for(int i = 0; i < count; i++){
	 		String classCode = normalizeDisplayValue(apData.getFieldValue(baseClassficationPath +  " && position()=@id].ClassCd", i, ""));
	 		if(classCode.length() <= 0) {
	 			continue;
	 		}
	 		String desc = normalizeDisplayValue(apData.getFieldValue(baseClassficationPath +  " && position()=@id].ClassCdDesc", i, ""));
	 		String premiumBasisCd = normalizeDisplayValue(apData.getFieldValue(baseClassficationPath +  " && position()=@id].PremiumBasisCd", i, ""));
	 		String exposure = normalizeDisplayValue(apData.getFieldValue(baseClassficationPath +  " && position()=@id].Exposure", i, ""));
	 		if(exposure.length() > 0){
	 			exposure = getDollarValue(true, exposure);
	 		}
	 		Map<String, String> map = new HashMap<String, String>();
	 		map.put("ClassCd", classCode);
	 		map.put("ClassDesc", desc);
	 		map.put("PremiumBasisCd", premiumBasisCd);
	 		map.put("Exposure", exposure);
	 		classInfoList.add(map);
	 	}		
		return classInfoList;
	}
	
	/**
	 * This method will return the building level limit for a given SOI and Coverage code.
	 * 
	 * @param coverageCd
	 * @param subjectInsuredCd
	 * @param forDisplay
	 * @return String
	 */
	public String getBldgLevelLimit(String coverageCd, String subjectInsuredCd, boolean forDisplay) {
		if(isBldgCoverageExist(coverageCd, subjectInsuredCd)){
			String limit = getBldgCoverage(coverageCd, subjectInsuredCd);
			return getDollarValue(forDisplay, limit);
		}else{
			return NOT_SELECETED; 
		}
	}
	
	/**
	 * This method will return the Auto Increase percentage for a building.
	 * 
	 * @param coverageCd
	 * @param subjectInsuredCd
	 * @param forDisplay
	 * @return String
	 */
	public String getBldgInflationLimit(String coverageCd, String subjectInsuredCd, boolean forDisplay) {
		if(isBldgCoverageExist(coverageCd, subjectInsuredCd)){
			String srcPath = getCommercialPropertyActualXPath(coverageCd, subjectInsuredCd);
			String limit = normalizeDisplayValue(apData.getFieldValue(srcPath + ".Option[OptionCd='IGP'].OptionValue", ""));
			limit = limit + "%";
			return limit;
		}else{
			return NOT_SELECETED; 
		}
	}	
	
	/**
	 * @return Returns the LocationNumber.
	 */
	public String getLocationNumber() {
		return locationNumber;
	}
	
	
	/**
	 * @param coverageCd
	 * @param subjectInsuredCd
	 * @return String
	 */
	public String getCommercialPropertyActualXPath(String coverageCd, String subjectInsuredCd){
		return "BOPLineBusiness.PropertyInfo.CommlPropertyInfo[SubjectInsuranceCd=\"" + subjectInsuredCd + "\" && @LocationRef='" + locationRefId + "' && @SubLocationRef='" + subLocationRefId + "'].CommlCoverage[CoverageCd=\"" + coverageCd + "\"]";
	}
	
	/**
	 * @param forDisplay
	 * @param value
	 * @return String
	 */
	public String getSlectedValue(boolean forDisplay, int value){
    	return forDisplay? value > 0 ? SELECETED:NOT_SELECETED : String.valueOf(value);
    }
	
	/**
	 * @param value
	 * @return String
	 */
	public String getSlectedValue( boolean value){
    	return  value? SELECETED:NOT_SELECETED ;
    }
	
	/**
	 * @param forDisplay
	 * @param limit
	 * @return String
	 */
	public String getDollarValue(boolean forDisplay, String limit){
		String normalizedLimit = normalizeDisplayValue(limit);  	
    	return forDisplay? getCommatizeDollars(normalizedLimit, true):normalizedLimit ;
    }
	
	/**
	 * @param amount
	 * @param withSign
	 * @return String
	 */
	public String getCommatizeDollars(String amount, boolean withSign){
		String amtStr = "";
		try{
			if(amount != null && amount.length() > 0){
				NumberFormat nf = NumberFormat.getInstance();
				amtStr = nf.format(Double.parseDouble(amount));
				if(withSign){
					amtStr = "$" + amtStr;
				}
			}
		}catch(Exception ex){
			LOGGER.log(Level.WARNING,"Unable to convert in to currency (amount): "  + amount 
					+ " Message: " + ex.getMessage(),ex);
		}
		return amtStr;
	}
	
	/**
	 * @param coverageCd
	 * @param subjectInsuredCd
	 * @param forDisplay
	 * @return String
	 */
	public String getBldgLevelPremium(String coverageCd, String subjectInsuredCd, boolean forDisplay){
		String srcPath = getCommercialPropertyActualXPath(coverageCd, subjectInsuredCd);
		srcPath = srcPath + ".CurrentTermAmt.Amt";
       	String result =  normalizeDisplayValue(apData.getFieldValue(srcPath, ""));
		if(forDisplay && ((result.length() <=0 ) || ("0".equals(result))) && isBldgCoverageExist(coverageCd, subjectInsuredCd)){
			return INCLUDED;
		}
    	return getCommatizeDollars(result, forDisplay);
    }
	
	/**
	 * @param sOICd
	 * @return String
	 */
	public static String getSOIDescription(String sOICd){
		return OptionsMap.lookupDisplayValue(sOICd, COMMLPROPPCODELIST_PREFIX_KEY + SUBJECT_OF_INSURANCE, "", null);	
	}
	
	
	/**
	 * @param srcPath
	 * @param idArray
	 * @return String
	 */
	public String getCauseOfLossCode(String srcPath, int[] idArray){
		Map<String, String> codeMap = OptionsMap.getSingleMap(COMMLPROPPCODELIST_PREFIX_KEY + CAUSE_OF_LOSS);
		String code = "";			
		int cnt = 0;			
		for (Iterator<Entry<String, String>> it=codeMap.entrySet().iterator(); it.hasNext(); ) {
			Entry<String, String> entry = it.next();
			code = (String)entry.getKey();
			cnt = apData.getCount(srcPath + COMML_COVERAGE_COVERAGE_CD+code+"']", idArray);				
			if (cnt >0){
				break;
			}
			code = "";
		}
		return code;
	}
	
	/**
	 * @param coverageCd
	 * @return String
	 */
	public static String getCauseOfLossDescription(String coverageCd){
		return OptionsMap.lookupDisplayValue(coverageCd, COMMLPROPPCODELIST_PREFIX_KEY + CAUSE_OF_LOSS, "", null);	
	}
	
	/**
	 * @return a list of Building Coverages
	 */
	public List<BuildingCoverages> getBuildingCoverageList(){
	    return buldgCoverageList; 
	}	
}
