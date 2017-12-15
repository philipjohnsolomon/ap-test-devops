package com.agencyport.shared.pdf;

import java.util.ArrayList;
import java.util.List;

/**
 * The AdditionalDataSupport class provides the basic support for all additional data derivations
 * specific to many Acord form types.
 */
public abstract class AdditionalDataSupport {
	/**
	 * The <code>maxSizeAllowed</code> is the maximum number of rows of data allowed.
	 */
	protected final int maxSizeAllowed;
	/**
	 * The <code>additionalPageContent</code> contains the additional rows of page content.
	 */
	protected final List<String>  additionalPageContent;
	
	/**
	 * Constructs an instance.
	 */
	protected AdditionalDataSupport() {
		this(0);
	}
	
	/**
	 * Constructs an instance.
	 * @param maxRows specifies the maximum number of rows allowed.
	 */
	protected AdditionalDataSupport(int maxRows) {
		this(maxRows, new ArrayList<String>());
	}
	
	/**
	 * Constructs an instance.
	 * @param maxRows specifies the maximum number of rows allowed.
	 * @param additionalPageContent contains the initial additional page content.
	 */
	protected AdditionalDataSupport(int maxRows, List<String> additionalPageContent) {
		maxSizeAllowed = maxRows;
		this.additionalPageContent = additionalPageContent;
	}
		
	/**
	 * Returns whether or not there is any additional information available.
	 * @return <code>true</code> if there is any additional information available. 
	 */
	public boolean isAdditionalInfoAvailable() {
		return (additionalPageContent.size() != 0);
	}
	
	/**
	 * Returns a direct reference to the additional page data list.
	 * @return a direct reference to the additional page data list.
	 */
	public List<String> getAdditionalPageData(){
		return additionalPageContent;
	}
	
	/**
	 * Adds a text line to the additional data list.
	 * @param text is the text line to add.
	 */
	public void addAdditionalText(String text){
		additionalPageContent.add(text);
	}

	/**
	 * Looks up the user friendly text value for a given select list value. This only supports
	 * static XML based lists with a reader of 'xmlreader'.
	 * @param codeValue is the list code value to lookup.
	 * @param listFile is the resource name of the code list XML file that contains the list. This is the same
	 * as the 'source' attribute in the TDF optionList element.
	 * @param listName is the name or target of the list. This is the same
	 * as the 'target' attribute in the TDF optionList element. 
	 * @return user friendly text value for the given select list code value.
	 */
	public static String getDisplayTextForValue(String codeValue, String listFile, String listName){
		return PDFUtility.translateCodeToText(listFile, listName, codeValue);
	}	
}
