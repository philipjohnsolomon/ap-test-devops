/*
 * Created on May 1, 2015 by cmartin AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.customlist;//NOSONAR

import com.agencyport.customlists.ICustomListBuilder;
import com.agencyport.data.DataManager;
import com.agencyport.data.IndexManager;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.html.optionutils.OptionEntry;
import com.agencyport.html.optionutils.OptionList;
import com.agencyport.html.optionutils.OptionList.Key;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.service.text.StringUtilities;

/**
 * Custom List Builder which returns a list comprised of any exiting list plus
 * the vehicle type options, and provides custom defaulting capability based on
 * the vehicle's body type.
 * 
 */
public class VehicleTypeListBuilder implements ICustomListBuilder {

    /**
     * <code>OptionList</code> key String for the option list which maps
     * standard Vehicle Body Types to a known Vehicle Type. This map contains
     * body types which are ACORD compliant.
     */
    protected String acordBodyTypeMapOptionListKey = "xmlreader:autobLookupList.xml:ACORDVehicleBodyTypeToVehicleTypeList";

    /**
     * <code>OptionList</code> key String for the option list which contains the
     * full suite of vehicle types.
     */
    protected String vehicleTypeOptionListKey = "xmlreader:autobCodeListRef.xml:vehicleType";

    /**
     * The vehicle body type ACORD path
     */
    protected String vehicleBodyTypePath = "CommlAutoLineBusiness.CommlRateState.CommlVeh.VehBodyTypeCd";

    /**
     * {@inheritDoc}
     */
    @Override
    public OptionList generate(DataManager dataManager, Key key, OptionList existingListToUpdate) {

        OptionList optionList = existingListToUpdate == null ? new OptionList() : existingListToUpdate;
        OptionList vehicleTypeList = OptionsMap.getSingleList(new Key(vehicleTypeOptionListKey));
        optionList.addAll(vehicleTypeList);

        return optionList;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getDefaultValue(DataManager dataManager, Key key, OptionList displayList) {

        String defaultValue = "";
        OptionEntry optionEntry = getVehicleTypeOptionEntry(dataManager);
        if (optionEntry != null) {
            defaultValue = optionEntry.getValue();
        }

        return defaultValue;
    }

    /**
     * Returns the appropriate vehicle type option entry based on the vehicle
     * body type. If the body type is empty, or a value cannot otherwise be
     * determines this method returns null.
     * 
     * @param dataManager
     * @return A single vehicleType option entry, or null
     */
    protected OptionEntry getVehicleTypeOptionEntry(DataManager dataManager) {

        OptionEntry optionEntry = null;
        APDataCollection pcData = dataManager.getPreConditions().getDataCollection();
        IndexManager indexManager = dataManager.getIndexManager();
        int[] index = indexManager.getCurrentIdArray(vehicleBodyTypePath);
        String bodyType = pcData.getFieldValue(vehicleBodyTypePath, index, "");

        if (!StringUtilities.isEmpty(bodyType)) {
            OptionList.Key bodyTypeListKey = new OptionList.Key(acordBodyTypeMapOptionListKey);
            OptionEntry entry = OptionsMap.getSingleList(bodyTypeListKey).findFirstPrecise(bodyType);
            if (entry != null) {
                String defaultVehicleType = entry.getDisplayText();

                optionEntry = OptionsMap.getSingleList(new Key(vehicleTypeOptionListKey)).findFirstPrecise(defaultVehicleType);
            }

        }

        return optionEntry;
    }
}
