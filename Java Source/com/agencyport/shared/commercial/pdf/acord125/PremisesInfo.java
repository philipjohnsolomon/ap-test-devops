package com.agencyport.shared.commercial.pdf.acord125;

/**
 * The PremisesInfo class
 */
public class PremisesInfo {
	
	/**
	 * The <code>location</code>
	 */
	public LocationInfo location;
	
	/**
	 * The <code>numEmployess</code>
	 */
	public String numEmployess; 	
	/**
	 * The <code>annualRevenue</code>
	 */
	protected String annualRevenue;	
	/**
	 * The <code>interest</code>
	 */
	public String interest;
	/**
	 * The <code>partOccupied</code>
	 */
	public String partOccupied;
	/**
	 * The <code>yearBuilt</code>
	 */
	public String yearBuilt;
	/**
	 * The <code>description</code>
	 */
	public String description;
	/**
	 * The <code>buildingNum</code>
	 */
	public Integer buildingNum;
	
	/**
	 * Default Constructor
	 */
	public PremisesInfo () {
		location = new LocationInfo();
	}
	

}