package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.customlists.ICustomListBuilder;
import com.agencyport.data.DataManager;
import com.agencyport.html.optionutils.OptionList;
import com.agencyport.html.optionutils.OptionList.Key;
import com.agencyport.logging.ExceptionLogger;
import com.agencyport.preconditions.PreConditions;
import com.agencyport.shared.APException;

/**
 * The StateSpcVehCoverageListBuilder class services up both commercial auto
 * state class codes and special vehicle class codes. Caching is implemented to
 * minimize database traffic.
 */
public class StateSpcVehCoverageListBuilder implements ICustomListBuilder {

    /**
     * The <code>VEHICLE_STATE_CODE_OPTION_LIST_CACHE_NAME</code> is the name of
     * the cache for state level class codes.
     */
    private static final String VEHICLE_STATE_CODE_OPTION_LIST_CACHE_NAME = StateSpcVehCoverageListBuilder.class.getName() + "[vehicle_state_codes]";
    /**
     * The <code>VEHICLE_CLASS_CODE_OPTION_LIST_CACHE_NAME</code> is the name of
     * the cache for special vehicle class codes.
     */
    private static final String VEHICLE_CLASS_CODE_OPTION_LIST_CACHE_NAME = StateSpcVehCoverageListBuilder.class.getName() + "[vehicle_class_code_list]";

    /**
     * {@inheritDoc}
     */
    @Override
    public OptionList generate(DataManager dataManager, Key key, OptionList existingListToUpdate) {

        PreConditions pc = dataManager.getPreConditions();

        String state = (String) pc.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH, "");

        // find the vehicle type and special vehicle type
        String specialVehicleType = "";
        String vehicleType = (String) pc.getFieldValue(ICommlAutoConstants.VEHICLE_TYPE_CD_HOTFIELD, "");

        return getClassCodes(key, existingListToUpdate, specialVehicleType, vehicleType, state);
    }

    /**
     * Gets a list of class codes. The type of class codes rendered depends on
     * whether a special vehicle is in context or not.
     * 
     * @param key
     *            is the option list key.
     * @param existingListToUpdate
     *            is the existing list to update.
     * @param specialVehicleType
     *            is the special vehicle type. Used only if vehicleType ==
     *            'SPEC'
     * @param vehicleType
     *            is the vehicle type.
     * @param state
     *            is the state.
     * @return a list of class codes.
     */
    public static OptionList getClassCodes(Key key, OptionList existingListToUpdate, String specialVehicleType,
            String vehicleType, String state) {

        String target = key.getTarget();

        // get the special vehicles
        OptionList specialVehicleList = SpecialVehiclesLookupHelper.getSpecialVehicleCodeList(target);

        try {
            OptionList optionList;
            // if it is a special vehicle that has its own codelist
            // otherwise let state specific code drop in
            if (("SPEC".equals(vehicleType)) && (specialVehicleList.findFirstPrecise(specialVehicleType) != null)) {
                optionList = getSpecialVehicleCodelistFromDB(specialVehicleType, target);
            }else {
                optionList = getStateCodelistFromDB(state, target);
            }

            if (existingListToUpdate == null) {
                return optionList;
            } else {
                existingListToUpdate.addAll(optionList);
            }

            return existingListToUpdate;

        } catch (APException apex) {
            throw new IllegalStateException(apex);
        }

    }

    /**
     * Retrieves class codes for the state.
     * 
     * @param state
     *            is the US state.
     * @param target
     *            is the option list target.
     * @return class codes for the state.
     * @throws APException
     *             propagated from
     *             {@link StateSpcVehListManager#getStateClassCodes(String, String)}
     */
    private static OptionList getStateCodelistFromDB(String state, String target) throws APException {

        StateSpcVehListManager listManager = new StateSpcVehListManager(VEHICLE_STATE_CODE_OPTION_LIST_CACHE_NAME);
        try {
            return listManager.getStateClassCodes(state, target);
        } catch (APException apexp) {
            ExceptionLogger.log(apexp, StateSpcVehCoverageListBuilder.class, "getStateCodelistFromDB");
            throw apexp;
        } finally {
            listManager.close();
        }
    }

    /**
     * Retrieves special vehicle class codes.
     * 
     * @param specialVehicle
     *            is the special vehicle type.
     * @param target
     *            is the option list target.
     * @return special vehicle class codes.
     * @throws APException
     *             propagated from
     *             {@link StateSpcVehListManager#getSpecialVehicleClassCodes(String, String)}
     */
    private static OptionList getSpecialVehicleCodelistFromDB(String specialVehicle, String target) throws APException {
        StateSpcVehListManager listManager = new StateSpcVehListManager(VEHICLE_CLASS_CODE_OPTION_LIST_CACHE_NAME);
        try {
            return listManager.getSpecialVehicleClassCodes(specialVehicle, target);
        } catch (APException apexp) {
            ExceptionLogger.log(apexp, StateSpcVehCoverageListBuilder.class, "getSpecialVehicleCodelistFromDB");
            throw apexp;
        } finally {
            listManager.close();
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getDefaultValue(DataManager dataManager, Key key,
            OptionList displayList) {
        return "";
    }

}
