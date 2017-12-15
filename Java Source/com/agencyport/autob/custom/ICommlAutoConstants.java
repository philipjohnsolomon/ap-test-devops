/**
 * Created on July 1, 2007 by Sathish /  AgencyPort Insurance Services, Inc.
 */

package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.html.optionutils.OptionList;

/**
 * The ICommlAutoConstants interface is a store house for some commonly used
 * constants and XPaths.
 */
public interface ICommlAutoConstants {
    /**
     * The <code>LOCATIONS_PAGE</code> a constant for the comml auto location
     * page.
     */
    String LOCATIONS_PAGE = "AUTOBGarageLocation";
    /**
     * The <code>VEHICLES_PAGE</code> a constant for the comml auto vehicles
     * page.
     */
    String VEHICLES_PAGE = "vehicle";
    /**
     * The <code>POLICY_COV_PAGE</code> a constant for the comml auto policy
     * coverages page id.
     */
    String POLICY_COV_PAGE = "policyCoverages";

    /**
     * The <code>PREM_MOD_PAGE</code> a constant for the comml auto premium
     * modification page id.
     */
    String PREM_MOD_PAGE = "AUTOBpremiumModification";
    /**
     * The <code>LOCATION_XPATH</code> an XPath constant for the Location
     * aggregate.
     */
    String LOCATION_XPATH = "Location";
    /**
     * The <code>LOCATION_ID_XPATH</code> an XPath constant for the Location
     * aggregate's 'id' attribute.
     */
    String LOCATION_ID_XPATH = "Location.@id";
    /**
     * The <code>LOCATION_ADDR_XPATH</code> an XPath constant for the address
     * segment under location.
     */
    String LOCATION_ADDR_XPATH = "Location.Addr";
    /**
     * The <code>LOCATION_ADDR_TYPE_CD_XPATH</code> an XPath constant for the
     * address' AddrTypeCd element under a Location.Addr aggregate
     */
    String LOCATION_ADDR_TYPE_CD_XPATH = "Location.Addr.AddrTypeCd";
    /**
     * The <code>COMML_RATE_STATE_XPATH</code> an XPath constant for the comml
     * rate state segment.
     */
    String COMML_RATE_STATE_XPATH = "CommlAutoLineBusiness.CommlRateState";
    /**
     * The <code>COMML_RATE_STATE_PROV_CD_XPATH</code> an XPath constant for the
     * state code under comml rate state segment.
     */
    String COMML_RATE_STATE_PROV_CD_XPATH = "CommlAutoLineBusiness.CommlRateState.StateProvCd";
    /**
     * The <code>COMML_VEHICLE_XPATH</code> an XPath constant for the vehicle
     * under the comml rate state segment.
     */
    String COMML_VEHICLE_XPATH = "CommlAutoLineBusiness.CommlRateState.CommlVeh";

    /**
     * The <code>COMML_VEHICLE_COVERAGE_XPATH</code> an XPath constant for the
     * vehicle coverage under the vehicle segment.
     */
    String COMML_VEHICLE_COVERAGE_XPATH = COMML_VEHICLE_XPATH + ".CommlCoverage";
    /**
     * The <code>COMML_VEHICLE_ADDITIONAL_INTEREST_XPATH</code> an XPath
     * constant for the vehicle additional interest segment under the vehicle
     * segment.
     */
    String COMML_VEHICLE_ADDITIONAL_INTEREST_XPATH = COMML_VEHICLE_XPATH + ".AdditionalInterest";

    /**
     * The <code>COMML_RATE_STATE_OPTIONAL_COVERAGES_XPATH</code> an XPath
     * constant for the optional coverages segment under the comml rate state.
     * This in an ACORD simplified definition.
     */
    String COMML_RATE_STATE_OPTIONAL_COVERAGES_XPATH = "CommlAutoLineBusiness.CommlRateState.CommlAutoOptionalCoverages";
    /**
     * The <code>COMML_RATE_STATE_PREMIUM_MODIFICATION_XPATH</code> an XPath
     * constant for the premium modification segment under the comml rate state.
     * This in an ACORD simplified definition.
     */
    String COMML_RATE_STATE_PREMIUM_MODIFICATION_XPATH = "CommlAutoLineBusiness.CommlRateState.CommlAutoPremiumModification";

