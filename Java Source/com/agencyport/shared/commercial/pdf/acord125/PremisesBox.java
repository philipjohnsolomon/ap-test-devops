/*
 * Created on Mar 11, 2005
 *
 */
package com.agencyport.shared.commercial.pdf.acord125;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.logging.LoggingManager;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.pdf.AdditionalDataSupport;
import com.agencyport.shared.pdf.IAcordConstants;
import com.agencyport.shared.pdf.PDFUtility;
import com.agencyport.shared.pdf.SubLocation;

/**
 * @author AgencyPort Inc.
 *
 */


public class PremisesBox extends AdditionalDataSupport {
	
	/**
	 * The <code>APPLINFO_CODE_LIST</code>
	 */
	private static final String APPLINFO_CODE_LIST = "applInfoCodeListRef.xml";
	
	/**
	 * The <code>LOGGER</code> is my Logger
	 */
	private static final Logger LOGGER = 
		LoggingManager.getLogger(PremisesBox.class.getPackage().getName());
	
	/**
	 * The <code>premisesList</code>
	 */
	private List<PremisesInfo> premisesList;
	
	/**
	 * Default Constructor
	 */
	public PremisesBox() {
		super(2);
	}
	
	/**
	 * @param pdfDocument
	 * @param apData
	 */
	public  void process(PdfDocument pdfDocument, APDataCollection apData) {
		int premisesInfoCount = premisesList.size();
		
		for (int i = 0; i < premisesInfoCount; i++) {
			PremisesInfo pInfo = (PremisesInfo) premisesList.get(i);
			
			if (i < maxSizeAllowed) {
				printInfo(pdfDocument, pInfo, i);				
			}
			
			if(i == 0){
				addAdditionalPremisesHeader();
			}
			addAdditionalPremisesInfo(pInfo, i, maxSizeAllowed,apData);		
			
		}
	}
	
	/* Sets the premises header */
	/**
	 * 
	 */
	private void addAdditionalPremisesHeader(){
		additionalPageContent.add("ADDITIONAL PREMISES INFORMATION : ");
		additionalPageContent.add(" ");
	}
	
	/**
	 * Builds the additional content related to Premises. This has been added to 
	 * support additional information for Premises (1 & 2), which will be printed
	 * on Form.
	 * 
	 * @param pInfo	premises info
	 * @param currentPremises	current index of the premises
	 * @param maxAllowed	max we can print the schedules form. Remaining will go
	 * 						on additional page.
	 * @param apData 
	 */
	private void addAdditionalPremisesInfo(PremisesInfo pInfo, int currentPremises, int maxAllowed,APDataCollection apData){
		additionalPageContent.add(    "  Loc #                    : " + pInfo.location.locationSeq);
		if (pInfo.buildingNum != null){
			additionalPageContent.add("  Bldg #                   : " + pInfo.buildingNum.toString());
			additionalPageContent.add("  Bldg Description         : " + pInfo.description.toString());
		}else{
			// display the sub locations if there is are buildings(CommlSubLocation aggregate)
			List subLocations = LocationInfo.getSubLocations(pInfo.location.locationRef, apData);
			if(!subLocations.isEmpty()){
				Iterator ite = subLocations.iterator();
				while(ite.hasNext()){
					SubLocation subLocation =(SubLocation) ite.next();
					if(subLocation == null){
						continue;
					}
					additionalPageContent.add(    "  Sub Loc #                : " + subLocation.getNumber());
					additionalPageContent.add(    "  Sub Loc Description      : " + subLocation.getDescription());
				}			
			}
		}
		
		if(currentPremises < maxAllowed){
			additionalPageContent.add(    "  Tax Code                 : " + pInfo.location.taxCode);
			additionalPageContent.add(    "  Fire District Name/Code  : " + pInfo.location.fireDistrict);
		}else{
			String address = pInfo.location.addr1 + " " + pInfo.location.addr2 + " " + pInfo.location.city + " " + pInfo.location.stateCd + " " + pInfo.location.zip;
			additionalPageContent.add(    "  Address                  : " + address);				
			String cityLimitDesc = PDFUtility.translateCodeToText(APPLINFO_CODE_LIST, "risklocation", pInfo.location.cityLimits);
			additionalPageContent.add(    "  City Limits              : " + cityLimitDesc);
			additionalPageContent.add(    "  Tax Code                 : " + pInfo.location.taxCode);
			additionalPageContent.add(    "  Fire District Name/Code  : " + pInfo.location.fireDistrict);
		}		
		additionalPageContent.add(" ");	
	}
	

