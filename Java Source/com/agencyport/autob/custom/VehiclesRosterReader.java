/*
 * Created on May 17, 2006 by User AgencyPort Insurance
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.data.apdata.RosterReader;
import com.agencyport.domXML.IXMLConstants;

/**
 * The VehiclesRosterReader class only comes into effect under change management
 * trying to establish if the vehicle is really deleted or if it has been moved
 * to another rate state.
 */
public class VehiclesRosterReader extends RosterReader {

    /**
     * {@inheritDoc}
     */
    @Override
    protected boolean passesFilterCriterion(int[] idArray) {

        boolean passesBaseClassFilter = super.passesFilterCriterion(idArray);
        if (!passesBaseClassFilter) {
            return passesBaseClassFilter;
        }

        // This will check whether the vehicle is actually deleted or it is just
        // moved to another state.
        // If it is just moved then it will not allow that vehicle to be added
        // as delete.
        if (data.hasOriginalDocument()) {
            // Any aggregates on the current view should pass this filter
            if (data.getViewType() == IXMLConstants.VIEW_CURRENT_DOCUMENT) {
                return true;
            }
            int save = data.changeViewType(IXMLConstants.VIEW_ORIGINAL_DOCUMENT);
            try {
                // Retrieve the original vehicle id and state code for the
                // provided index
                String vehicleId = data.getFieldValue(ICommlAutoConstants.COMML_VEHICLE_XPATH + ".@id", idArray, "");
                String stateCd = data.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH, idArray, "");

                // Return to the Current Document view
                data.changeViewType(IXMLConstants.VIEW_CURRENT_DOCUMENT);

                // Process the vehicle
                return vehicleHasBeenDeletedFromACORD(vehicleId, stateCd);

            } finally {
                data.changeViewType(save);
            }
        }
        return true;
    }

    /**
     * Processes the provided vehicleId against all vehicles in all states.
     * Returns false if a vehicle by the supplied id is identified anywhere in
     * the ACORD, true otherwise. A vehicle existing somewhere in the ACORD by
     * the provided id indicates the vehicle was not deleted, but moved to
     * another State.
     * 
     * @param vehicleId
     *            - The vehicle id to look for
     * @param stateCd
     *            - The state code under which the vehicle was originally placed
     * @return true if the vehicle is found somewhere in the ACORD, true
     *         otherwise
     */
    private boolean vehicleHasBeenDeletedFromACORD(String vehicleId, String stateCd) {

        boolean isVehicleUnderSameState = data.getCount("CommlAutoLineBusiness.CommlRateState[StateProvCd='" + stateCd + "'].CommlVeh[@id='"
                + vehicleId + "']") > 0 ? true : false;

        if (isVehicleUnderSameState || vehicleId.length() == 0) {
            return false;
        }

        for (int[] index : data.createIndexTraversalBasis(ICommlAutoConstants.COMML_VEHICLE_XPATH)) {
            String currentVehicleId = data.getFieldValue(ICommlAutoConstants.COMML_VEHICLE_XPATH + ".@id", index, "");
            if (vehicleId.equalsIgnoreCase(currentVehicleId)) {
                return false;
            }
        }

        return true;
    }
}
