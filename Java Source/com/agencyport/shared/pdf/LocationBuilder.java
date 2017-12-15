package com.agencyport.shared.pdf;

import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.fieldvalidation.validators.BaseValidator;
import com.agencyport.utils.text.HtmlTransliterator;

public class LocationBuilder {

	/**
	 * @author AgencyPort Inc.
	 * Loads up locations into a hashtable that is keyed by location id.
	 * This allows for quick lookup for other aggregates that have a 
	 * LocationRef attribute.  Each location is assigned a sequence number
	 * based on its position in the list.	 *
	 */	
	public static Map<String, LocationInfo> buildLocationMap(APDataCollection apData) {
		
		// For each location, create a LocationInfo object and add it to list
		int locationsCount = apData.getCount("Location");
		Map<String, LocationInfo> locations = new Hashtable<String, LocationInfo>();
		
		for (int j = 0; j < locationsCount; j++) {
			LocationInfo locInfo 	= new LocationInfo();
			
			locInfo.stateCd 		= normalizeDisplayValue(apData.getFieldValue("Location.Addr.StateProvCd", j, ""));
			locInfo.locationRef 	= apData.getAttributeText ("Location", j, "id");
			locInfo.locationSeq 	= new Integer(j + 1).toString();
			locInfo.addr1 			= normalizeDisplayValue(apData.getFieldValue("Location.Addr.Addr1", j, ""));
			locInfo.addr2 			= normalizeDisplayValue(apData.getFieldValue("Location.Addr.Addr2", j, ""));
			locInfo.city 			= normalizeDisplayValue(apData.getFieldValue("Location.Addr.City", j, ""));
			locInfo.zip 			= normalizeDisplayValue(apData.getFieldValue("Location.Addr.PostalCode", j, ""));
			locInfo.highestFloorNumOccupied = normalizeDisplayValue(apData.getFieldValue("Location.HighestFloorNumberOccupied", j, ""));
			locations.put(locInfo.locationRef, locInfo);
		}
		
		return locations;
	}
	
	
	/**
	 * @author AgencyPort Inc.
	 * Loads up locations into a hashtable that is keyed by location id.
	 * This allows for quick lookup for other aggregates that have a 
	 * LocationRef attribute.  Each location is assigned a sequence number
	 * based on its position in the list.	 *
	 */	
	public static Map<String, LocationInfo> buildLocationMap(APDataCollection apData, String locationBasePath) {

		Map<String, LocationInfo> locations = new Hashtable<String, LocationInfo>();
		
		// For each location, create a LocationInfo object and add it to list
		Iterator<int[]> idIter = apData.createIndexIterator(locationBasePath);
		int sequence = 0;
		while(idIter.hasNext()){
			int[] idArray = (int[]) idIter.next();
			
			LocationInfo locInfo 	= new LocationInfo();
			
			locInfo.stateCd 		= normalizeDisplayValue(apData.getFieldValue(locationBasePath+".Location.Addr.StateProvCd", idArray, ""));
			locInfo.locationRef 	= apData.getAttributeText (locationBasePath+".Location", idArray, "id");
			locInfo.locationSeq 	= new Integer(sequence++ + 1).toString();
			locInfo.addr1 			= normalizeDisplayValue(apData.getFieldValue(locationBasePath+".Location.Addr.Addr1", idArray, ""));
			locInfo.addr2 			= normalizeDisplayValue(apData.getFieldValue(locationBasePath+".Location.Addr.Addr2", idArray, ""));
			locInfo.city 			= normalizeDisplayValue(apData.getFieldValue(locationBasePath+".Location.Addr.City", idArray, ""));
			locInfo.zip 			= normalizeDisplayValue(apData.getFieldValue(locationBasePath+".Location.Addr.PostalCode", idArray, ""));
			locInfo.highestFloorNumOccupied = normalizeDisplayValue(apData.getFieldValue(locationBasePath+".Location.HighestFloorNumberOccupied", idArray, ""));
			locations.put(locInfo.locationRef, locInfo);
		} 
		return locations;
	}
	/**
	    * Get the location given the id from the Location Aggregate in the APDataCollection
	    * @param id
	    * @param data
	    * @return
	    */
	   public static LocationInfo getLocation(String id,APDataCollection data){
		   
		   LocationInfo locInfo  = new LocationInfo();
		   
		   locInfo.locationRef = id;
		   locInfo.addr1 = normalizeDisplayValue(data.getFieldValue("Location[@id='["+id+"'].Addr.Addr1", ""));
		   locInfo.addr2 = normalizeDisplayValue(data.getFieldValue("Location[@id='["+id+"'].Addr.Addr2", ""));
		   locInfo.city = normalizeDisplayValue(data.getFieldValue("Location[@id='["+id+"'].Addr.City", ""));
		   locInfo.stateCd = normalizeDisplayValue(data.getFieldValue("Location[@id='["+id+"'].Addr.StateProvCd", ""));
		   locInfo.zip = normalizeDisplayValue(data.getFieldValue("Location[@id='["+id+"'].Addr.PostalCode",""));
		   locInfo.taxCode = normalizeDisplayValue(data.getFieldValue("Location[@id='["+id+"'].TaxCodeInfo[TaxTypeCd='Prop'].TaxCd", ""));
		   locInfo.fireDistrict = normalizeDisplayValue(data.getFieldValue("Location[@id='["+id+"'].FireDistrict",""));		
			locInfo.highestFloorNumOccupied = normalizeDisplayValue(data.getFieldValue("Location[@id='["+id+"'].HighestFloorNumberOccupied",""));
		   return locInfo;		   
	   } 
		/**
		 * Renders a value taking into account the notion of null, empty, and string contents
		 * that could contain special control characters.
		 * @param displayValue is the raw display value
		 * @return a normalized display value
		 */
		public static String normalizeDisplayValue(String displayValue){
			if ( BaseValidator.checkIsEmpty(displayValue))
				return "";
			else {
				return HtmlTransliterator.encode(displayValue);
			}
		}
}
