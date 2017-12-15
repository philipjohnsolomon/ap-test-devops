/*
 * Created on May 7, 2008 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.preconditions;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import com.agencyport.html.elements.BaseElement;
import com.agencyport.trandef.intrapage.BaseIPDTRAssistant;
import com.agencyport.trandef.intrapage.IntraPageDTRBehaviorManager;

/**
 * Handy widget which automatically sets an expiration date to be one year after a user-entered
 * effective date, via IPDTR. Since some transaction (e.g. UMBRC) can have more than one pair of
 * effective-expiration date fields, but unique IDs have to be unique across transactions, this
 * helper supports having a list of pairs of fields, each one of which is checked to see if the
 * IPDTR update should be applied.
 */
public class EffectiveDateIPDTRAssistant extends BaseIPDTRAssistant {
	
	/**
	 * A list of pairs of field unique IDs - the key should be the effective date, and the value the
	 * expiration date unique ID.
	 */
	@SuppressWarnings("serial")
	private static final Map<String, String> dateFields = new HashMap<String, String>(){{
		put ("EffectiveDate", "ExpirationDate");
		put ("UnderlyingEffectiveDate", "UnderlyingExpirationDate");
	}};
	
	/**
	 * If the triggering fields happen to be one of our effective-expiration date pairs, set the
	 * expiration date to be a year out from the effective date.
	 */ 
	@Override
	public boolean reassignValue(BaseElement baseElement, BaseElement origin,
			IntraPageDTRBehaviorManager intraPageDTRBehaviorManager) {
		
		boolean result = false;
		for(Iterator<Entry<String, String>> iterator = dateFields.entrySet().iterator(); iterator.hasNext();){
			Entry<String, String> dateFieldSet = iterator.next();
			String effectiveDateFieldId = dateFieldSet.getKey();
			String expirationDateFieldId = dateFieldSet.getValue();
			
			result = super.calculateExpirationDateOneYearFromEffectiveDate(effectiveDateFieldId, expirationDateFieldId, baseElement, origin, intraPageDTRBehaviorManager); 
			
			if (result == true){
				break;
			}
		}
			
		return result;
	}
}
