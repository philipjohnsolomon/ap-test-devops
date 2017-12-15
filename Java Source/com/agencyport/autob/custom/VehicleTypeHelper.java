/*
 * Created on Apr 28, 2015 by cmartin AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.domXML.APDataCollection;
import com.agencyport.factory.GenericFactory;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.service.text.StringUtilities;
import com.agencyport.shared.APException;

/**
 * The VehicleTypeHelper class. Provides helper functions specific to the
 * VehTypeCd field.
 * <p>
 * Most notably, this class contains logic to determine a default Vehicle Type
 * based on a Body Type.
 * <p>
 * Client projects may extend this class by setting the
 * 'com.agencyport.commlAuto.VehicleTypeHelper' application property.
 * 
 * @since 5.1
 */
public class VehicleTypeHelper {

    /**
     * <code>OptionList</code> key String for the option list which maps
     * standard Vehicle Body Types to a known Vehicle Type. This map contains
     * body types which are ACORD compliant.
     */
    protected String acordBodyTypeMapOptionListKey = "xmlreader:autobLookupList.xml:ACORDVehicleBodyTypeToVehicleTypeList";

    /**
     * <code>OptionList</code> key String for the option list which maps
     * Non-Standard Vehicle Body Types to a known Vehicle Type. This map
     * contains body types which agent use that are not ACORD codes. The data
     * was mined from Turnstile, and we use it to improve the hit rate.
     */
    protected String nonAcordBodyTypeMapOptionListKey = "xmlreader:autobLookupList.xml:nonACORDVehicleBodyTypeToVehicleTypeList";

    /**
     * The OptionList key String for the Vehicle Type field
     */
    protected String vehicleTypeOptionListKey = "xmlreader:autobCodeListRef.xml:vehicleType";

    /**
     * The AP Path for the Vehicle Body Type Code
     */
    protected String vehicleBodyTypeCdPath = "CommlAutoLineBusiness.CommlRateState.CommlVeh.VehBodyTypeCd";

    /**
     * The Path for the Vehicle Type Code at the CommlVeh level. This is the
     * path Turnstile uses.
     */
    protected String vehicleTypeCdPathCommlVeh = "CommlAutoLineBusiness.CommlRateState.CommlVeh.VehTypeCd";

    /**
     * The AP Path for the Vehicle Type Code at the CommlVehSupplement level.
     * This is the path Portal uses.
     */
    protected String vehicleTypeCdPath = "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlVehSupplement.VehTypeCd";

    /**
     * The default class name to instantiate when no
     * 'com.agencyport.commlAuto.VehicleTypeHelper' application property exists
     */
    private static final String CLASS_NAME_DEFAULT = VehicleTypeHelper.class.getName();

    /**
     * The Application Property name providing the hook for project teams to
     * define their own extension of this VehicleTypeHelper class.
     */
    private static final String PROPERTY_NAME = "com.agencyport.autob.VehicleTypeHelper";

    /**
     * Factory method for obtaining VehicleTypeHelper instances.
     * <p>
     * Extensions to this class may be provided by setting the
     * 'com.agencyport.commlAuto.VehicleTypeHelper' application property
     * 
     * @return A new VehicleTypeHelper instance
     * @throws APException
     *             If the system is misconfigured to return an object which is
     *             not an instance of VehicleTypeHelper
     */
    public static final <T> T getVehicleTypeHelper() throws APException {

        T instance = GenericFactory.create(PROPERTY_NAME, CLASS_NAME_DEFAULT);

        if (!(instance instanceof VehicleTypeHelper)) {
            throw new APException("Failure instantiating VehicleTypeHelper.  The Object must be an instance of '" + CLASS_NAME_DEFAULT + "'" +
                    "  Verify the class defined by the '" + PROPERTY_NAME + "' application property inherits from the correct base class.");
        }

        return instance;
    }

