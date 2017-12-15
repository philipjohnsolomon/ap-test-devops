/*
 * Created on Aug 13, 2014 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.custom;

import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.jdom2.Element;
import org.jdom2.output.XMLOutputter;

import com.agencyport.logging.LoggingManager;
import com.agencyport.service.text.StringUtilities;
import com.agencyport.shared.APException;
import com.agencyport.utils.ArrayHelper;
import com.agencyport.xml.XMLOutputterFactory;

/**
 * The CustomViewParser class can be used to parse out one or more custom arguments from a custom view. See
 * view schema for what the acceptable structure and attribute values are.
 * @since 5.0
 */
public final class CustomViewParser {
	/**
	 * The <code>LOGGER</code> is our logger.
	 */
	private static final Logger LOGGER = LoggingManager.getLogger(CustomViewParser.class.getPackage().getName());
	/**
	 * Prevent accidental construction
	 */
	private CustomViewParser() {
	}
	
	/**
	 * Logs the view element and raises an exception based on the issue.
	 * @param issue is the text message which describes the issue.
	 * @param viewElement is the view element to log.
	 * @throws APException based on the incoming issue. An exception is always raised when this
	 * method is invoked.
	 */
	public static void raiseException(String issue, Element viewElement) throws APException {
		StringWriter stringWriter = new StringWriter();
		XMLOutputter outputter = XMLOutputterFactory.create(" ", true);
		try {
			outputter.output(viewElement, stringWriter);
		} catch (IOException ioException){
			throw new APException(ioException);
		} finally {
			try {
				stringWriter.close();
			} catch (IOException ioException){
				
				LOGGER.log(Level.FINE,ioException.getMessage(),ioException);
				// not worth worrying about.
			}
		}
		LOGGER.severe(issue);
		LOGGER.severe(stringWriter.toString());
		throw new APException(issue);
	}
	
	/**
	 * Parses the custom argument elements of a view element into its discreet parts. 
	 * @param viewElement is the view element to parse.
	 * @param allowOptionalArguments governs whether of not optional arguments are allowed.
	 * @param requiredNames contains the list of names of attributes of custom arguments that are required. Any other names are disqualified 
	 * and will result in an exception to be raised. 
	 * @return a map where the key is the name of the custom argument and the value is the value for that name on that custom argument.
	 * @throws APException if a name is encountered that not one of the acceptable names or if the name or value on a custom argument is null/empty.
	 */
	public static Map<String, String> parseView(Element viewElement, boolean allowOptionalArguments, String... requiredNames) throws APException {
		Map<String, String> customArgumentMap = new HashMap<>();
		Set<String> acceptedNameMap = (Set<String>) ArrayHelper.copyToCollection(requiredNames, 0, new HashSet<String>());
		List<Element> customArguments = viewElement.getChildren("customArgument", viewElement.getNamespace());
		for (Element customArgument : customArguments){
			String name = customArgument.getAttributeValue("name", customArgument.getNamespace());
			String value = customArgument.getAttributeValue("value", customArgument.getNamespace());
			if (StringUtilities.isEmptyOnTrim(name) || StringUtilities.isEmptyOnTrim(value)){
				raiseException("A null/empty name or value attribute was encountered. Both are required", viewElement);
			}
			name = name.trim();
			value = value.trim();
			if (acceptedNameMap.contains(name) || allowOptionalArguments){
				customArgumentMap.put(name, value);
			} else if (!allowOptionalArguments){
				raiseException(String.format("Unknown custom argument with name = %s. This view only requires custom arguments with these names: %s.", name, acceptedNameMap), viewElement);
			}
		}
		
		// Now check that all required arguments are accounted for.
		for (String requiredName : requiredNames){
			if (!customArgumentMap.containsKey(requiredName)){
				raiseException(String.format("Missing custom argument with name = %s. This view requires custom arguments with these names: %s.", requiredName, acceptedNameMap), viewElement);
				
			}
		}

		return customArgumentMap;
	}

}
