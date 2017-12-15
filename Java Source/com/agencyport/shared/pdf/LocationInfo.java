package com.agencyport.shared.pdf;

import java.util.ArrayList;
import java.util.List;

import com.agencyport.domXML.APDataCollection;

public class LocationInfo {
	
	public String locationSeq;
	public String locationRef;
	public String stateCd;
	public String addr2;
	public String addr1;
	public String city;
	public String zip;
	public String cityLimits;
	public String taxCode;
	public String fireDistrict;
	public String highestFloorNumOccupied;
	
	
	public static List getSubLocations(String locationRef , APDataCollection data){
		   List subLocations = new ArrayList();
		   if(locationRef == null || data == null)
			   return subLocations;
		   
		   int subLocCount = data.getCount("Location[@id='"+locationRef+"'].SubLocation");
		   
		   for(int i=0;i < subLocCount;i++){
			   SubLocation subLocation = new SubLocation();
			   subLocation.setLocationRef(locationRef);
			   subLocation.setNumber(""+(i+1));
			   subLocation.setDescription(data.getFieldValue("Location[@id='"+locationRef+"'].SubLocation.SubLocationDesc",i,""));
			   subLocation.setSubLocationId(data.getFieldValue("Location[@id='"+locationRef+"'].SubLocation.@id",i,""));
			   subLocations.add(subLocation);
			   
		   }
		   return subLocations;
		   
	   }
}