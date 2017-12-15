package com.agencyport.shared.pdf;

import java.text.NumberFormat;
import java.util.logging.Logger;

import com.agencyport.html.optionutils.OptionEntry;
import com.agencyport.html.optionutils.OptionList;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.logging.LoggingManager;
import com.agencyport.utils.text.StringUtilities;

/**
 * The PDFUtility class contains a few utilities for PDF rendering.
 */
public final class PDFUtility {
	
	/**
	 * The <code>LOGGER</code> is a reference to our logger.
	 */
	private static final Logger LOGGER = LoggingManager.getLogger(PDFUtility.class.getPackage().getName());
	
	/**
	 * Prevent accidental construction.
	 */
	private PDFUtility(){
		
	}
	
	/**
	 * Looks up the user friendly text value for a given select list value. This only supports
	 * static XML based lists with a reader of 'xmlreader'.
	 * @param listFile is the resource name of the code list XML file that contains the list. This is the same
	 * as the 'source' attribute in the TDF optionList element.
	 * @param listId is the id of the list. This is the same
	 * as the 'target' attribute in the TDF optionList element. 
	 * @param codeValue is the list code value to lookup.
	 * @return user friendly text value for the given select list code value.
	 */
	public static String translateCodeToText(String listFile, String listId, String codeValue) {
		OptionList lookupList = OptionsMap.getSingleList(new OptionList.Key("xmlreader", listFile, listId));
		OptionEntry optionEntry = lookupList.findFirstPrecise(codeValue);
		return optionEntry != null ? optionEntry.getDisplayText() : "";
	}
	
	/**
	 * Converts a '1' to Yes and anything else to No
	 * @param booleanZeroOrOneString is a 1 or 0.
	 * @return Yes for a 1 and anything else as a no.
	 */
	public static String getYesNoForBoolean(String booleanZeroOrOneString){
		return booleanZeroOrOneString.equals("1") ? "Yes" : "No"; 
	}
	
	/**
	    * Get the dollar amount in currency format
	    * @param amount The amount 
	    * @param withLeadingDollarSign boolean true if the returned currency amount should contain $ sign or false if not 
	    * @return The dollar amount in currency format
	    */
	   public static String getDollarAmt(String amount, boolean withLeadingDollarSign){
			String amtStr = "";
			try{
				if (!StringUtilities.isEmpty(amount)){
					NumberFormat nf = NumberFormat.getInstance();
					amtStr = nf.format(Double.parseDouble(amount));
					if (withLeadingDollarSign){
						amtStr = "$" + amtStr;
					}
				}
			}catch(NumberFormatException ex){
				LOGGER.warning("Unable to convert in to currency (amount): "  + amount + " Message: " + ex.getMessage());
			}
			return amtStr;
		}
}
