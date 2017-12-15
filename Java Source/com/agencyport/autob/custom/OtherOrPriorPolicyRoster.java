package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.shared.commercial.CommlPolicyOtherOrPriorPolicyRoster;

/**
 * The OtherOrPriorPolicyRoster class to filters the OtherPolicy aggregate based
 * on the line of business
 */
public class OtherOrPriorPolicyRoster extends CommlPolicyOtherOrPriorPolicyRoster {
    /**
     * {@inheritDoc}
     */
    @Override
    protected String getPolicySpecificLOBCd() {
        return "AUTOB";
    }

}
