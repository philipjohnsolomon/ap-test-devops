/*
 * Created on May 7, 2008 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.preconditions;

import com.agencyport.html.elements.BaseElement;
import com.agencyport.trandef.intrapage.BaseIPDTRAssistant;
import com.agencyport.trandef.intrapage.IntraPageDTRBehaviorManager;

/**
 * The GeneralInfoIPDTRAssistant class handles the IPDTR specifics for the generalInfo page. 
 */
public class PriorCarrierEffectiveDateIPDTRAssistant extends BaseIPDTRAssistant {
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public boolean reassignValue(BaseElement baseElement, BaseElement origin,
			IntraPageDTRBehaviorManager intraPageDTRBehaviorManager) {
		return super.calculateExpirationDateOneYearFromEffectiveDate("PriorCarrierEffectiveDate", "PriorCarrierExpirationDate", baseElement, origin, intraPageDTRBehaviorManager);
	}

}
