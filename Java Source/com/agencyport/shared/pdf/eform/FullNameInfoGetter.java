/*
 * Created on Aug 17, 2015 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.pdf.eform;

import java.util.Map;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.FieldValue;
import com.agencyport.pdf.IFieldValueGetter;
import com.agencyport.pdf.PDFContext;
import com.agencyport.pdf.resource.FormField;
import com.agencyport.service.text.StringUtilities;
import com.agencyport.shared.APException;

/**
 * The FullNameInfoGetter class provies full name support for party names that are stored either as commercial or personal
 * entities. This class requires an XPath up through including the NameInfo aggregate. When a personal name is encountered,
 * then the format returned is a first name mid initial last name order.  
 */
public class FullNameInfoGetter implements IFieldValueGetter {
	/**
	 * The <code>COMML_NAME_XPATHS</code> contains the XPath suffix for accessing a commercial NameInfo.
	 */
	private static final String[] COMML_NAME_XPATHS = {
		".CommlName.CommercialName"
	};
	
	/**
	 * The <code>PERS_NAME_XPATHS</code> contains the XPath suffixes for accessing a personal NameInfo.
	 */
	private static final  String[] PERS_NAME_XPATHS = {
		".PersonName.GivenName",
		".PersonName.OtherGivenName",
		".PersonName.Surname"
	};
	/**
	 * Constructs an instance.
	 */
	public FullNameInfoGetter() {
	}
	
	/**
	 * Returns the value for a set of name info XPath and XPath suffix combinations.
	 * @param nameInfoXPath is the name info XPath. The XPath up through and including the ACORD NameInfo
	 * aggregate. 
	 * @param partialXPathSuffixes is the set of XPath suffixes including the leading dot character that
	 * follow the NameInfo aggregate.
	 * @param dataSource is the data collection to read from.
	 * @param indices are the indices.
	 * @return the value for a set of name info XPath and XPath suffix combinations.
	 */
	private String getFullNameInfo(String nameInfoXPath, String[] partialXPathSuffixes, APDataCollection dataSource, int[] indices){
		StringBuilder fullName = new StringBuilder();
		
		for (String partialXPathSuffix : partialXPathSuffixes){
			String fullNameXPath = nameInfoXPath + partialXPathSuffix;
			fullName.append(dataSource.getFieldValue(fullNameXPath, indices, ""));
			fullName.append(' ');
		}
		
		return fullName.toString().trim();
	}

	/** 
	 * {@inheritDoc}
	 */

	@Override
	public FieldValue get(FormField field, PDFContext context, int[] indices, Map<String, String> customParams) throws APException {
		String configuredXPath = field.getXpath();
		if (StringUtilities.isEmptyOnTrim(configuredXPath) || !configuredXPath.endsWith("NameInfo")){
			throw new APException(String.format("A required NameInfo xpath configuration was not found: %s", configuredXPath));
		}
		APDataCollection dataSource = context.getAcordData();
		String fullName = getFullNameInfo(configuredXPath, COMML_NAME_XPATHS, dataSource, indices);
		if (StringUtilities.isEmptyOnTrim(fullName)){
			fullName = getFullNameInfo(configuredXPath, PERS_NAME_XPATHS, dataSource, indices);
		} 
		FieldValue fieldValue = new FieldValue();
		if (!StringUtilities.isEmptyOnTrim(fullName)){
			fieldValue.addValue(fullName);
		}
		return fieldValue;
	}

}