    /**
     * Portal stores the VehTypeCd at the CommlVehSupplement level. Some uploads
     * store the VehTypeCd at the Veh level. This method will copy the VehTypeCd
     * to the CommlVehSupplement level if no CommlVehSupplement.VehTypeCd is
     * present during processing.
     * 
     * @param apData
     *            - The data collection to update
     * @param index
     *            - The CommlVeh aggregate index
     */
    public void copyVehicleTypeToCommlVehSupplement(APDataCollection apData, int[] index) {

        String supplementLevelVehicleType = apData.getFieldValue(vehicleTypeCdPath, index, "");
        if (StringUtilities.isEmpty(supplementLevelVehicleType)) {
            // If we do not receive a vehicle type at the CommlVehSupplement
            // level try and copy it down from the vehicle level
            String vehLevelVehicleType = apData.getFieldValue(vehicleTypeCdPathCommlVeh, index, "");
            apData.setFieldValue(vehicleTypeCdPath, index, vehLevelVehicleType);
        }
    }

    /**
     * Assigns a default Vehicle Type based on the existing Body Type when the
     * Vehicle Type is determined to be outside the set of valid values as
     * provided by the vehicle type list.
     * <p>
     * Retrieves the Body Type Code for the vehicle specified by the
     * <code>index</code> and maps that code to the default Vehicle Type by
     * first examining the list of valid ACORD mappings. If a valid ACORD
     * mapping is not identified this method will examine potential non-ACORD
     * mappings.
     * 
     * @param apData
     *            - The data collection to update
     * @param index
     *            - The CommlVeh aggregate index
     */
    public void assignVehicleTypeByBodyType(APDataCollection apData, int[] index) {

        String defaultVehicleType = "";
        String vehilceBodyTypeCd = apData.getFieldValue(vehicleBodyTypeCdPath, index, "");
        if (!StringUtilities.isEmpty(vehilceBodyTypeCd)) {

            boolean isValidVehicleType = isValidVehicleType(apData, index);
            if (!isValidVehicleType) {
                // If the vehicle type is invalid see if we can infer it based
                // on the set of ACORD body type codes
                defaultVehicleType = OptionsMap.lookupDisplayValue(vehilceBodyTypeCd, acordBodyTypeMapOptionListKey, "", null);
                if (StringUtilities.isEmpty(defaultVehicleType)) {
                    // If the vehicle type is still invalid, try and infer it
                    // based on the set of non-standard code mappings
                    defaultVehicleType = getDefaultVehicleTypeFromNonACORDBodyType(apData, index);
                }
            }
        }

        // Apply the default vehicle type if we have identified one
        if (!StringUtilities.isEmpty(defaultVehicleType)) {
            apData.setFieldValue(vehicleTypeCdPath, index, defaultVehicleType);
        }
    }

    /**
     * Determines if the CommlVeh.VehTypeCd value is valid by ensuring it exists
     * within the list of valid vehicle types.
     * 
     * @param apData
     *            - The data collection to update
     * @param index
     *            - The CommlVeh aggregate index
     * @return true if the vehicle type value is in vehicle type option list.
     */
    public boolean isValidVehicleType(APDataCollection apData, int[] index) {
        boolean isValidVehicleType = false;

        String vehicleTypeCd = apData.getFieldValue(vehicleTypeCdPath, index, "");
        if (!StringUtilities.isEmpty(vehicleTypeCd)) {
            isValidVehicleType = OptionsMap.lookupDisplayValue(vehicleTypeCd, vehicleTypeOptionListKey, "", null).length() > 0;
        }

        return isValidVehicleType;
    }

    /**
     * Retrieves the Body Type Code for the vehicle specified by the
     * <code>index</code> and maps that code to a default Vehicle Type using the
     * list of non-ACORD values. These non-ACORD values were taken from
     * examining Turnstile uploads for Body Type values agents actually upload,
     * outside the list of actual ACORD codes. This additional step improves the
     * hit rate of Vehicle Type upload and provides a better user experience.
     * 
     * @param apData
     *            - The data collection to update
     * @param index
     *            - The CommlVeh aggregate index
     * @return String
     */
    public String getDefaultVehicleTypeFromNonACORDBodyType(APDataCollection apData, int[] index) {

        String defaultVehicleType = "";
        String vehilceBodyTypeCd = apData.getFieldValue(vehicleBodyTypeCdPath, index, "");
        if (!StringUtilities.isEmpty(vehilceBodyTypeCd)) {
            defaultVehicleType = OptionsMap.lookupDisplayValue(vehilceBodyTypeCd, nonAcordBodyTypeMapOptionListKey, "", null);
        }

        return defaultVehicleType;
    }
}
