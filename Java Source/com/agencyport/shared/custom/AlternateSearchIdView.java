/*
 * Created on Aug 13, 2014 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.custom;

import java.util.Map;

import org.jdom2.Element;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.view.View;
import com.agencyport.shared.APException;
import com.agencyport.webshared.HTMLDataContainer;
import com.agencyport.workitem.context.WorkItemContextStore;

/**
 * The AlternateSearchIdView class supports a search id for mutually exclusive field sets that is different from the data value itself.
 * @since 5.0
 */
public class AlternateSearchIdView extends View {
	
	/**
	 * The <code>serialVersionUID</code>is the serial version id.
	 */
	private static final long serialVersionUID = 1377654133640169919L;
	/**
	 * The <code>SEARCH_ID</code> is a constant for the value 'searchId'.
	 */
	private static final String SEARCH_ID = "searchId";
	/**
	 * The <code>searchId</code> is the search id value. This is used as a key into the HTML data container.
	 */
	private String searchId;
	
	/**
	 * Constructs an instance.
	 */
	public AlternateSearchIdView() {
	}
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void init(Element viewElement) throws APException {
		 // initialize super
		super.init(viewElement);
		Map<String, String> customArguments = CustomViewParser.parseView(viewElement, false, SEARCH_ID);
		searchId = customArguments.get(SEARCH_ID);
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void update(APDataCollection apData, int[] idArray, String value, String associatedElementPath) {
		HTMLDataContainer htmlDC = WorkItemContextStore.get().getHtmlDataContainer();
		String searchIdValue = htmlDC.getStringValue(searchId, null);
		update(apData, idArray, value, searchIdValue, associatedElementPath);
	}


}
