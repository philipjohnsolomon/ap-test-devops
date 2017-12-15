/*
 * Created on May 5, 2015 by cmartin AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.preconditions.PreConditions;
import com.agencyport.preconditions.PreConditionsStore;
import com.agencyport.xarc.evaluate.ICustomCondition;
import com.agencyport.xarc.evaluate.ResultNode;

/**
 * Determines if a risk is eligible based on the "eligible" PreCondition result.
 */
public class EligibilityXarcValidation implements ICustomCondition {

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean evaluate(ResultNode aggregateResult) {

        PreConditions preConditions = PreConditionsStore.getPreConditions();
        String eligible = (String) preConditions.getFieldValue("eligible", Boolean.FALSE.toString());

        return Boolean.FALSE.toString().equals(eligible);
    }
}
