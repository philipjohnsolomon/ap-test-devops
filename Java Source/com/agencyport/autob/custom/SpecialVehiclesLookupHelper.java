/*
 * Created on May 15, 2007 by Sathish, AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.html.optionutils.OptionEntry;
import com.agencyport.html.optionutils.OptionList;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.shared.apps.common.utils.APConstants;
import com.agencyport.utils.text.StringUtilities;

/**
 * The SpecialVehiclesLookupHelper class serves up the special vehicle type
 * list.
 */
public final class SpecialVehiclesLookupHelper {
    /**
     * The <code>COMMLAUTOCODELIST_PREFIX_KEY</code> is the option list key for
     * the special vehicle types.
     */
    private static final OptionList.Key COMMLAUTOCODELIST_PREFIX_KEY = new OptionList.Key("xmlreader:autobLookupList.xml:specialVehicleTypes");

    /**
     * Prevent accidental construction.
     */
    private SpecialVehiclesLookupHelper() {

    }

    /**
     * Gets the option list of special vehicle codes.
     * 
     * @param optionListTargetName
     *            is the option list target name.
     * @return the option list of special vehicle codes related to the option
     *         list target name.
     */
    public static OptionList getSpecialVehicleCodeList(String optionListTargetName) {

        OptionList specialVehiclesList = new OptionList();

        if (StringUtilities.isEmpty(optionListTargetName)) {
            return specialVehiclesList;
        }

        String specialVehicles = OptionsMap.lookupDisplayValue(optionListTargetName, COMMLAUTOCODELIST_PREFIX_KEY, null, null);

        if (!StringUtilities.isEmpty(specialVehicles)) {
            String[] specialVehCodes = specialVehicles.split(APConstants.COMMA_CHAR);
            for (String specialVehCode : specialVehCodes) {
                OptionEntry optionEntry = new OptionEntry(specialVehCode, specialVehCode);
                specialVehiclesList.add(optionEntry);
            }
        }

        return specialVehiclesList;
    }

}
