/*
 * Created on Jul 2, 2015 by pnichols AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.utils;

import static com.agencyport.utils.text.StringUtilities.isEmpty;

/**
 * The StringUtil class encapsulates some convenience methods for string manipulation.
 */
public class StringUtil {
	
	/**
	 * Private constructor, to keep Sonar happy
	 */
	private StringUtil(){
		
	}
	
    /**
     * Shorthand method for concatenating a set of strings together into a
     * single string
     * 
     * @param strings
     *            - a variable list of strings
     * @return the concatenated string; or at least the empty string - this
     *         method never returns null.
     */
    public static String concat(String... strings) {
        StringBuilder sb = new StringBuilder();
        if (strings != null) {
            for (String str : strings) {
                if (!isEmpty(str)) {
                    sb.append(str);
                }
            }
        }
        return sb.toString();
    }

}
