package com.agencyport.shared.pdf;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.logging.Logger;

import com.agencyport.logging.LoggingManager;

/**
 * @author djenner
 *
 * To change this generated comment edit the template variable "typecomment":
 * Window>Preferences>Java>Templates.
 * To enable and disable the creation of type comments go to
 * Window>Preferences>Java>Code Generation.
 */
public class NumberFormatter {

	/**
	 * The <code>LOGGER</code> is the logger for this class.
	 */
	private static final Logger LOGGER = LoggingManager.getLogger(NumberFormatter.class.getPackage().getName());
	/**
	 * Method makeMoney - Given something like 100000 return $100,000.00
	 * @param num
	 * @return String
	 */
	public static String makeMoney(String num) {
		
		if (num == null || num.length() == 0) {
			return "";
		}
		
		NumberFormat nf = NumberFormat.getCurrencyInstance();
		return nf.format(Double.parseDouble(num));		
	}	
	public static String makeMoney(int num) {
		
		return makeMoney(Integer.toString(num));
	}	
	public static String makeMoney(double num) {
		
		return makeMoney(Double.toString(num));
	}	


	/**
	 * Method makeMoneyTrim - Given something like 100000 return $100,000
	 * @param num
	 * @return String
	 */
	public static String makeMoneyTrim(String num) {
		
		if (num == null || num.length() == 0) {
			return "";
		}

		NumberFormat nf = NumberFormat.getCurrencyInstance();
		String moneyWithCents = nf.format(Double.parseDouble(num));
	
		int i = moneyWithCents.indexOf("(");	// Is it negative?
		
		if (i == -1) {
		
			return moneyWithCents.substring(0, moneyWithCents.indexOf("."));
		}
		else {
			return moneyWithCents.substring(0, moneyWithCents.indexOf(".")) + ")";			
		}
			
	}	
	public static String makeMoneyTrim(int num) {
		
		return makeMoneyTrim(Integer.toString(num));
	}	
	public static String makeMoneyTrim(double num) {
		
		return makeMoneyTrim(Double.toString(num));
	}	

	/**
	 * Method makeMoneyTrim - Given something like 100000 return 100,000
	 * @param num
	 * @return String
	 */
	public static String commatize(String num) {

		String formattedNum;
		if (num == null || num.length() == 0) {
			return "";
		}
		
		NumberFormat nf = NumberFormat.getInstance();
		try 
		{
			formattedNum = nf.format(Double.parseDouble(num));		
		}
		catch(Exception ex)
		{
			return num;
		}
		return formattedNum;					
	}
	public static String commatize(int num) {
		
		return commatize(Integer.toString(num));
	}	
	public static String commatize(double num) {
		
		return commatize(Double.toString(num));
	}
	public static String commatize(float num) {
		
		return commatize(Float.toString(num));
	}

	/**
		 * Method makePercent - This allows 4 digits: .0172 is returned as 1.72%
		 * 
		 * 						It also turns negatives into the () style so
		 * 						-.0172 comes back as (1.72%)
		 * @param percent_in
		 * @return String
		 */
		public static String makePercentStyle2(String percent_in) {

			if (percent_in == null || percent_in.length() == 0) {
				return "";
			}
		
			int i = percent_in.indexOf("-");
		
			NumberFormat nf = NumberFormat.getPercentInstance();
			nf.setMaximumFractionDigits(4);
		
			if (i == 0) {
		
				return "(" +
						 nf.format(Float.parseFloat(percent_in.substring(1))) +
						")";
			}
		
			return nf.format(Float.parseFloat(percent_in));		 
		}
	/**
	 * Method makePercent - Given .45 returns 45% Given 1.45 returns 145%
	 * @param percent_in
	 * @return String
	 */
	public static String makePercent(String percent_in) {

		if (percent_in == null || percent_in.length() == 0) {
			return "";
		}
		
		NumberFormat nf = NumberFormat.getPercentInstance();
		return nf.format(Double.parseDouble(percent_in));		 
	}

	public static String makePercentWithDecimals(String percent_in){
		if (percent_in == null || percent_in.length() == 0) {
			return "";
		}
		NumberFormat nf = NumberFormat.getPercentInstance();
		nf.setMaximumFractionDigits(2);
		return nf.format(Double.parseDouble(percent_in));
	}
	
		// ROUNDING FUNCTIONS

	
   public static String round2Decimals(float in) {

		// Round to 2 digits right of decimal point

        double mydouble = new Float(in).doubleValue();

		BigDecimal bd = new BigDecimal(mydouble);

		bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}

	public static String round2Decimals(double in) {

		// Round to 2 digits right of decimal point

		BigDecimal bd = new BigDecimal(in);

		bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}

   public static String roundToInt(float in) {

		// Round to 2 digits right of decimal point

        double mydouble = new Float(in).doubleValue();

		BigDecimal bd = new BigDecimal(mydouble);

		bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}

	public static String roundToInt(double in) {

		// Round to whole number, return String

		BigDecimal bd = new BigDecimal(in);

		bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}

	public static int roundToInt2(double in) {

		// Round to whole number, return int

		BigDecimal bd = new BigDecimal(in);

		bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);

		return bd.intValue();
	}


   public static String roundString(String in) {

		// Round to a whole number

		if (in == null || in.length() == 0) {
			return "";
		}

		int i = in.indexOf(".");
		
		if (i == -1) {
			return in;
		}

        double mydouble = new Float(in).doubleValue();

		BigDecimal bd = new BigDecimal(mydouble);

		bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}
	
	/**
	 * This method returns the amount without ',' characters in the amount string
	 *  because this will cause problem with money formating
	 * @param moneyWithCommas
	 * @return
	 */
	public static String moneyWithoutCommas(String moneyWithCommas)
	{
			
		StringBuffer sbAmount = new StringBuffer(100);
		char[] charAmount = moneyWithCommas.toCharArray();
		for (int i=0; i < charAmount.length; i++)
		{
			if(! (charAmount[i]== ','))
			{
				sbAmount.append(charAmount[i]);
			}
		}
		
		return sbAmount.toString();
	}
	
	public static String getCommatizeDollars(String amount, boolean withSign)
	{
		String amtStr = "";
		try{
			if(amount != null && amount.length() > 0){
				NumberFormat nf = NumberFormat.getCurrencyInstance();
				amtStr = nf.format(Double.parseDouble(amount));
				if(!withSign)
					amtStr = amtStr.substring(1);
			}
		}catch(Exception ex){
			LOGGER.warning("Unable to convert in to currency (amount): "  + amount 
					+ " Message: " + ex.getMessage());
		}
		return amtStr;
	}
	
	
	/**
	 * This method parses the Commatized number in to a valid number.
	 * 
	 * @param displayValue
	 * @return
	 */
	public static String getParsedNumber(String displayValue){
			if ( displayValue == null || displayValue.length() == 0) {
				return displayValue;
			}
			else {			
				try {
					// Convert from display format to storage format
					java.text.NumberFormat format = java.text.NumberFormat.getNumberInstance();			
					Number parsedNum = format.parse(displayValue);
					return String.valueOf(parsedNum);
				}catch (Exception ex){
					LOGGER.warning("Unable to convert the value : "  + displayValue 
				 + " in to number instance. Message: " + ex.getMessage());	
					
					displayValue = "";
			   }		
			}
			return displayValue;		
		}				
}
