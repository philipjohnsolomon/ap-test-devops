/**
 * Created on June 27, 2007 by Sathish Sundaramurthy /  AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import java.util.HashSet;
import java.util.Set;

import com.agencyport.customlists.ICustomListBuilder;
import com.agencyport.data.DataManager;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.html.optionutils.OptionEntry;
import com.agencyport.html.optionutils.OptionList;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.logging.ExceptionLogger;
import com.agencyport.shared.APException;
import com.agencyport.utils.text.StringUtilities;

/**
 * The PremModStateListBuilder class lists all the comml rate states on the
 * policy with 1 or more vehicles.
 */
public class PremModStateListBuilder implements ICustomListBuilder {

    /**
     * Builds a custom list
     * 
     * @param dataManager
     *            is the data manager
     * @param customListId
     *            is the colon delimited custom list identifier
     * @param existingListToUpdate
     *            can be null in which case a new list will be returned. If one
     *            is passed in it is appended to.
     * @return an option list
     */
    @Override
    public OptionList generate(DataManager dataManager, OptionList.Key customListId, OptionList existingListToUpdate) {

        OptionList filteredStateList = new OptionList();
        try {
            APDataCollection apData = dataManager.getAPDataCollection();
            Set<String> statesList = getStatesWithVehicles(apData);
            OptionList stateList = OptionsMap.getSingleList(ICommlAutoConstants.STATE_LIST_KEY);
            for (OptionEntry stateEntry : stateList) {
                String stateValue = stateEntry.getValue();
                if (statesList.contains(stateValue)) {
                    filteredStateList.add(new OptionEntry(stateValue, stateEntry.getDisplayText()));
                }
            }
        } catch (APException apExc) {
            ExceptionLogger.log(apExc, getClass(), "generate");
        }
        if (existingListToUpdate == null) {
            return filteredStateList;
        } else {
            existingListToUpdate.addAll(filteredStateList);
            return existingListToUpdate;
        }
    }

    /**
     * Get only the states that have vehicles under them
     * 
     * @param apData
     *            is the work item xml data collection.
     * @return a set of US states with 1 or more vehicles.
     */
    private Set<String> getStatesWithVehicles(APDataCollection apData) {
        Set<String> statesList = new HashSet<String>();
        for (int[] index : apData.createIndexTraversalBasis(ICommlAutoConstants.COMML_RATE_STATE_XPATH)) {
            String garagingState = apData.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH, index, null);
            if (StringUtilities.isEmpty(garagingState)) {
                continue;
            }
            int vehCount = apData.getCount(ICommlAutoConstants.COMML_VEHICLE_XPATH, index);
            if (vehCount > 0) {
                statesList.add(garagingState);
            }

        }
        return statesList;
    }

    /**
     * Gets the default value for ths custom list
     * 
     * @param dataManager
     *            is the data manager
     * @param customListId
     *            is the colon delimited custom list identifier
     * @param displayList
     *            is the option list
     * @return the default value
     */
    @Override
    public String getDefaultValue(DataManager dataManager, OptionList.Key customListId, OptionList displayList) {
        return "";
    }
}