	/**
	 * @param pdfDocument
	 * @param pInfo
	 * @param i
	 */
	private void printInfo(PdfDocument pdfDocument, PremisesInfo pInfo, int i) {
		
		pdfDocument.printField(Integer.valueOf(pInfo.location.locationSeq).toString(), "Premises.Number." + (i+1));
		if (pInfo.buildingNum != null){
		pdfDocument.printField(pInfo.buildingNum.toString(), "Premises.BuildingNumber." + (i+1));		
		}
		PdfBox box = pdfDocument.getBox("Premises.Address." + (i+1));
		if(pInfo.location.addr1.length() > 0){
			box.addTextTruncate(pInfo.location.addr1);
		}
		if (pInfo.location.addr2.length() > 0) {
			box.addTextTruncate(pInfo.location.addr2);
		}				
		box.addTextTruncate(pInfo.location.city + " " + pInfo.location.stateCd  + " " + pInfo.location.zip);
		box.print();		
		
		if( !"".equals(pInfo.location.cityLimits)){
			pdfDocument.printField(IAcordConstants.CHECKED, "Premises.CityLimits." + pInfo.location.cityLimits + "." + (i+1));	
		}
		printInterest(pdfDocument, pInfo, i);
		
		pdfDocument.printField(pInfo.yearBuilt, "Premises.YearBuilt." + (i+1));
		pdfDocument.printField(pInfo.numEmployess, "Premises.NumEmployees." + (i+1));
		pdfDocument.printField(pInfo.annualRevenue, "Premises.AnnualGrossSales." + (i+1));
		pdfDocument.printField(pInfo.partOccupied, "Premises.PartOccupied." + (i+1));
	}
	
	
	/**
	 * @param pdfDocument
	 * @param pInfo
	 * @param i
	 */
	public void printInterest(PdfDocument pdfDocument, PremisesInfo pInfo, int i) {
		
		if( !"".equals(pInfo.interest)){
			if ("OWNER".equalsIgnoreCase(pInfo.interest) || "TENANT".equalsIgnoreCase(pInfo.interest)){
				pdfDocument.printField(IAcordConstants.CHECKED,	"Premises.Interest." + pInfo.interest + "." + (i+1));
			}else {
				pdfDocument.printField(IAcordConstants.CHECKED, "Premises.Interest.OTHER" + "." + (i+1));
				pdfDocument.printField(pInfo.interest, "Premises.Interest.OTHER.Name" + "." + (i+1));
			}
		}
	}
	
	/**
	 * @param locationInfoList
	 * @param apData
	 */
	public void loadPremisesInfo(List locationInfoList, APDataCollection apData) {
		
		premisesList = new ArrayList<PremisesInfo>();
		PremisesInfo pInfo = null;
		Map<String, Integer> locTable = new HashMap<String, Integer>();
			
		for (int i = 0; i < locationInfoList.size(); i++ ) {
			
			LocationInfo searchLocation = (LocationInfo) locationInfoList.get(i);
			String searchLocationRef = searchLocation.locationRef;		
			int searchLocationSeq = Integer.parseInt(searchLocation.locationSeq) - 1;
			
			String subLocationString = "CommlSubLocation[@LocationRef='" + searchLocationRef + "']";
			
			int count = 0; 
			int printPremisesCount = 0;
			try{
				count = apData.getCount(subLocationString);
			}catch(Exception ex){
				LOGGER.log(Level.FINE,ex.getMessage(),ex);
				count = 0;
			}
			
			List<SubLocation> subLocationList = LocationInfo.getSubLocations(searchLocationRef, apData);
			
			for (int j = 0; j < count; j++) {
				String commlSubLocationRefId = apData.getFieldValue(subLocationString  + ".@SubLocationRef", j, "");
				if(commlSubLocationRefId.length() <= 0){
					
					continue;
				}
				
				
				// Validate this CommlSubLocation should correspond to a SubLocation 
				boolean correspondingSubLocationExist = false;	
				//refactored to reduce Cyclomatic Complexity
				correspondingSubLocationExist = loadPremisesInfoContinued(subLocationList, commlSubLocationRefId, correspondingSubLocationExist);
				if(!correspondingSubLocationExist){
					continue;
				}
				
				pInfo = new PremisesInfo();
				pInfo.location = searchLocation;
				
				pInfo.description = apData.getFieldValue("Location.SubLocation.SubLocationDesc", searchLocationSeq, j, "");			
				
				pInfo.interest = apData.getFieldValue(subLocationString + ".InterestCd", j, "");
				pInfo.yearBuilt = apData.getFieldValue(subLocationString + ".Construction.YearBuilt", j, "");
				pInfo.numEmployess = apData.getFieldValue(subLocationString + ".BldgOccupancy.NumEmployees", j, "");
				pInfo.partOccupied = apData.getFieldValue(subLocationString + ".BldgOccupancy.OccupiedPct", j, "");			
				pInfo.annualRevenue = apData.getFieldValue("CommlPolicy.CommlPolicySupplement.CommlParentOrSubsidiaryInfo[MiscParty.MiscPartyInfo.MiscPartyRoleCd='ParentCompany'].AnnualGrossReceiptsAmt.Amt", "");
				
				Integer bldgNum = (Integer) locTable.get(searchLocationRef);
				if (bldgNum == null) {
					bldgNum = Integer.valueOf(1);
					locTable.put(searchLocationRef, bldgNum);
				}else {
					locTable.remove(searchLocationRef);
					bldgNum = Integer.valueOf(bldgNum.intValue() + 1);
					locTable.put(searchLocationRef, bldgNum);
				}
				
				pInfo.buildingNum = bldgNum;
				
				premisesList.add(pInfo);
				printPremisesCount++;
			}
			if (printPremisesCount == 0){
				pInfo = new PremisesInfo();
				pInfo.location = searchLocation;				
				pInfo.description = "";				
				pInfo.interest = "";
				pInfo.yearBuilt = "";
				pInfo.numEmployess = "";
				pInfo.partOccupied = "";			
				pInfo.annualRevenue = "";
				premisesList.add(pInfo);
				
			}
		}
	}

	/**
	 * @param subLocationList
	 * @param commlSubLocationRefId
	 * @param correspondingSubLocationExist
	 * @return Boolean
	 */
	private boolean loadPremisesInfoContinued(List<SubLocation> subLocationList, String commlSubLocationRefId, boolean correspondingSubLocationExist) {
		boolean correspondingSubLocationExistTemp=correspondingSubLocationExist;
		for(int si = 0; si < subLocationList.size(); si++){
			SubLocation subLocation = (SubLocation)subLocationList.get(si);					
			if(subLocation.getSubLocationId().equals(commlSubLocationRefId)) {
				correspondingSubLocationExistTemp = true;
				break;
			}
		}
		return correspondingSubLocationExistTemp;
	}
}
