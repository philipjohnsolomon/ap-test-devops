package com.agencyport.shared.pdf;

/**
 * @author djenner
 *
 */
public class DataConverter {


	/**
	 * Method standardDateFormat.
	 * @param date	ACORD date in YYYY-MM-DD format
	 * @return String	In MM/DD/YYYY format
	 */
	public static String standardDateFormat(String date)
	{
		if (date != null && !date.equals(""))
		{
			  //YYYY-MM-DD
			  //0123456789
			  if (date.length() != 10)
			  {
				  return "";
			  }
	
			  return date.substring(5,7) + "-" + date.substring(8) + "-" + date.substring(0, 4);
		}
		return "";
			
	}	
	/**
	 * Method twoDigitYearDateFormat.
	 * @param date	ACORD date in YYYY-MM-DD format
	 * @return String	In MM-DD-YY format
	 */
	public static String twoDigitYearDateFormat(String date)
	{
		if (date != null && !date.equals(""))
		{
			  //YYYY-MM-DD
			  //0123456789
			  if (date.length() != 10)
			  {
				  return "";
			  }
	
			  return date.substring(5,7) + "-" + date.substring(8) + "-" + date.substring(2, 4);
		}
		return "";
			
	}
		
}