    /**
     * The <code>VEHICLE_TYPE_CD_XPATH</code> an XPath constant for vehicle type
     * code.
     */
    String VEHICLE_TYPE_CD_XPATH = COMML_VEHICLE_XPATH + ".CommlVehSupplement.VehTypeCd";
    /**
     * The <code>REGISTRATION_STATE_XPATH</code> an XPath constant for vehicle
     * registration state code.
     */
    String REGISTRATION_STATE_XPATH = COMML_VEHICLE_XPATH + ".Registration.StateProvCd";
    /**
     * The <code>GARAGED_STATE_ID_XPATH</code> an XPath constant for the
     * location ref on the vehicle.
     */
    String GARAGED_STATE_ID_XPATH = COMML_VEHICLE_XPATH + ".@LocationRef";
    /**
     * The <code>COMML_VEH_SUPPLEMENT_XPATH</code> is an XPath constant for the
     * CommlVehSupplement aggregate on the vehicle.
     */
    String COMML_VEH_SUPPLEMENT_XPATH = "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlVehSupplement";
    /**
     * The <code>COMML_VEH_SUPPLEMENT_ADDR_XPATH</code> is an XPath constant for
     * the CommlVehSupplement.Addr aggregate on the vehicle.
     */
    String COMML_VEH_SUPPLEMENT_ADDR_XPATH = "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlVehSupplement.Addr";
    /**
     * The <code>RADIUS_USE_XPATH</code> an XPath constant for the vehicle's
     * radius type code.
     */
    String RADIUS_USE_XPATH = COMML_VEHICLE_XPATH + ".CommlVehSupplement.RadiusTypeCd";
    /**
     * Acord XPath for the CommlVeh LocationRef attribute (this is where Portal
     * indicates the garaging location.
     */
    String VEHICLE_LOCATION_REF_XPATH = "CommlAutoLineBusiness.CommlRateState.CommlVeh.@LocationRef";
    /**
     * The AXE Path constant for the
     * CombinedUninsuredUnderinsuredMotoristSymbolCd field. Used in NJ, NY.
     */
    String COMBINED_UM_UIM_SYMBOL_PATH = "CommlAutoLineBusiness.CoveredAutoSymbol.CombinedUninsuredUnderinsuredMotoristSymbolCd";
    /**
     * The AXE Path constant for the UninsuredMotoristSymbolCd field.
     */
    String UNINSURED_MOTORIST_SYMBOL_PATH = "CommlAutoLineBusiness.CoveredAutoSymbol.UninsuredMotoristSymbolCd";
    /**
     * The AXE Path constant for the UnderinsuredMotoristSymbolCd field.
     */
    String UNDERINSURED_MOTORIST_SYMBOL_PATH = "CommlAutoLineBusiness.CoveredAutoSymbol.UnderinsuredMotoristSymbolCd";
    /**
     * The <code>STATE_LIST_KEY</code> is the key to the static US state option
     * list.
     */
    OptionList.Key STATE_LIST_KEY = new OptionList.Key("xmlreader", "codeListRef.xml", "state");
    /**
     * The <code>SPL_VEHICLE_TYPE_HOTFIELD_XPATH</code> is the vehicle body type
     * code XPath
     */
    String SPL_VEHICLE_TYPE_HOTFIELD_XPATH = COMML_VEHICLE_XPATH + ".VehBodyTypeCd";
    /**
     * The <code>VEHICLE_TYPE_CD_HOTFIELD</code> is the unique id for the
     * vehicle type code.
     */
    String VEHICLE_TYPE_CD_HOTFIELD = "HotVehicleType";

}
