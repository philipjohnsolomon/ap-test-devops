package com.agencyport.shared.apps.common.utils;


import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.agencyport.logging.LoggingManager;
import com.agencyport.service.text.StringUtilities;

/**
 * The NumberFormatter class contains some number formatting utility functions.
 */
 public final class NumberFormatter {

	/**
	 * The <code>LOGGER</code> is our logger.
	 */
	private static final Logger LOGGER = LoggingManager.getLogger(NumberFormatter.class.getPackage().getName());
	
	/**
	 * The <code>CURRENCY_SYMBOL</code> should be driven by locale-specific properties;
	 * for now, hard coding to US dollars.
	 */
	private static String CURRENCY_SYMBOL = "$";
	
	
	/**
	 * private constructor
	 */
	private NumberFormatter() {
		
	}
	/**
	 * Method makeMoney - Given something like 100000 return $100,000.00
	 * @param num
	 * @return formatted Double value in String Format
	 */
	

	public static String makeMoney(String num) {
		
		if (num == null || num.length() == 0) {
			return "";
		}
		
		NumberFormat nf = NumberFormat.getCurrencyInstance();
		return nf.format(Double.parseDouble(num));		
	}	
	/**
	 * @param num
	 * @return value in String Format
	 */
	public static String makeMoney(int num) {
		
		return makeMoney(Integer.toString(num));
	}	
	/**
	 * @param num
	 * @return value in String Format
	 */
	public static String makeMoney(double num) {
		
		return makeMoney(Double.toString(num));
	}	

	/**
	 * Equivalent to makeMoneyTrim, except with a better(?) name;
	 * format a number as currency, without a fractional component.
	 * @param num
	 * @return value of Whole number in String
	 */
	public static String makeMoneyWhole(String num ) {
		return makeMoneyTrim(num);
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
	
		int i = moneyWithCents.indexOf('(');	
		
		// Is it negative?
		if (i == -1) {
			
			return moneyWithCents.substring(0, moneyWithCents.indexOf('.'));
		} else {
			return moneyWithCents.substring(0, moneyWithCents.indexOf('.')) + ")";			
		}
			
	}	
	/**
	 * @param num
	 * @return String
	 */
	public static String makeMoneyTrim(int num) {
		
		return makeMoneyTrim(Integer.toString(num));
	}	
	/**
	 * @param num
	 * @return String
	 */
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
		try {
			formattedNum = nf.format(Double.parseDouble(num));		
		} catch(Exception ex) {
			LOGGER.log(Level.FINE,ex.getMessage(), ex);
			return num;
		}
		return formattedNum;					
	}
	/**
	 * @param num
	 * @return String
	 */
	public static String commatize(int num) {
		
		return commatize(Integer.toString(num));
	}	
	/**
	 * @param num
	 * @return String
	 */
	public static String commatize(double num) {
		
		return commatize(Double.toString(num));
	}
	/**
	 * @param num
	 * @return String
	 */
	public static String commatize(float num) {
		
		return commatize(Float.toString(num));
	}

	/**
		 * Method makePercent - This allows 4 digits: .0172 is returned as 1.72%
		 * 
		 * 						It also turns negatives into the () style so
		 * 						-.0172 comes back as (1.72%)
	     * @param percentIn is 
		 * @return String
		 */
		public static String makePercentStyle2(String percentIn) {

			if (percentIn == null || percentIn.length() == 0) {
				return "";
			}
		
			int i = percentIn.indexOf('-');
		
			NumberFormat nf = NumberFormat.getPercentInstance();
			nf.setMaximumFractionDigits(4);
		
			if (i == 0) {
		
				return "(" +
						 nf.format(Float.parseFloat(percentIn.substring(1))) +
						")";
			}
		
			return nf.format(Float.parseFloat(percentIn));		 
		}
	/**
	 * Method makePercent - Given .45 returns 45% Given 1.45 returns 145%
	 * @param percentIn 
	 * @return String
	 */
	public static String makePercent(String percentIn) {

		if (percentIn == null || percentIn.length() == 0) {
			return "";
		}
		
		NumberFormat nf = NumberFormat.getPercentInstance();
		return nf.format(Double.parseDouble(percentIn));		 
	}

	/**
	 * @param percentIn
	 * @return String
	 */
	public static String makePercentWithDecimals(String percentIn){
		if (percentIn == null || percentIn.length() == 0) {
			return "";
		}
		NumberFormat nf = NumberFormat.getPercentInstance();
		nf.setMaximumFractionDigits(2);
		return nf.format(Double.parseDouble(percentIn));
	}
	
		// ROUNDING FUNCTIONS

	
   /**
 * @param in
 * @return String
 */
