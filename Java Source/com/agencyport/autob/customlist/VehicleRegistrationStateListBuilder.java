/*
 * Created on May 18, 2015 by cmartin AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.customlist;//NOSONAR

import com.agencyport.customlists.ICustomListBuilder;
import com.agencyport.data.DataManager;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.html.optionutils.OptionList;
import com.agencyport.html.optionutils.OptionList.Key;

/**
 * The VehicleRegistrationStateListBuilder class exists to default the
 * Registration State from the Garaging State.
 */
public class VehicleRegistrationStateListBuilder implements ICustomListBuilder {

    /**
     * {@inheritDoc}
     */
    @Override
    public OptionList generate(DataManager dataManager, Key key, OptionList existingListToUpdate) {
        return existingListToUpdate;
    }

    /**
     * {@inheritDoc}
     * <p>
     * Extends the base implementation to retrieve the Garaging State as the
     * default value
     */
    @Override
    public String getDefaultValue(DataManager dataManager, Key key, OptionList displayList) {

        APDataCollection pcData = dataManager.getPreConditions().getDataCollection();
        
       return pcData.getFieldValue("CommlAutoLineBusiness.CommlRateState.StateProvCd", "");

    }
}
