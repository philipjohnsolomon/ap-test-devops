/*
 * Created on Jul 2, 2015 by pnichols AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.utils;

import static com.agencyport.shared.utils.StringUtil.concat;

import java.util.List;

import org.jdom2.Attribute;
import org.jdom2.Element;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.Aggregate;

/**
 * The XMLUtil class contains to handy methods for XML/Acord manipulation
 */
public class XMLUtil {

	/**
	 * Private constructor to keep sonar happy.
	 */
	private XMLUtil(){
		
	}
	
	
	/**
     * Copy all the attributes on one element in an APDataCollection to another.
     * 
     * @param apData
     *            The APDataCollection with the data.
     * @param sourcePath
     *            The element path we're copying from
     * @param targetPath
     *            The element path we're copying to
     * @param indexes
     *            the indexes to use on the path - we assume the same can be
     *            used for source and target.
     */
    public static void copyAttributes(APDataCollection apData, String sourcePath, String targetPath, int[] indexes) {
        Aggregate sourceAggregateElement = new Aggregate();

        if (sourceAggregateElement.acquireFrom(apData, sourcePath, indexes)) {
            Element element = sourceAggregateElement.getElement();

            List<Attribute> attributes = element.getAttributes();
            for (Attribute attribute : attributes) {
                String attributeName = attribute.getName();
                String attributeValue = attribute.getValue();
                String attributePath = concat(targetPath, ".@", attributeName);
                apData.setFieldValue(attributePath, indexes, attributeValue);
            }
        }
    }
}
