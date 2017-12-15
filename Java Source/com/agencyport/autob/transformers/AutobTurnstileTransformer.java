/*
 * Created on Apr 7, 2015 by pnichols AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.transformers;//NOSONAR

import static com.agencyport.utils.text.StringUtilities.isEmpty;

import java.util.ArrayList;
import java.util.List;

import org.jdom2.Attribute;
import org.jdom2.Element;

import com.agencyport.autob.custom.ICommlAutoConstants;
import com.agencyport.autob.custom.VehicleTypeHelper;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.Aggregate;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.domXML.transform.APDataCollectionTransformationException;
import com.agencyport.domXML.transform.IAPDataCollectionTransformer;
import com.agencyport.domXML.transform.TargetFormat;
import com.agencyport.domXML.visitor.EmptyAggregateRemover;
import com.agencyport.fieldvalidation.validators.BaseValidator;
import com.agencyport.service.text.StringUtilities;
import com.agencyport.shared.APException;

/**
 * The CommlAutoTurnstileTransformer class is used to adjust the XML produced by
 * Turnstile (for a Commerical Auto application) into Acord XML which can be
 * processed in the Templates. The changes/transformations this transformer
 * needs to make are:
 * <ul>
 * <li>- Moving the Garaging Locations from underneath CommlVeh into the
 * Location aggregate.</lI>
 * <li>- Translating the Body Type Code into a Vehicle Type when the Vehicle
 * Type is empty or otherwise invalid</lI>
 * </ul>
 * (This is a work in process, so more transformations are expected)
 */
public class AutobTurnstileTransformer implements IAPDataCollectionTransformer {

	/**
	 * The <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 495510103391208617L;

	/**
	 * Turnstile Acord XPath for the CommlVeh Registered State
	 */
	private static final String TS_VEHICLE_REGISTERED_STATE_XPATH = "CommlAutoLineBusiness.CommlRateState.CommlVeh.RegistrationStateProvCd";

	/**
	 * The XPath for a AXP_COMMLOPTIONALCOV_XPATH.
	 */
	private static final String AXP_COMMLRATESTATE_XPATH = "CommlAutoLineBusiness.CommlRateState";
	
	/**
	 * /** The XPath for a CommlVeh.
	 */
	private static final String AXP_COMMLVEH_XPATH = "CommlAutoLineBusiness.CommlRateState.CommlVeh";

	/**
	 * The <code>locationAddresses</code> objects sent from Turnstile.
	 */
	private transient List<Address> locationAddresses;
	/**
	 * The <code>VEHLOCREF</code>
	 */
	private static final String VEHLOCREF = "CommlAutoLineBusiness.CommlRateState.CommlVeh.@LocationRef";

	/**
	 * Convert the Turnstile XML format to the simplified Acord supported by the
	 * Portal Templates. This is a one way conversion - there is no reason to
	 * ever recreate the TS XML.
	 */
	@Override
	public void transform(APDataCollection apData, TargetFormat targetFormat, Element customParameters)
			throws APDataCollectionTransformationException {

		if (targetFormat.equals(TargetFormat.ACORDSimplified)) {
			transformToACORDSimplified(apData);
		}
	}

