/**
 * Created Mar 29, 2005 by Ram Agencyport Insurance Services, Inc.
 */
package com.agencyport.shared.commercial.candidates;

import java.util.ArrayList;
import java.util.List;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.shared.pdf.SubLocation;
/**
 * This class will store the information related to the Location
 * @author Ram
 *
 */
public class Location  {
	
   /**
 * The <code>number</code> is a private string variable.
 */
private String number;
   /**
 * The <code>id</code> is a private string variable.
 */
private String id;
   /**
 * The <code>addrLine1</code> is a private string variable.
 */
private String addrLine1;
   /**
 * The <code>addrLine2</code> is a private string variable.
 */
private String addrLine2;
   /**
 * The <code>city</code> is a private string variable.
 */
private String city;
   /**
 * The <code>state</code> is a private string variable.
 */
private String state;
   /**
 * The <code>zipCode</code> is a private string variable.
 */
private String zipCode;
   /**
 * The <code>located</code> is a private string variable.
 */
private String located;
   /**
 * The <code>taxCode</code> is a private string variable.
 */
private String taxCode;
   /**
 * The <code>fireDistrictNameOrCode</code> is a private string variable.
 */
private String fireDistrictNameOrCode;

/**
 * The <code>LOCATION_ID_CONSTANT</code> is a string constant.
 */
private static final String LOCATION_ID_CONSTANT="Location[@id='[";
   
