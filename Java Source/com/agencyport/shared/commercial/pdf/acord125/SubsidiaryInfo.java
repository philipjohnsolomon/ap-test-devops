package com.agencyport.shared.commercial.pdf.acord125;

/**
 * The SubsidiaryInfo class
 */
public class SubsidiaryInfo {
	
	/**
	 * The <code>name</code>
	 */
	public String name;
	/**
	 * The <code>location</code>
	 */
	public LocationInfo location;
	
	/**
	 * The <code>numEmployess</code>
	 */
	public String numEmployess; 	
	/**
	 * The <code>annualPayroll</code>
	 */
	public String annualPayroll;
	/**
	 * The <code>annualSales</code>
	 */
	public String annualSales;
	/**
	 * The <code>foreignSales</code>
	 */
	public String foreignSales;
	
	/**
	 * 
	 */
	public SubsidiaryInfo () {
		location = new LocationInfo();
	}
	

}