	/**
	 * Perform the various transmutations necessary to convert Turnstile Acord
	 * into Portal simplified acord
	 * 
	 * @param apData
	 * @throws APDataCollectionTransformationException
	 *             If any exception occurs during execution
	 */
	private void transformToACORDSimplified(APDataCollection apData) throws APDataCollectionTransformationException {

		locationAddresses = collectLocationAddresses(apData);

		transformSymbols(apData);

		// Perform all transformations involving CommlVeh element iteration
		transformVehicles(apData);

		moveVehicleToRateState(apData);
		
		updateBISPLPropDam(apData);
		
		setVehicleUMISPCoverages(apData);
		
		setVehicleMEDPMCoverages(apData);
	}
	/**
	 * @param apData
	 */
	private void setVehicleMEDPMCoverages(APDataCollection apData) {
		for (int[] indices : apData.createIndexTraversalBasis(AXP_COMMLRATESTATE_XPATH)) {
			String stateCd = apData.getFieldValue("CommlAutoLineBusiness.CommlRateState.StateProvCd", indices, "");
				if (apData.exists("CommlAutoLineBusiness.CommlRateState.CommlCoverage[CoverageCd='MEDPM'].Limit.FormatInteger", indices)) {
					for (int[] vehIndices : apData.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {	
						String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
						String vehStateCd = apData.getFieldValue("Location[@id='" + locRef + "'].Addr.StateProvCd", null);
							if (stateCd.equals(vehStateCd)) {
								apData.setFieldValue("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='MEDPM'].Limit.FormatInteger", vehIndices, apData.getFieldValue("CommlAutoLineBusiness.CommlRateState.CommlCoverage[CoverageCd='MEDPM'].Limit.FormatInteger", indices, ""));
							}

						}
				}
			}
		}
	
				
	/**
	 * @param apData
	 */
	private void setVehicleUMISPCoverages(APDataCollection apData) {
		for (int[] indices : apData.createIndexTraversalBasis(AXP_COMMLRATESTATE_XPATH)) {
			String stateCd = apData.getFieldValue("CommlAutoLineBusiness.CommlRateState.StateProvCd", indices, "");
			if (stateCd.matches("AK|CT|ME|MN|ND|NJ|RI|TN|TX")) {
				if (apData.exists("CommlAutoLineBusiness.CommlRateState.CommlCoverage[CoverageCd='UMUIM'].Limit[LimitAppliesToCd='PerPerson'].FormatInteger", indices)) {
					apData.setFieldValue("CommlAutoLineBusiness.CommlRateState.CommlCoverage[CoverageCd='UMUIM'].CoverageCd", indices, "UMISP");
					for (int[] vehIndices : apData.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {	
						String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
						String vehStateCd = apData.getFieldValue("Location[@id='" + locRef + "'].Addr.StateProvCd", null);
							if (stateCd.equals(vehStateCd)) {
								apData.deleteElement("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMUIM']", vehIndices);
								apData.deleteElement("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMCSL']", vehIndices);
								apData.setFieldValue("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMUIM'].Limit.FormatInteger", vehIndices, apData.getFieldValue("CommlAutoLineBusiness.CommlRateState.CommlCoverage[CoverageCd='UMUIM'].Limit.FormatInteger", indices, ""));
							}

						}
				}else if (apData.exists("CommlAutoLineBusiness.CommlRateState.CommlCoverage[CoverageCd='UMUIM'].Limit[LimitAppliesToCd='CSL'].FormatInteger", indices)) {
					apData.setFieldValue("CommlAutoLineBusiness.CommlRateState.CommlCoverage[CoverageCd='UMUIM'].CoverageCd", indices, "UMCSL");
					apData.deleteElement("CommlAutoLineBusiness.CommlRateState.CommlCoverage[CoverageCd='UMCSL'].Limit[LimitAppliesToCd='CSL'].LimitAppliesToCd", indices);	
					for (int[] vehIndices : apData.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {	
						String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
						String vehStateCd = apData.getFieldValue("Location[@id='" + locRef + "'].Addr.StateProvCd", null);
							if (stateCd.equals(vehStateCd)) {
								apData.deleteElement("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMUIM']", vehIndices);
								apData.deleteElement("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMCSL']", vehIndices);
								apData.setFieldValue("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMCSL'].Limit.FormatInteger", vehIndices, apData.getFieldValue("CommlAutoLineBusiness.CommlRateState.CommlCoverage[CoverageCd='UMCSL'].Limit.FormatInteger", indices, ""));
							}

						}
				}
			}

		}

	}
	
	/**
	 * @param apData
	 */
	private void updateBISPLPropDam(APDataCollection apData) {
		for (int[] indices : apData.createIndexTraversalBasis(AXP_COMMLRATESTATE_XPATH)) {		
			if (!BaseValidator.checkIsEmpty(apData.getFieldValue(AXP_COMMLRATESTATE_XPATH + ".CommlCoverage[CoverageCd='BISPL'].Limit[LimitAppliesToCd='PropDam'].LimitAppliesToCd", indices, null))) {
				String propDamValue = apData.getFieldValue(AXP_COMMLRATESTATE_XPATH
						+ ".CommlCoverage[CoverageCd='BISPL'].Limit[LimitAppliesToCd='PropDam'].FormatInteger", indices, null);
				if (!BaseValidator.checkIsEmpty(propDamValue)) {
					if (BaseValidator.checkIsEmpty(apData.getFieldValue(AXP_COMMLRATESTATE_XPATH + ".CommlCoverage[CoverageCd='PD'].Limit.FormatInteger",
							indices,
							null))) {
						apData.setFieldValue(AXP_COMMLRATESTATE_XPATH + ".CommlCoverage[CoverageCd='PD'].Limit.FormatInteger", indices, propDamValue);
					}
					apData.deleteElement(AXP_COMMLRATESTATE_XPATH + ".CommlCoverage[CoverageCd='BISPL'].Limit[LimitAppliesToCd='PropDam']", indices);
				} else {
					apData.deleteElement(AXP_COMMLRATESTATE_XPATH + ".CommlCoverage[CoverageCd='BISPL'].Limit[LimitAppliesToCd='PropDam']", indices);
				}

			}

		}

	}

	/**
	 * Perform transformations that involve iterating through CommlVeh elements.
	 * The current list of these are:
	 * <ul>
	 * <li>- Moving garaging address from under "CommlVeh" to "Location",
	 * associated to veh
	 * </ul>
	 * 
	 * @param apData
	 * @throws APDataCollectionTransformationException
	 *             If any exception occurs during execution
	 */
	private void transformVehicles(APDataCollection apData) throws APDataCollectionTransformationException {

		// Loop through the CommlRateState elements (one per state)
		for (int[] vehicleIndexes = { 0, 0 }; vehicleIndexes[0] < apData.getCount(ICommlAutoConstants.COMML_RATE_STATE_XPATH); vehicleIndexes[0]++) {

			// Loop through the vehicles under that CommlRateState
			for (vehicleIndexes[1] = 0; vehicleIndexes[1] < apData.getCount(ICommlAutoConstants.COMML_VEHICLE_XPATH, vehicleIndexes[0]); vehicleIndexes[1]++) {

				// This step changes the way garaging locations are stored from
				// the Turnstile method to the Portal method.
				// In turnstile, garaging locations are stored underneath the
				// vehicles:
				// CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlVehSupplement.Addr
				// In Portal, all locations are stored in "Location" elements,
				// and the vehicle is linked to the Location
				// with an idref:
				// CommlAutoLineBusiness.CommlRateState.CommlVeh.@LocationRef
				//
				moveGaragingAddress(apData, vehicleIndexes);

				moveRegistrationState(apData, vehicleIndexes);

				setVehicleType(apData, vehicleIndexes);


			}
		}
	}

	/**
	 * @param apData
	 *            Moves every Vehicle to appropriate rateState depending on
	 *            LocRef, if LocRef didn't exist moves them under controlling
	 *            state.
	 */
	private void moveVehicleToRateState(APDataCollection apData) {
		String controllingStateCd = apData.getFieldValue("CommlPolicy.ControllingStateProvCd", null);
		for (int[] indices : apData.createIndexTraversalBasis(ICommlAutoConstants.COMML_VEHICLE_XPATH)) {
			String locRef = apData.getFieldValue(ICommlAutoConstants.COMML_VEHICLE_XPATH + ".@LocationRef", indices, null);	
			String rateState = apData.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH, indices, null);
			if (!BaseValidator.checkIsEmpty(locRef)) {
				String stateCd = apData.getFieldValue(ICommlAutoConstants.LOCATION_XPATH + "[@id='" + locRef + "']" + ".Addr.StateProvCd", null);
				if (!BaseValidator.checkIsEmpty(stateCd)) {
					if (!apData.exists(ICommlAutoConstants.COMML_RATE_STATE_XPATH + "[StateProvCd='" + stateCd + "']")) {
						apData.setFieldValue(ICommlAutoConstants.COMML_RATE_STATE_XPATH + "[StateProvCd='" + stateCd + "'].StateProvCd", stateCd);
					}
					if(!rateState.equals(stateCd)){
						Aggregate vehAggregate = new Aggregate();
						vehAggregate.acquireFrom(apData, ICommlAutoConstants.COMML_VEHICLE_XPATH, indices);
						vehAggregate.moveTo(apData, ICommlAutoConstants.COMML_RATE_STATE_XPATH + "[StateProvCd='" + stateCd + "']", null);
					}					
				} else {
					apData.deleteAttribute(ICommlAutoConstants.COMML_VEHICLE_XPATH, indices, ".@LocationRef");

					if (!apData.exists(ICommlAutoConstants.LOCATION_XPATH + "[Addr.StateProvCd='" + controllingStateCd + "']")) {
						apData.setFieldValue(ICommlAutoConstants.LOCATION_XPATH + "[Addr.StateProvCd='" + controllingStateCd + "'].Addr.StateProvCd", indices,
								controllingStateCd);

						String controlStatelocRef = apData.getAttributeText(ICommlAutoConstants.LOCATION_XPATH + "[Addr.StateProvCd='" + controllingStateCd
								+ "']", "id");
						apData.setFieldValue(ICommlAutoConstants.COMML_VEHICLE_XPATH + ".@LocationRef", indices, controlStatelocRef);
					}
					moveVehicleToControllingState(apData, indices);

				}
			} else {
				if (!BaseValidator.checkIsEmpty(rateState)) {
					String rateStateLocId = apData.getAttributeText(ICommlAutoConstants.LOCATION_XPATH + "[Addr.StateProvCd='" + rateState
							+ "']", "id");
					apData.setFieldValue(ICommlAutoConstants.COMML_VEHICLE_XPATH + ".@LocationRef", indices, rateStateLocId);
				}else{
				moveVehicleToControllingState(apData, indices);
				}
			}

		}
		cleanUp(apData);
	}

	/**
	 * @param apData
	 */
	private void cleanUp(APDataCollection apData) {

		for(int[] indices : apData.createIndexTraversalBasis(ICommlAutoConstants.COMML_RATE_STATE_XPATH)){
			if(BaseValidator.checkIsEmpty(apData.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH, indices, null))){
				apData.deleteElement(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH, indices);
			}
		}
		new EmptyAggregateRemover().removeEmptyAggregates(apData);		
	}

	/**
	 * @param apData
	 * @param indices
	 */
	private void moveVehicleToControllingState(APDataCollection apData, int[] indices) {
		String controllingStateCd = apData.getFieldValue("CommlPolicy.ControllingStateProvCd", null);
		if (!BaseValidator.checkIsEmpty(controllingStateCd)) {
			if (!apData.exists(ICommlAutoConstants.COMML_RATE_STATE_XPATH + "[StateProvCd='" + controllingStateCd + "']")) {
				apData.setFieldValue(ICommlAutoConstants.COMML_RATE_STATE_XPATH + "[StateProvCd='" + controllingStateCd + "'].StateProvCd", indices,
						controllingStateCd);
			}
			Aggregate vehAggregate = new Aggregate();
			vehAggregate.acquireFrom(apData, ICommlAutoConstants.COMML_VEHICLE_XPATH, indices);
			vehAggregate.moveTo(apData, ICommlAutoConstants.COMML_RATE_STATE_XPATH + "[StateProvCd='" + controllingStateCd + "']", null);

		}
	}

	/**
	 * Collect the addresses under the "Location" aggregates into a list of
	 * "Address" objects for easy reference.
	 * 
	 * @param apData
	 *            The apdata collection to look in
	 * @return A list of Address objects containing the address info from each
	 *         location.
	 */
	private List<Address> collectLocationAddresses(APDataCollection apData) {
		int numLocations = apData.getCount(ICommlAutoConstants.LOCATION_XPATH);
		List<Address> addresses = new ArrayList<Address>(numLocations);

		// Loop through the Location aggregates in the ap data
		for (int locationIndex = 0; locationIndex < numLocations; locationIndex++) {

			// Create an Address object for each one (containing just the
			// address information.
			Address address = new Address(apData, ICommlAutoConstants.LOCATION_XPATH, new int[] { locationIndex });
			String id = apData.getFieldValue(ICommlAutoConstants.LOCATION_ID_XPATH, locationIndex, "");

			// add an id to any location missing one. We need id's on the
			// location so we can link
			// the vehicles back to them.
			if (isEmpty(id)) {
				id = apData.generateUID();
				apData.setFieldValue(ICommlAutoConstants.LOCATION_ID_XPATH, locationIndex, id);
			}
			address.setID(id);
			addresses.add(address);
		}
		return addresses;
	}

	/**
	 * Move the "Address" elements underneath the CommlVehicles to Location
	 * aggregates, with reference id's linking them to the vehicles.
	 * 
	 * @param apData
	 * @param vehicleIndexes
	 */
	private void moveGaragingAddress(APDataCollection apData, int[] vehicleIndexes) {

		Address vehicleAddress = new Address(apData, ICommlAutoConstants.COMML_VEH_SUPPLEMENT_XPATH, vehicleIndexes);

		Address matchingAddress = vehicleAddress.findMatchingAddress(locationAddresses);

		// If no match with an existing location, create a new location object
		if (Address.NO_MATCH.equals(matchingAddress)) {

			createNewLocation(apData, vehicleIndexes, vehicleAddress);

			// If a match was found, Link the Vehicle to the pre-existining
			// location
		} else {
			// Link the CommlVehicle to the address (i.e. create a @LocationRef
			// attribute
			// on the vehicle) and remove the address from underneath the
			// CommlVehicle
			linkToExistingLocation(apData, vehicleIndexes, matchingAddress);
		}
	}

	/**
	 * If a vehicle has a garaging address that doesn't match any of the
	 * Location addresses, create a new Location element (using the vehicle
	 * garaging address) and link the vehicle to it.
	 * 
	 * @param apData
	 *            - the APDataCollection
	 * @param vehicleIndexes
	 *            - The indices where the vehicle is located under the
	 *            CommlRateState
	 * @param vehicleAddress
	 *            - The garaging address of the vehicle
	 */
	private void createNewLocation(APDataCollection apData, int[] vehicleIndexes, Address vehicleAddress) {

		int numLocations = locationAddresses.size();

		// Create an XML id for the new location.
		String refID = apData.generateUID();
		apData.setFieldValue(ICommlAutoConstants.LOCATION_ID_XPATH, IXMLConstants.FORCE_NEW_OCCURENCE, refID);
		apData.setFieldValue(ICommlAutoConstants.VEHICLE_LOCATION_REF_XPATH, vehicleIndexes, refID);
		vehicleAddress.setID(refID);

		// Remove the "Address" aggregate that is automatically created for the
		// new location.
		Aggregate addressAggregate = new Aggregate();
		if (addressAggregate.acquireFrom(apData, ICommlAutoConstants.LOCATION_ADDR_XPATH, new int[] { numLocations })) {
			addressAggregate.getElement().detach();
		}

		// Replace it with the location aggregate from under the comml vehicle
		if (addressAggregate.acquireFrom(apData, ICommlAutoConstants.COMML_VEH_SUPPLEMENT_ADDR_XPATH, vehicleIndexes)) {
			addressAggregate.moveTo(apData, ICommlAutoConstants.LOCATION_XPATH, new int[] { numLocations });
		}
		apData.setFieldValue(ICommlAutoConstants.LOCATION_ADDR_TYPE_CD_XPATH, numLocations, "StreetAddress");

		// Add this address to the list of addresses we collected for matching.
		locationAddresses.add(vehicleAddress);
	}

	/**
	 * Link the vehicle (via @LocationRef attribute) to an existing Location
	 * element whose address matches the vehicle's garaging address. When the
	 * garaging address for a vehicle already exists in the Locations, we remove
	 * the Addr element from under the vehicle, and add a LocationRef attribute
	 * linking to the existing location
	 * 
	 * @param apData
	 *            - the APDataCollection
	 * @param vehicleIndexes
	 *            - The indices where the vehicle is located under the
	 *            CommlRateState
	 * @param locationAddress
	 *            - The Location element we're linking the vehicle to.
	 */
	private void linkToExistingLocation(APDataCollection apData, int[] vehicleIndexes, Address locationAddress) {

		String refID = locationAddress.getID();
		apData.setFieldValue(ICommlAutoConstants.VEHICLE_LOCATION_REF_XPATH, vehicleIndexes, refID);
		// Remove the address from under the CommlVehicle
		Aggregate addressAggregate = new Aggregate();
		if (addressAggregate.acquireFrom(apData, ICommlAutoConstants.COMML_VEH_SUPPLEMENT_ADDR_XPATH, vehicleIndexes)) {
			addressAggregate.getElement().detach();
		}
	}

	/**
	 * Move the "Registered State" for each vehicle from the Turnstile Path to
	 * the Portal path
	 * 
	 * @param apData
	 *            - the data collection with the values
	 * @param vehicleIndexes
	 *            - the indexes for that vehicle.
	 */
	private void moveRegistrationState(APDataCollection apData, int[] vehicleIndexes) {

		String registeredState = apData.getFieldValue(TS_VEHICLE_REGISTERED_STATE_XPATH, vehicleIndexes, "");
		apData.setFieldValue(ICommlAutoConstants.REGISTRATION_STATE_XPATH, vehicleIndexes, registeredState);

		copyAttributes(apData, TS_VEHICLE_REGISTERED_STATE_XPATH, ICommlAutoConstants.REGISTRATION_STATE_XPATH, vehicleIndexes);

		apData.deleteElement(TS_VEHICLE_REGISTERED_STATE_XPATH, vehicleIndexes);
	}

	/**
	 * During Turnstile uploads we frequently receive ACORDs without a vehicle
	 * type value. Because vehicle type is a key to most other fields on the
	 * vehicles page that missing data causes a cascade of field exclusions
	 * which ultimately results in profound data loss. In order to mitigate this
	 * impact, this method will attempt to back-fill a vehicle type based on the
	 * vehicle's body type (which most uploads contain). This only occurs when
	 * the provided vehicle type is deemed invalid with respect to the vehicle
	 * type field's select list options.
	 * <p>
	 * Defaulting of vehicle type is done based on two data sets:
	 * <ul>
	 * <li>The mapping of valid ACORD body types to the most common vehicle type
	 * for that body type</li>
	 * <li>The mapping of invalid ACORD body types to the most common vehicle
	 * type for that body type. The list of invalid body types was obtained by
	 * data mining Turnstile uploads for what agents are actually inputing in
	 * the body type field.</li>
	 * </ul>
	 * <p>
	 * To customize this behavior see
	 * {@link com.agencyport.autob.custom.VehicleTypeHelper}
	 * 
	 * @param apData
	 *            - The data collection to update
	 * @param vehicleIndexes
	 *            - The CommlVeh aggregate index
	 * @throws APDataCollectionTransformationException
	 *             If any exception occurs during execution
	 */
	private void setVehicleType(APDataCollection apData, int[] vehicleIndexes) throws APDataCollectionTransformationException {

		try {
			VehicleTypeHelper vehicleTypeHelper = VehicleTypeHelper.getVehicleTypeHelper();

			vehicleTypeHelper.copyVehicleTypeToCommlVehSupplement(apData, vehicleIndexes);
			vehicleTypeHelper.assignVehicleTypeByBodyType(apData, vehicleIndexes);
		} catch (APException apEx) {
			throw new APDataCollectionTransformationException(apEx);
		}
	}

	/**
	 * Performs data manipulation on policy symbol fields to make them Portal
	 * compliant. This method will back-fill the Uninsured or Underinsured
	 * Motorist Symbol if one is missing. Both symbols must be the same. It will
	 * also move data from the combined UM/UIM symbol field into the individual
	 * UM & UIM symbols fields as needed.
	 * 
	 * @param apData
	 *            - The data collection to update
	 */
	protected void transformSymbols(APDataCollection apData) {

		String uninsuredSymbol = apData.getFieldValue(ICommlAutoConstants.UNINSURED_MOTORIST_SYMBOL_PATH, "");
		String underinsuredSymbol = apData.getFieldValue(ICommlAutoConstants.UNDERINSURED_MOTORIST_SYMBOL_PATH, "");

		// The uninsured and underinsured symbols must be the same. If we get
		// one, but not the other prefil the empty symbol.
		if (StringUtilities.isEmpty(uninsuredSymbol) && !StringUtilities.isEmpty(underinsuredSymbol)) {
			apData.setFieldValue(ICommlAutoConstants.UNINSURED_MOTORIST_SYMBOL_PATH, underinsuredSymbol);
		}
		if (StringUtilities.isEmpty(underinsuredSymbol) && !StringUtilities.isEmpty(uninsuredSymbol)) {
			apData.setFieldValue(ICommlAutoConstants.UNDERINSURED_MOTORIST_SYMBOL_PATH, uninsuredSymbol);
		}

		// NJ & NY utilize a combined symbol element from ACORD & Turnstile
		String combinedUMSymbol = apData.getFieldValue(ICommlAutoConstants.COMBINED_UM_UIM_SYMBOL_PATH, "");
		if (!StringUtilities.isEmpty(combinedUMSymbol) && StringUtilities.isEmpty(uninsuredSymbol) && StringUtilities.isEmpty(underinsuredSymbol)) {
			apData.setFieldValue(ICommlAutoConstants.UNINSURED_MOTORIST_SYMBOL_PATH, combinedUMSymbol);
			apData.setFieldValue(ICommlAutoConstants.UNDERINSURED_MOTORIST_SYMBOL_PATH, combinedUMSymbol);
		}
	}

	/**
	 * Copy all the attributes on one element in an APDataCollection to another.
	 * 
	 * @param apData
	 *            The APDataCollection with the data.
	 * @param sourcePath
	 *            The element path we're copying from
	 * @param targetPath
	 *            The element path we're copying to
	 * @param indexes
	 *            the indexes to use on the path - we assume the same can be
	 *            used for source and target.
	 */
	private void copyAttributes(APDataCollection apData, String sourcePath, String targetPath, int[] indexes) {
		Aggregate registeredStateElement = new Aggregate();

		if (registeredStateElement.acquireFrom(apData, sourcePath, indexes)) {
			Element element = registeredStateElement.getElement();

			List<Attribute> attributes = element.getAttributes();
			for (Attribute attribute : attributes) {
				String attributeName = attribute.getName();
				String attributeValue = attribute.getValue();
				String attributePath = concat(targetPath, ".@", attributeName);
				apData.setFieldValue(attributePath, indexes, attributeValue);
			}
		}
	}

	/**
	 * Shorthand method for concatenating a set of strings together into a
	 * single string
	 * 
	 * @param strings
	 *            - a variable list of strings
	 * @return the concatenated string; or at least the empty string - this
	 *         method never returns null.
	 */
	public static String concat(String... strings) {
		StringBuilder sb = new StringBuilder();
		if (strings != null) {
			for (String str : strings) {
				if (!isEmpty(str)) {
					sb.append(str);
				}
			}
		}
		return sb.toString();
	}

}