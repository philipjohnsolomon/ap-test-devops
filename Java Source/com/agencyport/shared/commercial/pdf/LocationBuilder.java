package com.agencyport.shared.commercial.pdf;

import java.util.Hashtable;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.shared.commercial.pdf.acord125.LocationInfo;

/**
 * The LocationBuilder class
 */
public final class LocationBuilder {
	
	/**
	 * Default constructor
	 */
	private LocationBuilder(){
		
		
	}

	/**
	 * @author AgencyPort Inc.
	 * Loads up locations into a hashMap that is keyed by location id.
	 * This allows for quick lookup for other aggregates that have a 
	 * LocationRef attribute.  Each location is assigned a sequence number
	 * based on its position in the list.	 
	 * @param apData 
	 * @return HashMap
	 */	
	public static Hashtable<String, LocationInfo> buildLocationMap(APDataCollection apData) {
		
		// For each location, create a LocationInfo object and add it to list
		int locationsCount = apData.getCount("Location");
		Hashtable<String, LocationInfo> locations = new Hashtable<String, LocationInfo>();
		
		for (int j = 0; j < locationsCount; j++) {
			LocationInfo locInfo 	= new LocationInfo();
			
			locInfo.stateCd 		= apData.getFieldValue("Location.Addr.StateProvCd", j, "");
			locInfo.locationRef 	= apData.getAttributeText ("Location", j, "id");
			locInfo.locationSeq 	= (j + 1)+"";
			locInfo.addr1 			= apData.getFieldValue("Location.Addr.Addr1", j, "");
			locInfo.addr2 			= apData.getFieldValue("Location.Addr.Addr2", j, "");
			locInfo.city 			= apData.getFieldValue("Location.Addr.City", j, "");
			locInfo.zip 			= apData.getFieldValue("Location.Addr.PostalCode", j, "");
			
			locations.put(locInfo.locationRef, locInfo);
		}
		
		return locations;
	}
}
