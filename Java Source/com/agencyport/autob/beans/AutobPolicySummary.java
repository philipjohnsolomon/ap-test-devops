package com.agencyport.autob.beans; //NOSONAR

import java.math.BigDecimal;
import java.util.Random;

import com.agencyport.data.DataManager;
import com.agencyport.policysummary.BasePolicySummary;
import com.agencyport.shared.APException;
import com.agencyport.utils.ArrayHelper;
import com.agencyport.workitem.model.IWorkItem;

/**
 * The CommlAutoPolicySummary class implements the data container for the
 * commercial auto policy summary page .
 */
public class AutobPolicySummary extends BasePolicySummary {

    /**
     * The <code>location</code> contains the main (first) location of the
     * commercial auto policy.
     */
    private final String location;
    /**
     * The <code>isCPPPolicy</code> will be true if this is part of a CPP
     * policy.
     */
    private boolean isCPPPolicy = false;

    /**
     * Constructs an instance.
     * 
     * @param workItem
     *            is the work item in context.
     * @param dataManager
     *            is the data manager.
     * @throws APException
     *             propagated from super class.
     */
    public AutobPolicySummary(IWorkItem workItem, DataManager dataManager) throws APException {
        super(workItem, dataManager);
        // Asssumption that the first location is the location of the insured
        String[] locationBlock = this.buildDataBlock("Location.Addr", null, STANDARD_ADDRESS_ELEMENTS);
        location = ArrayHelper.stringArrayAsString(locationBlock);

    }

    /**
     * {@inheritDoc}
     */
    @Override
    public BigDecimal getTotalPremium() {
        int random = 1000 + new Random().nextInt(2001);
        return new BigDecimal(random);
    }

    /**
     * Returns the location of this commercial auto policy.
     * 
     * @return the location of this commercial auto policy.
     */
    public String getLocation() {
        return location;
    }

    /**
     * Sets boolean flag denoting if LOB included as part of CPP
     * 
     * @param isCPPPolicy
     *            is the 'is CPP flag'
     */
    public void setCPPPolicy(boolean isCPPPolicy) {
        this.isCPPPolicy = isCPPPolicy;
    }

    /**
     * Returns boolean flag denoting if LOB included as part of CPP
     * 
     * @return true if LOB included as part of CPP
     */
    public boolean isCPPPolicy() {
        return isCPPPolicy;
    }
}