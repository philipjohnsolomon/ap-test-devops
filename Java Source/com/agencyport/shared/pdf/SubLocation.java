package com.agencyport.shared.pdf;
/*
 * Created Mar 29, 2005 by Ram Agencyport Insurance Services, Inc.
 */

/**
 * This class will store the information related to the Sub Location 
 * @author Ram
 *
 */
public class SubLocation {
	
	private String locationRef;
	private String number;
	private String description;
	private String subLocationId;
	
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getLocationRef() {
		return locationRef;
	}
	public void setLocationRef(String locationRef) {
		this.locationRef = locationRef;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	
	
	
	/**
	 * @return the subLocationId
	 */
	public String getSubLocationId() {
		return subLocationId;
	}
	/**
	 * @param subLocationId the subLocationId to set
	 */
	public void setSubLocationId(String subLocationId) {
		this.subLocationId = subLocationId;
	}
	/**
	 * Get the object's state in string format
	 */
	public String toString(){
		
		StringBuffer buffer = new StringBuffer();
		buffer.append("locationRef:"+locationRef)
			  .append("number:"+number)
			  .append("subLocationRef:"+subLocationId)
			  .append("description:"+description);
		
		return buffer.toString();		
	}
}
