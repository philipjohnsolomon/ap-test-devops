package com.agencyport.shared.commercial.pdf.acord125;

import java.util.ArrayList;
import java.util.List;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.shared.pdf.SubLocation;

/**
 * The LocationInfo class
 */
public class LocationInfo {
	
	/**
	 * The <code>locationSeq</code>
	 */
	public String locationSeq;
	/**
	 * The <code>locationRef</code>
	 */
	public String locationRef;
	/**
	 * The <code>stateCd</code>
	 */
	public String stateCd;
	/**
	 * The <code>addr2</code>
	 */
	public String addr2;
	/**
	 * The <code>addr1</code>
	 */
	public String addr1;
	/**
	 * The <code>city</code>
	 */
	public String city;
	/**
	 * The <code>zip</code>
	 */
	public String zip;
	/**
	 * The <code>cityLimits</code>
	 */
	public String cityLimits;
	/**
	 * The <code>taxCode</code>
	 */
	public String taxCode;
	/**
	 * The <code>fireDistrict</code>
	 */
	public String fireDistrict;
	/**
	 * The <code>LOCATION_ID_CONSTANT</code>
	 */
	private static final String LOCATION_ID_CONSTANT = "Location[@id='";
	
	/**
	 * @param locationRef
	 * @param data
	 * @return List of sublocations
	 */
	public static List<SubLocation> getSubLocations(String locationRef , APDataCollection data){
		   List<SubLocation> subLocations = new ArrayList<SubLocation>();
		   if(locationRef == null || data == null){
			   return subLocations;
		   }
		   int subLocCount = data.getCount(LOCATION_ID_CONSTANT+locationRef+"'].SubLocation");
		   
		   for(int i=0;i < subLocCount;i++){
			   SubLocation subLocation = new SubLocation();
			   subLocation.setLocationRef(locationRef);
			   subLocation.setNumber(""+(i+1));
			   subLocation.setDescription(data.getFieldValue(LOCATION_ID_CONSTANT+locationRef+"'].SubLocation.SubLocationDesc",i,""));
			   subLocation.setSubLocationId(data.getFieldValue(LOCATION_ID_CONSTANT+locationRef+"'].SubLocation.@id",i,""));
			   subLocations.add(subLocation);
			   
		   }
		   return subLocations;
		   
	   }
	
}