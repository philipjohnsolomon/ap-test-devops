/**
 * Dec 31, 2005  @author Agencyport Insurance Services, Inc.
 */
package com.agencyport.shared.custom;

import org.jdom2.Element;

import com.agencyport.domXML.view.TransformSingleValueView;
import com.agencyport.shared.APException;


/**
 * The NumberFormatView class
 */
public class NumberFormatView extends TransformSingleValueView {
	
	/**
	 * The <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 1L;
	// String constants for limit field formating defined in view file 
	/**
	 * The <code>numberStorageType</code> is a string variable.
	 */
	protected String numberStorageType = "NUMBER_STORAGE" ;
	/**
	 * The <code>numberDisplayType</code>is a string variable.
	 */
	protected String numberDisplayType = "NUMBER_DISPLAY" ;
	
	//	String constants for currency field formating defined in view file 
	/**
	 * The <code>currencyDisplayType</code>is a string variable.
	 */
	protected String currencyDisplayType = "CURRENCY_DISPLAY" ;
	/**
	 * The <code>currencyStorageType</code>is a string variable.
	 */
	protected String currencyStorageType = "CURRENCY_STORAGE" ;
	
	
	/**
	 * The <code>displayFormat</code>is a string variable.
	 */
	protected String displayFormat = null;
	/**
	 * The <code>storageFormat</code>is a string variable.
	 */
	protected String storageFormat = null;
	
	/* (non-Javadoc)
	 * @see com.agencyport.domXML.view.IView#init(org.jdom2.Element)
	 */
	@Override
	public void init(Element viewElement) throws APException {		
		super.init(viewElement);
		String viewDisplayFormat = viewElement.getAttributeValue("displayFormat");
		if ( viewDisplayFormat != null ){
			this.displayFormat = viewDisplayFormat;
		}
		String viewStorageFormat = viewElement.getAttributeValue("storageFormat");
		if ( viewStorageFormat != null ){
			this.storageFormat = viewStorageFormat;
		}
	}
	
	/* (non-Javadoc)
	 * @see com.agencyport.domXML.view.TransformSingleValueView#formatForUpdate(java.lang.String)
	 */
	@Override
	protected String formatForUpdate(String displayValue){
		
		if(displayFormat.equalsIgnoreCase(numberDisplayType) || 
				displayFormat.equalsIgnoreCase(currencyDisplayType)){	
			return  com.agencyport.shared.apps.common.utils.NumberFormatter.getParsedNumber(displayValue);
		}
		
		return displayValue;		
	}
	
	/* (non-Javadoc)
	 * @see com.agencyport.domXML.view.TransformSingleValueView#formatForDisplay(java.lang.String)
	 */
	@Override
	public String formatForDisplay(String storedValue) {
		if(displayFormat.equalsIgnoreCase(numberDisplayType)){			
			return com.agencyport.shared.apps.common.utils.NumberFormatter.commatize(storedValue);
		}	
		
		if (displayFormat.equalsIgnoreCase(currencyDisplayType)){
			return com.agencyport.shared.apps.common.utils.NumberFormatter.makeMoney(storedValue);
		}
		return storedValue;
	}
}