    /**
     * Get the address line 1
     * @return String
     */
	public String getAddrLine1() {
		return addrLine1;
	}
	/**
	 * Set the address line 1
	 * @param addrLine1
	 */
	public void setAddrLine1(String addrLine1) {
		this.addrLine1 = addrLine1;
	}
	/**
	 * Get address line 2
	 * @return String
	 */
	public String getAddrLine2() {
		return addrLine2;
	}
	/**
	 * Set address line 2
	 * @param addrLine2
	 */
	public void setAddrLine2(String addrLine2) {
		this.addrLine2 = addrLine2;
	}
	/**
	 * Get City
	 * @return String
	 */
	public String getCity() {
		return city;
	}
	/**
	 * Set city
	 * @param city
	 */
	public void setCity(String city) {
		this.city = city;
	}
	/**
	 * Get fire district name or code
	 * @return String
	 */
	public String getFireDistrictNameOrCode() {
		return fireDistrictNameOrCode;
	}
	/**
	 * Set fire district name or code
	 * @param fireDistrictNameOrCode
	 */
	public void setFireDistrictNameOrCode(String fireDistrictNameOrCode) {
		this.fireDistrictNameOrCode = fireDistrictNameOrCode;
	}
	/**
	 * Get located info
	 * @return String
	 */
	public String getLocated() {
		return located;
	}
	/**
	 * Set located info
	 * @param located
	 */
	public void setLocated(String located) {
		this.located = located;
	}
	/**
	 * Get the number
	 * @return String
	 */
	public String getNumber() {
		return number;
	}
	/**
	 * Set the number
	 * @param number
	 */
	public void setNumber(String number) {
		this.number = number;
	}
	/**
	 * Get the state
	 * @return String
	 */
	public String getState() {
		return state;
	}
	/**
	 * Set state
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	/**
	 * Get Taxcode
	 * @return String
	 */
	public String getTaxCode() {
		return taxCode;
	}
	/**
	 * Set the taxcode
	 * @param taxCode
	 */
	public void setTaxCode(String taxCode) {
		this.taxCode = taxCode;
	}
	/**
	 * Get the ZIP code
	 * @return String
	 */
	public String getZipCode() {
		return zipCode;
	}
	/**
	 * Set the ZIP code
	 * @param zipCode
	 */
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;			
	} 
	
	/**
	 * Get the id
	 * @return The id
	 */
	public String getId() {
		return id;
	}
	
	/**
	 * Set the id
	 * @param  id 
	 */
	public void setId(String id) {
		this.id = id;
	}
	
	/**
	 * Get the object's state in a string format
	 * @return String
	 */
	@Override
	public String toString(){
		
		StringBuilder buffer = new StringBuilder();
		return buffer
				.append("number:").append(number).append("\n")
				.append("id:").append(id).append("\n")
	            .append("addrLine1:").append(addrLine1).append("\n")
	            .append("addrLine2:").append(addrLine2).append("\n")
	            .append("city:").append(city).append("\n")
	            .append("state:").append(state).append("\n")
	            .append("zipCode:").append(zipCode).append("\n")
	            .append("located:").append(located).append("\n")
	            .append("taxCode:").append(taxCode).append("\n")
	            .append("fireDistrictNameOrCode:").append(fireDistrictNameOrCode).append("\n")
	            .toString();		
	}
	
	/**
	    * This should be used only if the underlying "location" page is being sourced from 125Commons
	    * @author Ram Kolla
	    * @param data The APDataCollection object
	    * @return Returns the list of Locations by reading the Location info from the underlying XML 
	    * 
	    */
	   public static List<Location> getLocations(APDataCollection data){
		   
		   List<Location> locations  = new ArrayList<Location>();
		   if(data == null){
			   return locations;
		   }
		   int count = data.getCount("Location");
		   
		   for(int i =0; i < count ; i++){
			   String id=data.getAttributeText("Location", i, "id");
			   Location location = getLocation(id,data);			  
			   location.setNumber(""+(i+1));			   
			   locations.add(location);
		   }
		   return locations;
	   }
	   
	   /**
	    * Get the location given the id from the Location Aggregate in the APDataCollection
	    * @param id
	    * @param data
	    * @return location Object
	    */
	   public static Location getLocation(String id,APDataCollection data){
		   
		   Location location  = new Location();
		   
		   location.setId(id);
		   location.setAddrLine1(data.getFieldValue(LOCATION_ID_CONSTANT+id+"'].Addr.Addr1", ""));
		   location.setAddrLine2(data.getFieldValue(LOCATION_ID_CONSTANT+id+"'].Addr.Addr2", ""));
		   location.setCity(data.getFieldValue(LOCATION_ID_CONSTANT+id+"'].Addr.City", ""));
		   location.setState(data.getFieldValue(LOCATION_ID_CONSTANT+id+"'].Addr.StateProvCd", ""));
		   location.setZipCode(data.getFieldValue(LOCATION_ID_CONSTANT+id+"'].Addr.PostalCode",""));
		   location.setTaxCode(data.getFieldValue(LOCATION_ID_CONSTANT+id+"'].TaxCodeInfo[TaxTypeCd='Prop'].TaxCd", ""));
		   location.setFireDistrictNameOrCode(data.getFieldValue(LOCATION_ID_CONSTANT+id+"'].FireDistrict",""));
		   location.setLocated(data.getFieldValue(LOCATION_ID_CONSTANT+id+"'].RiskLocationCd",""));		   
		   return location;		   
	   } 
	   
	   /**
	 * @param locationRef
	 * @param data
	 * @return list of sub locations
	 */
	public static List<SubLocation> getSubLocations(String locationRef , APDataCollection data){
		   List<SubLocation> subLocations = new ArrayList<SubLocation>();
		   if(locationRef == null || data == null){
			   return subLocations;
		   }
		   int subLocCount = data.getCount("Location.SubLocation[@LocationRef='"+locationRef+"']");
		   
		   for(int i=0;i < subLocCount;i++){
			   SubLocation subLocation = new SubLocation();
			   subLocation.setLocationRef(locationRef);
			   subLocation.setNumber(""+(i+1));
			   subLocation.setDescription(data.getFieldValue("Location.SubLocation[@LocationRef='"+locationRef+"'].SubLocationDesc",i,""));
			   subLocations.add(subLocation);
		   }
		   return subLocations;
		   
	   }
	
}