public static String round2Decimals(float in) {

		// Round to 2 digits right of decimal point

      
		BigDecimal bd = new BigDecimal(Float.toString(in));

		bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}

	/**
	 * @param in
	 * @return String
	 */
	public static String round2Decimals(double in) {

		// Round to 2 digits right of decimal point

		BigDecimal bd = BigDecimal.valueOf(in);

		bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}

   /**
 * @param in
 * @return String
 */
public static String roundToInt(float in) {

		// Round to 2 digits right of decimal point

      

		BigDecimal bd = new BigDecimal(Float.toString(in));

		bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}

	/**
	 * @param in
	 * @return String
	 */
	public static String roundToInt(double in) {

		// Round to whole number, return String

		BigDecimal bd = BigDecimal.valueOf(in);

		bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}

	/**
	 * @param in
	 * @return int
	 */
	public static int roundToInt2(double in) {

		// Round to whole number, return int

		BigDecimal bd = BigDecimal.valueOf(in);

		bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);

		return bd.intValue();
	}


   /**
 * @param in
 * @return String
 */
public static String roundString(String in) {

		// Round to a whole number

		if (in == null || in.length() == 0) {
			return "";
		}

		int i = in.indexOf('.');
		
		if (i == -1) {
			return in;
		}

        double mydouble = new Float(in).doubleValue();

		BigDecimal bd = BigDecimal.valueOf(mydouble);

		bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);

		return bd.toString();
	}
	
	/**
	 * This method returns the amount without ',' characters in the amount string
	 *  because this will cause problem with money formating
	 * @param moneyWithCommas
	 * @return String
	 */
	public static String moneyWithoutCommas(String moneyWithCommas) {
			
		StringBuilder sbAmount = new StringBuilder(100);
		char[] charAmount = moneyWithCommas.toCharArray();
		for (int i=0; i < charAmount.length; i++) {
			if(! (charAmount[i]== ',')) {
				sbAmount.append(charAmount[i]);
			}
		}
		
		return sbAmount.toString();
	}
	
	/**
	 * @param amount
	 * @param withSign
	 * @return String
	 */
	public static String getCommatizeDollars(String amount, boolean withSign) {
		String amtStr = "";
		try{
			if(amount != null && amount.length() > 0){
				NumberFormat nf = NumberFormat.getCurrencyInstance();
				amtStr = nf.format(Double.parseDouble(amount));
				if(!withSign){
					amtStr = amtStr.substring(1);
				}
			}
		}catch(Exception ex){
			LOGGER.log(Level.WARNING,"Unable to convert in to currency (amount): "  + amount 
					+ " Message: " + ex.getMessage(),ex);
		}
		return amtStr;
	}
	
	
	/**
	 * This method parses the Commatized number in to a valid number.
	 * 
	 * @param displayValue
	 * @return String
	 */
	public static String getParsedNumber(String displayValue){
		String tempValue;
			if ( displayValue == null || displayValue.length() == 0) {
				return displayValue;
			} else {
				NumberFormat format = null;
				
				try {
					if (displayValue.startsWith(CURRENCY_SYMBOL)) {
						// Convert from display format to storage format
						format = NumberFormat.getCurrencyInstance();
					}else {
						format = NumberFormat.getNumberInstance();
					}
					Number parsedNum = format.parse(displayValue);
					return String.valueOf(parsedNum);
				}catch (Exception ex){
					LOGGER.log(Level.WARNING,"Unable to convert the value : "  + displayValue 
				 + " in to number instance. Message: " + ex.getMessage(), ex);	
					
					tempValue = "";
			   }		
			}
			return tempValue;		
	}
	/**
	    * Get the dollar amount in currency format
	    * @param amount The amount 
	    * @param withSign boolean true if the retuned currency amount should contain $ sign or false if not 
	    * @return The dollar amount in currency format
	    */
	   public static String getDollarAmt(String amount, boolean withSign){
			String amtStr = "";
			try{
				if(!StringUtilities.isEmptyOnTrim(amount)){
					amtStr = NumberFormat.getInstance().format(Double.parseDouble(amount));
					if(withSign){
						amtStr = "$" + amtStr;
					}
				}
			}catch(NumberFormatException ex){
				LOGGER.warning("Unable to convert in to currency (amount): "  + amount 
						+ " Message: " + ex.getMessage());
			}
			return amtStr;
		}	
}
