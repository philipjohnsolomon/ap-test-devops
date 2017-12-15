/*
 * Created on October 12, 2005
 */
package com.agencyport.shared.apps.common.utils;

//j2se dependencies
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.agencyport.logging.LoggingManager;
import com.agencyport.utils.APDate;

/**
 * Utility Date Class. 
 * Provides static utility methods for special Date operations.
 */
public final class CustomDateUtil {
	
	/**
	 * The <code>LOGGER</code> is my Logger
	 */
	private static final Logger LOGGER = 
		LoggingManager.getLogger(CustomDateUtil.class.getPackage().getName());
	
	/**
	 * The <code>DATE_FORMAT_YYYY_DASH_MM_DASH_DD</code> is Year-Month-Day date format
	 */
	public static final String DATE_FORMAT_YYYY_DASH_MM_DASH_DD = "yyyy-MM-dd";
	/**
	 * The <code>DATE_FORMAT_MM_DASH_DD_DASH_YYYY</code> is Month-Day-year date format
	 */
	public static final String DATE_FORMAT_MM_DASH_DD_DASH_YYYY = "MM-dd-yyyy";
	/**
	 * The <code>DATE_FORMAT_MM_SLASH_DD_SLASH_YYYY</code> is Month/Day/year date format
	 */
	public static final String DATE_FORMAT_MM_SLASH_DD_SLASH_YYYY = "MM/dd/yyyy";
	
	
	
	/**
	 * Restricts instantiation from outside of this class.
	 * No reason to have an instance of this class as it contains only static
	 * methods.
	 */
	private CustomDateUtil(){
	}
	
	/**
	 * Given a start date and end date it calculates number of years in between.
	 * 
	 * @param startDate the start date
	 * @param endDate the end date
	 * @return number of years in between
	 */
	public static int calcYearsBetween(Date startDate, Date endDate) {
		int yearsBetween = 0;
		if (startDate == null || endDate == null){
			return yearsBetween;
		}
		//Start date after end date or same
		if (startDate.compareTo(endDate) >= 0){ 
			return yearsBetween;
		}

		Calendar cal = Calendar.getInstance();
		cal.setTime(endDate);
		cal.add(Calendar.YEAR, -1);
		Date tempEndDate = cal.getTime();
		while (tempEndDate.compareTo(startDate) >= 0){		
			yearsBetween++;
			cal.setTime(tempEndDate);
			cal.add(Calendar.YEAR, -1);
			tempEndDate = cal.getTime();
		}
		return yearsBetween;
	}
	
	/**
	 * Given the date string in the format yyyy-MM-dd , this method
	 * return one year older date as a string in MM-dd-yyyy. If the given date is
	 * invalid, it returns the empty string.
	 * 
	 * @param dateStr date to be calculated from.
	 * @return one year older date from the given date
	 */
	public static String getOneYearOldDate(String dateStr){
		String resultDtStr = "";
	
		if(dateStr == null || dateStr.length() <= 0){
			return resultDtStr;
		}
		try{
			APDate apDate = new APDate();
			apDate.set(dateStr, APDate.DEFAULT_DATE_FORMAT);			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(apDate.getUtilDate());
			int year = calendar.get(Calendar.YEAR);
			calendar.set(Calendar.YEAR, year - 1);
			APDate apDate2 = new APDate(calendar.getTime());
			resultDtStr = apDate2.getStringDate(APDate.DATE_FORMAT_MM_DD_YYYY);
		
		}catch(Exception pex){
			LOGGER.log(Level.FINE, pex.getMessage(),pex);
			resultDtStr = "";
		}		
		return resultDtStr;
	}
	
	/**
	 * Formats the given date from currentFormat to resultingFormat
	 * @param strDate The date to be formatted.
	 * @param currentFormat Current format
	 * @param resultingFormat Resulting format
	 * @return The formatted date
	 */
	public static String format(String strDate , String currentFormat , String resultingFormat ){
		String retValue = "";		
	    if(strDate == null || 
	    		currentFormat == null ||
	    		resultingFormat == null ||
	    		strDate.length() <= 0){
	    	return retValue;
	    }
	    try {
			SimpleDateFormat format = new SimpleDateFormat(currentFormat);
			Date date = format.parse(strDate);
			retValue = new SimpleDateFormat(resultingFormat).format(date);
			
		} catch (Exception e) {
			LOGGER.log(Level.FINEST,"Unable to parse the date :" + strDate,e);
			retValue = strDate;
		}
	
		return retValue;
		
	}
		
	
	/**
	 * Self Tester.
	 * 
	 * @param args
	 * @throws ParseException
	 */
	public static void main(String[] args) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat(CustomDateUtil.DATE_FORMAT_YYYY_DASH_MM_DASH_DD);
		
		int yearsBetween = CustomDateUtil.calcYearsBetween(sdf.parse("2004-06-30"), sdf.parse("2005-06-30"));
		LOGGER.log(Level.FINE,yearsBetween == 1 ? "pass" : "fail. expected 1 returned" + yearsBetween);
		yearsBetween = CustomDateUtil.calcYearsBetween(sdf.parse("2004-06-30"), sdf.parse("2005-06-29"));
		LOGGER.log(Level.FINE,yearsBetween == 0 ? "pass" : "fail. expected 0 returned" + yearsBetween);
		
		yearsBetween = CustomDateUtil.calcYearsBetween(sdf.parse("2004-01-29"), sdf.parse("2005-06-30"));
		LOGGER.log(Level.FINE,yearsBetween == 1 ? "pass" : "fail. expected 1 returned" + yearsBetween);
		
		yearsBetween = CustomDateUtil.calcYearsBetween(sdf.parse("2001-01-01"), sdf.parse("2005-01-01"));
		LOGGER.log(Level.FINE,yearsBetween == 4 ? "pass" : "fail. expected 4 returned" + yearsBetween);
		
	}
}
