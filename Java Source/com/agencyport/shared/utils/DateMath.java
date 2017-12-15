package com.agencyport.shared.utils;

import java.text.ParseException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.joda.time.DateTime;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.logging.LoggingManager;
import com.agencyport.utils.APDate;
import com.agencyport.utils.DateUtil;

/**
 * The DateMath class
 */
public class DateMath extends DateUtil {
	
	 
	 
	 
	/**
	 * The <code>calendar</code>
	 */

	
	/**
	 * The <code>LOGGER</code>is my logger.
	 */
	private static final Logger LOGGER = LoggingManager.getLogger(DateMath.class.getName());
	
	/**
	 * @param begin
	 * @param end
	 * @return int
	 */
	public static int yearDiff( String begin, String end ) {
		
		int yearDiff = 0;
		
		try {
			APDate beginAPDate = new APDate( begin );
			Date beginDate = beginAPDate.getUtilDate();
		
			APDate endAPDate = new APDate( end );
			Date endDate = endAPDate.getUtilDate();
		
			yearDiff = yearDiff( beginDate, endDate );
		}catch( ParseException ex ) {
			LOGGER.log(Level.FINE,ex.getMessage(),ex);
		}
		
		return yearDiff;
	}

	/**
	 * @param beginDate
	 * @param endDate
	 * @return int
	 */
	public static int yearDiff(Date beginDate, Date endDate ){
    	int yearDiff = 0;
    	
    	if( beginDate.getTime() < endDate.getTime() ) {
    		int begYear = getYearValue(beginDate);
	        int endYear = getYearValue(endDate);
	        
	        int yearSpan = endYear - begYear;
	        
	        yearDiff = yearSpan;
	        
	        int begMonth = getMonthValue(beginDate);
	    	int endMonth = getMonthValue(endDate);
	        
	        int monthDiff = endMonth - begMonth;
	        
	        //Check to make sure we account for month 
	        if (monthDiff < 0) {
	        	yearDiff--;
	        } else if (monthDiff == 0) {
	        	//check days is we're in the same month
	        	int begDayOfMonth  = getDayValue(beginDate);
	            int endDayOfMonth = getDayValue(endDate);
	            
	            int dayOfMonthDiff = endDayOfMonth - begDayOfMonth;
	            
	            if (dayOfMonthDiff < 0) {
	            	yearDiff--;
	            }       	
	        }
    	}
        
        return yearDiff;
    }
	
	/**
	 * @param thisDate
	 * @return int
	 */
	private static int getYearValue(Date thisDate){
		

		 return new DateTime(thisDate).getYear();
    }

    /**
     * @param thisDate
     * @return int
     */
    private static int getMonthValue(Date thisDate){
    	

        
    	 return new DateTime(thisDate).getMonthOfYear();
        
        
    }
 
    /**
     * @param thisDate
     * @return int
     */
    private static int getDayValue(Date thisDate){
    	

    return new DateTime(thisDate).getDayOfMonth();

    }
	/**
	 * 
	 * @param yearBuilt in the format YYYY
	 * @param acordData 
	 * @param effectiveDtPath 
	 * @return String
	 */
	public static String calculateAgeOfStructure(String yearBuilt, APDataCollection acordData, String effectiveDtPath){
		
		int structureAge = 0;
		String yearPart = "";
		
		String effectiveDt = acordData.getFieldValue(effectiveDtPath, "");
		
		if ((effectiveDt.length() > 0) && (yearBuilt.length() > 0)){
			yearPart = effectiveDt.substring(0, 4);	
			try {
				structureAge= Integer.parseInt(yearPart) - Integer.parseInt(yearBuilt);
			} catch (NumberFormatException e) {
				LOGGER.log(Level.FINE,e.getMessage(),e);
				
			}
		}
		return Integer.toString(structureAge);
	}	
}