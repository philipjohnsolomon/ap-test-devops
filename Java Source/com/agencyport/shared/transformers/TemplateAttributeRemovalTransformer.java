/*
 * Created on Nov 30, 2010 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.transformers;

import org.jdom2.Element;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.domXML.transform.APDataCollectionTransformationException;
import com.agencyport.domXML.transform.IAPDataCollectionTransformer;
import com.agencyport.domXML.transform.TargetFormat;
import com.agencyport.domXML.visitor.StandardAttributeRemover;

/**
 * The TemplateAttributeRemovalTransformer class removes any attributes whose name begins with the character sequence
 * of 'saved' or 'action_code' or 'AP_ID'
 */
public class TemplateAttributeRemovalTransformer implements IAPDataCollectionTransformer {

	/**
	 * An attribute used in the templates to establish identity on fields which don't otherwise have a useable identifying predicate.
	 */
	private static final String AP_ID = "AP_ID";

	/**
	 * The <code>ATTRIBUTES_TO_REMOVE</code> is, surprisingly, a list of attributes to remove.
	 */
	private static final String[] ATTRIBUTES_TO_REMOVE = new String[]{
				IXMLConstants.SAVED_ATTRIBUTE_NAME, 
				IXMLConstants.ACTION_CODE_ATTRIBUTE_NAME,
				AP_ID
				};
	
	/**
	 * Visitor class which goes through APDataCollection and removes a specified list of Attributes
	 */
	private static final StandardAttributeRemover ATTRIBUTE_REMOVER = new StandardAttributeRemover(ATTRIBUTES_TO_REMOVE);
	
	/**
	 * The <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 2218072427001543694L;

	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void transform(APDataCollection dataCollection,
			TargetFormat targetFormat, Element customParameters)
			throws APDataCollectionTransformationException {
		dataCollection.accept(ATTRIBUTE_REMOVER);
	}

}
