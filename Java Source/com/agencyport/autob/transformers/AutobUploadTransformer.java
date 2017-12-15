/*
 * Created on Dec 16, 2015 by ktamma AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.transformers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.jdom2.Element;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.domXML.transform.APDataCollectionTransformationException;
import com.agencyport.domXML.transform.IAPDataCollectionTransformer;
import com.agencyport.domXML.transform.TargetFormat;
import com.agencyport.fieldvalidation.validators.BaseValidator;
import com.agencyport.logging.LoggingManager;
import com.google.common.collect.ImmutableMap;

/**
 * The AutobUploadTransformer class
 */
public class AutobUploadTransformer implements IAPDataCollectionTransformer {

	/**
	 * The <code>LOGGER</code>is my Logger.
	 */
	private static final Logger LOGGER = LoggingManager
			.getLogger(AutobUploadTransformer.class.getPackage().getName());
	/**
	 * The <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 8789521180012803359L;
	/**
	 * /** The XPath for a CommlVeh.
	 */
	private static final String AXP_COMMLVEH_XPATH = "CommlAutoLineBusiness.CommlRateState.CommlVeh";
	/**
	 * The XPath for a CommlVeh.
	 */
	private static final String AXP_DRIVER_XPATH = "CommlAutoLineBusiness.CommlDriver";
	/**
	 * The XPath for a Coverage Code at the policy level, with a replaceable
	 * CoverageCd variable.
	 */
	private static final String AXP_POLICY_COVERAGE_CODE = ".CommlCoverage[CoverageCd='$X'].CoverageCd";

	/**
	 * The XPath for a Coverage at the policy level, with a replaceable
	 * CoverageCd variable.
	 */
	private static final String AXP_POLICY_COVERAGE = ".CommlCoverage[CoverageCd='$X']";

	/**
	 * The <code>UMCSL_UM</code>is a string constant.
	 */
	private static final String UMCSL_UM = "UMCSL_UM";

	/**
	 * The <code>CSL_BI</code>is a string constant.
	 */
	private static final String CSL_BI = "CSL_BI";

	/**
	 * The <code>ADDRSTATEPROVCD</code>
	 */
	private static final String ADDRSTATEPROVCD = "'].Addr.StateProvCd";

	/**
	 * The <code>VEHLOCREF</code>
	 */
	private static final String VEHLOCREF = "CommlAutoLineBusiness.CommlRateState.CommlVeh.@LocationRef";

	/**
	 * The <code>LOCID</code>
	 */
	private static final String LOCID = "Location[@id='";

	/**
	 * The <code>WLBCOVERAGEXPATH</code>
	 */
	private static final String WLBCOVERAGEXPATH = "CommlAutoLineBusiness.CommlRateState.CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='WLB'].Limit.FormatInteger";

	/**
	 * The <code>RATESTATESTATECDXPATH</code>
	 */
	private static final String RATESTATESTATECDXPATH = "CommlAutoLineBusiness.CommlRateState[StateProvCd='";

	/**
	 * The <code>COMMLCOVCDXPATH</code>
	 */
	private static final String COMMLCOVCDXPATH = "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='";

	/**
	 * The <code>COMMLCOVXPATH</code>
	 */
	private static final String COMMLCOVXPATH = "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage";

	/**
	 * The <code>LOSS</code>
	 */
	private static final String LOSS = "CommlPolicy.Loss";

	/**
	 * This is a list of coverages that needs to have an attribute added - the
	 * "AP_ID" attribute, to support the xpath used on the templates ui, for
	 * example "Coverage[@AP_ID='UMCSL_UM']"
	 * 
	 * The key is the coverage code, and the value what we set the AP_ID
	 * attribute to.
	 */

	private static final Map<String, String> AP_ID_MAP = Collections
			.unmodifiableMap(new ImmutableMap.Builder<String, String>()
					.put("UM", UMCSL_UM).put("UMCSL", UMCSL_UM)
					.put("UMISP", UMCSL_UM).put("UMUIM", UMCSL_UM)
					.put("CSL", CSL_BI).put("BI", CSL_BI).build());

	@Override
	public void transform(APDataCollection apData, TargetFormat targetFormat,
			Element customParameters)
			throws APDataCollectionTransformationException {

		if (targetFormat.equals(TargetFormat.ACORDSimplified)) {
			transformToACORDSimplified(apData);
		}

	}

	/**
	 * @param apData
	 * @throws APDataCollectionTransformationException
	 */
	private void transformToACORDSimplified(APDataCollection apData)
			throws APDataCollectionTransformationException {

		addAPIDAttributes(apData, AP_ID_MAP);
		updateDriverYearLicensed(apData);
		upDateNYVehicleCoverages(apData);
		updateStackingOption(apData);
		updateLAEconomicLossOption(apData);
		updateNamedInsuredOption(apData);
		updateHIMCAREOption(apData);
		updateLCOLLandBCOLL(apData);
		updateSDOptionTypeCd(apData);
		updatePIPUT(apData);
		updateWaiverPIP(apData);
		updateCAWaiverDeductible(apData);
		updateAPIPOption(apData);
		updateCTPIPAPIP(apData);
		formatMiddleName(apData);
		updateLossAmountReserved(apData);
	}

	private void updateLossAmountReserved(APDataCollection apData) {
		for (int[] indices : apData.createIndexTraversalBasis(LOSS)) {
			if (apData.exists("CommlPolicy.Loss.ReservedAmt.Amt", indices)) {
				apData.setFieldValue(
						"CommlPolicy.Loss.ProbableIncurredAmt.Amt",
						indices,
						apData.getFieldValue(
								"CommlPolicy.Loss.ReservedAmt.Amt", indices, ""));
			}
		}

	}

	private void formatMiddleName(APDataCollection apData) {
		for (int[] indices : apData.createIndexTraversalBasis(AXP_DRIVER_XPATH)) {
			if (apData
					.getFieldValue(
							"CommlAutoLineBusiness.CommlDriver.GeneralPartyInfo.NameInfo.PersonName.OtherGivenName",
							indices, "").length() > 1) {
				apData.setFieldValue(
						"CommlAutoLineBusiness.CommlDriver.GeneralPartyInfo.NameInfo.PersonName.OtherGivenName",
						indices,
						apData.getFieldValue(
								"CommlAutoLineBusiness.CommlDriver.GeneralPartyInfo.NameInfo.PersonName.OtherGivenName",
								indices, "").substring(0, 1));
			}
		}

	}

	/**
	 * @param apData
	 */
	private void updateCTPIPAPIP(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if ("CT".equals(stateCd)) {
				if (!"PerWeek"
						.equals(apData
								.getFieldValue(
										"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='PIP'].Limit.LimitAppliesToCd",
										""))
						&& !BaseValidator
								.checkIsEmpty(apData
										.getFieldValue(
												"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='PIP'].Limit.FormatInteger",
												""))) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Limit[LimitAppliesToCd='Aggregate'].FormatInteger",
							indices,
							apData.getFieldValue(
									"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='PIP'].Limit.FormatInteger",
									""));
				}
				if (!BaseValidator
						.checkIsEmpty(apData
								.getFieldValue(
										"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='PIP'].Limit[LimitAppliesToCd='PerWeek'].FormatInteger",
										""))) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Limit[LimitAppliesToCd='WorkLossWk'].FormatInteger",
							indices,
							apData.getFieldValue(
									"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='PIP'].Limit[LimitAppliesToCd='PerWeek'].FormatInteger",
									""));

					if (!"PerWeek"
							.equals(apData
									.getFieldValue(
											"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='APIP'].Limit.LimitAppliesToCd",
											""))
							&& !BaseValidator
									.checkIsEmpty(apData
											.getFieldValue(
													"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='APIP'].Limit.FormatInteger",
													""))) {
						apData.setFieldValue(
								"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='APIP'].Limit[LimitAppliesToCd='Increased'].FormatInteger",
								indices,
								apData.getFieldValue(
										"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='APIP'].Limit.FormatInteger",
										""));
					}
					if (!BaseValidator
							.checkIsEmpty(apData
									.getFieldValue(
											"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='APIP'].Limit[LimitAppliesToCd='PerWeek'].FormatInteger",
											""))) {
						apData.setFieldValue(
								"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='APIP'].Limit[LimitAppliesToCd='IncrWorkWk'].FormatInteger",
								indices,
								apData.getFieldValue(
										"CommlAutoLineBusiness.CommlRateState[StateProvCd='CT'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='APIP'].Limit[LimitAppliesToCd='PerWeek'].FormatInteger",
										""));
					}
				}

			}
		}
	}

	/**
	 * @param apData
	 */
	private void updateAPIPOption(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if (stateCd.matches("KS|KY")) {
				if (!BaseValidator
						.checkIsEmpty(apData
								.getFieldValue(
										"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='APIP'].Option[OptionValue='Opt1' &amp;&amp; OptionCd='APIP'].OptionValue",
										indices, ""))) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='APIP'].Option[OptionCd='APIP'].OptionValue",
							indices, "1");
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='APIP'].Option[OptionCd='APIP'].OptionTypeCd",
							indices, "Opt1");
				} else if (!BaseValidator
						.checkIsEmpty(apData
								.getFieldValue(
										"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='APIP'].Option[OptionValue='Opt2' &amp;&amp; OptionCd='APIP'].OptionValue",
										indices, ""))) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='APIP'].Option[OptionCd='APIP'].OptionValue",
							indices, "2");
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='APIP'].Option[OptionCd='APIP'].OptionTypeCd",
							indices, "Opt2");
				}
			}
		}

	}

	/**
	 * @param apData
	 */
	private void updateCAWaiverDeductible(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if ("CA".equals(stateCd)) {
				if ("WV".equals(apData
						.getFieldValue(
								"CommlAutoLineBusiness.CommlRateState[StateProvCd='CA'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='COLL'].Deductible[DeductibleTypeCd='WV'].DeductibleTypeCd",
								""))) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='CWAIV'].CoverageCd",
							indices, "CWAIV");
				}
			}
			if (!BaseValidator
					.checkIsEmpty(apData
							.getFieldValue(
									"CommlAutoLineBusiness.CommlRateState[StateProvCd='"
											+ stateCd
											+ "'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='COLL'].Deductible.FormatInteger",
									""))) {
				apData.setFieldValue(
						"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='COLL'].Deductible.FormatInteger",
						indices,
						apData.getFieldValue(
								"CommlAutoLineBusiness.CommlRateState[StateProvCd='"
										+ stateCd
										+ "'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='COLL'].Deductible.FormatInteger",
								""));
			}
		}

	}

	/**
	 * @param apData
	 */
	private void updateWaiverPIP(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if (stateCd.matches("AR|DC|MD|MI|OR|SD|TX|UT|WA")) {
				if ("RJ".equals(apData
						.getFieldValue(
								"CommlAutoLineBusiness.CommlRateState[StateProvCd='"
										+ stateCd
										+ "'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='RJ'].OptionCd",
								""))) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='RJ'].OptionTypeCd",
							indices, "Opt1");
				}
			}

		}
	}

	/**
	 * @param apData
	 */
	private void updatePIPUT(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if ("UT".equals(stateCd)) {
				int covCount = apData.getCount(COMMLCOVXPATH, indices);
				for (int i = 0; i < covCount; i++) {
					updatePIPUTContd(apData, indices, i);

				}
			}
		}

	}

	/**
	 * @param apData
	 * @param indices
	 * @param i
	 */
	private void updatePIPUTContd(APDataCollection apData, int[] indices, int i) {
		if ("REPSV".equals(apData.getFieldValue(COMMLCOVXPATH + "["
				+ IXMLConstants.ID_BASE + i + "].CoverageCd", indices, ""))) {
			if ("PIP".equals(apData.getFieldValue(COMMLCOVXPATH + "["
					+ IXMLConstants.ID_BASE + i
					+ "].CommlCoverageSupplement.CoverageSubCd", indices, ""))) {
				apData.setFieldValue(
						"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='REPSV'].Limit[LimitAppliesToCd='SurvLossBen'].FormatInteger",
						indices,
						apData.getFieldValue(
								"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='REPSV']["
										+ IXMLConstants.ID_BASE
										+ i
										+ "].Limit.FormatInteger", indices, ""));
			} else if ("APIP".equals(apData.getFieldValue(COMMLCOVXPATH + "["
					+ IXMLConstants.ID_BASE + i
					+ "].CommlCoverageSupplement.CoverageSubCd", indices, ""))) {
				apData.setFieldValue(
						"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='REPSV'].Limit[LimitAppliesToCd='Aggregate'].FormatInteger",
						indices,
						apData.getFieldValue(
								"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='REPSV']["
										+ IXMLConstants.ID_BASE
										+ i
										+ "].Limit.FormatInteger", indices, ""));
			}

		}
	}

	/**
	 * @param apData
	 */
	private void updateSDOptionTypeCd(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if ("SD".equals(stateCd)) {

				if (apData
						.exists("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='D'].OptionCd",
								indices)) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='D'].OptionTypeCd",
							indices, "Opt1");
				}
				if (apData
						.exists("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='GE'].OptionCd",
								indices)) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='GE'].OptionTypeCd",
							indices, "Opt2");
				} else if (apData
						.exists("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='GN'].OptionCd",
								indices)) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='GN'].OptionTypeCd",
							indices, "Opt2");
				}
			}

		}

	}

	/**
	 * @param apData
	 */
	private void updateNamedInsuredOption(APDataCollection apData) {

		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if (stateCd.matches("DE|FL|MA|NY|OR")) {

				if (apData
						.exists("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='I'].OptionCd",
								indices)) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='I'].OptionTypeCd",
							indices, "Opt1");
				} else if (apData
						.exists("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='R'].OptionCd",
								indices)) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='R'].OptionTypeCd",
							indices, "Opt1");
				}
			}

		}

	}

	/**
	 * @param apData
	 */
	private void updateLCOLLandBCOLL(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if (("MI".equals(stateCd) || "MA".equals(stateCd))
					&& apData
							.exists(RATESTATESTATECDXPATH
									+ stateCd
									+ "'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='LCOLL']")) {

				apData.setFieldValue(
						"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='LCOLL'].CoverageCd",
						indices, "LCOLL");

			}

			if ("MI".equals(stateCd)
					&& apData
							.exists(RATESTATESTATECDXPATH
									+ stateCd
									+ "'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='BCOLL']")) {

				apData.setFieldValue(
						"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='BCOLL'].CoverageCd",
						indices, "BCOLL");
				apData.setFieldValue(
						"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='BCOLL'].Limit.FormatInteger",
						indices,
						apData.getFieldValue(
								RATESTATESTATECDXPATH
										+ stateCd
										+ "'].CommlAutoOptionalCoverages.CommlCoverage[CoverageCd='BCOLL'].Limit.FormatInteger",
								""));

			}
		}
	}

	/**
	 * @param apData
	 */
	private void updateLAEconomicLossOption(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if ("LA".equals(stateCd)) {
				String coverageCd = apData
						.getFieldValue(
								"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[@AP_ID='UMCSL_UM'].CoverageCd",
								indices, "");
				if ("UMCSL".equals(coverageCd) || "UMISP".equals(coverageCd)) {
					if (apData.getCount(COMMLCOVCDXPATH + coverageCd
							+ "'].Option[OptionCd='EN']", indices) > 0) {
						apData.setFieldValue(COMMLCOVCDXPATH + coverageCd
								+ "'].Option[OptionCd='EN'].OptionTypeCd",
								indices, "Opt1");
					} else if (apData.getCount(COMMLCOVCDXPATH + coverageCd
							+ "'].Option[OptionCd='EL']", indices) > 0) {
						apData.setFieldValue(COMMLCOVCDXPATH + coverageCd
								+ "'].Option[OptionCd='EL'].OptionTypeCd",
								indices, "Opt1");
					}
				}
			}
		}

	}

	/**
	 * @param apData
	 */
	private void updateHIMCAREOption(APDataCollection apData) {

		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData
					.getFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.@LocationRef",
							indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ "'].Addr.StateProvCd", null);
			if ("HI".equals(stateCd)) {
				if (!BaseValidator
						.checkIsEmpty(apData
								.getFieldValue(
										"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='CP'].OptionCd",
										indices, null))) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='CP'].OptionTypeCd",
							indices, "Opt1");
				}
				if (!BaseValidator
						.checkIsEmpty(apData
								.getFieldValue(
										"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option[OptionCd='MC'].OptionCd",
										indices, null))) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage.CoverageCd",
							indices, "MCARE");
				}
			}

		}
	}

	/**
	 * @param apData
	 */
	private void updateStackingOption(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH
						+ ".CommlCoverage.Option.OptionCd")) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);

			if (stateCd.matches("HI|IA|KY|MT|NM|PA")) {
				if (apData
						.getFieldValue(
								"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage.Option.OptionCd",
								indices, null).matches("ST|NS")) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage.Option.OptionTypeCd",
							indices, "Opt1");
				}
				/*
				 * if (apData.getFieldValue(
				 * "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMISP'].Option.OptionCd"
				 * , indices, null).matches("ST|NS")) { apData.setFieldValue(
				 * "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMISP'].Option.OptionTypeCd"
				 * , indices, "Opt1"); } if (apData.getFieldValue(
				 * "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UNCSL'].Option.OptionCd"
				 * , indices, null).matches("ST|NS")) { apData.setFieldValue(
				 * "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UNCSL'].Option.OptionTypeCd"
				 * , indices, "Opt1"); } if (apData.getFieldValue(
				 * "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UNDSP'].Option.OptionCd"
				 * , indices, null).matches("ST|NS")) { apData.setFieldValue(
				 * "CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UNDSP'].Option.OptionTypeCd"
				 * , indices, "Opt1"); }
				 */
			}

		}

	}

	/**
	 * @param apData
	 */
	private void upDateNYVehicleCoverages(APDataCollection apData) {
		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {
			String locRef = apData.getFieldValue(VEHLOCREF, indices, null);
			String stateCd = apData.getFieldValue(LOCID + locRef
					+ ADDRSTATEPROVCD, null);
			if ("NY".equals(stateCd)) {
				for (int[] optionIndices : apData
						.createIndexTraversalBasis(AXP_COMMLVEH_XPATH
								+ ".CommlCoverage[CoverageCd='PIP'].Option")) {
					upDateNYVehicleCoveragesContd(apData, optionIndices);
				}
				if (!BaseValidator.checkIsEmpty(apData.getFieldValue(
						WLBCOVERAGEXPATH, indices, null))) {
					apData.setFieldValue(
							"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='APIP'].Limit[LimitAppliesToCd='WorkLoss'].FormatInteger",
							indices, apData.getFieldValue(WLBCOVERAGEXPATH,
									indices, null));
					apData.deleteElement(WLBCOVERAGEXPATH, indices);
				}

			}
			if (("NY".equals(stateCd) || "HI".equals(stateCd))
					&& !BaseValidator
							.checkIsEmpty(apData
									.getFieldValue(
											"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='ADB'].Limit.FormatInteger",
											indices, null))) {
				apData.setFieldValue(
						"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='ADB'].Limit.LimitAppliesToCd",
						indices, "AccDeath");
			}
		}

	}

	/**
	 * @param apData
	 * @param optionIndices
	 */
	private void upDateNYVehicleCoveragesContd(APDataCollection apData,
			int[] optionIndices) {
		String optionCd = apData
				.getFieldValue(
						"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option.OptionCd",
						optionIndices, null);
		if ("I".equals(optionCd) || "R".equals(optionCd)) {
			apData.setFieldValue(
					"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option.OptionTypeCd",
					optionIndices, "Opt1");
		} else if ("NO".equals(optionCd) || "W".equals(optionCd)) {
			apData.setFieldValue(
					"CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='PIP'].Option.OptionTypeCd",
					optionIndices, "Opt2");
		}
	}

	/**
	 * @param apData
	 */
	private void updateDriverYearLicensed(APDataCollection apData) {
		for (int[] indices : apData.createIndexTraversalBasis(AXP_DRIVER_XPATH)) {
			String yearLicensed = apData.getFieldValue(AXP_DRIVER_XPATH
					+ ".DriverInfo.License.LicensedDt", indices, null);
			if (!BaseValidator.checkIsEmpty(yearLicensed)) {
				SimpleDateFormat sdfmt1;
				SimpleDateFormat sdfmt2 = new SimpleDateFormat("MM-dd-yyyy");
				if (yearLicensed.length() > 4) {
					if (yearLicensed.contains("-")) {
						sdfmt1 = new SimpleDateFormat("MM-dd-yyyy");
						sdfmt1.setLenient(false);
					} else if (yearLicensed.contains("/")) {
						sdfmt1 = new SimpleDateFormat("MM/dd/yyyy");
						sdfmt1.setLenient(false);
					} else {
						sdfmt1 = new SimpleDateFormat("MMddyyyy");
						sdfmt1.setLenient(false);
					}
				} else {
					sdfmt1 = new SimpleDateFormat("yyyy");
					sdfmt1.setLenient(false);
				}
				try {
					Date date = sdfmt1.parse(yearLicensed);
					apData.setFieldValue(AXP_DRIVER_XPATH
							+ ".DriverInfo.License.LicensedDt", indices,
							sdfmt2.format(date));
				} catch (ParseException e) {
					LOGGER.log(Level.FINE, e.getMessage(), e);
				}

			}
		}

	}

	/**
	 * @param apData
	 * @param idMap
	 */
	private void addAPIDAttributes(APDataCollection apData,
			Map<String, String> idMap) {

		for (int[] indices : apData
				.createIndexTraversalBasis(AXP_COMMLVEH_XPATH)) {

			for (Iterator<Entry<String, String>> i = idMap.entrySet()
					.iterator(); i.hasNext();) {
				String coverageToMark = (String) i.next().getKey();
				String axpPolicyCoverageCode = AXP_POLICY_COVERAGE_CODE
						.replaceAll("\\$X", coverageToMark);
				boolean exists = apData.exists(AXP_COMMLVEH_XPATH
						+ axpPolicyCoverageCode, indices);
				if (exists) {
					String axpPolicyCoverage = AXP_POLICY_COVERAGE.replaceAll(
							"\\$X", coverageToMark);
					String apID = idMap.get(coverageToMark);
					apData.setAttributeText(AXP_COMMLVEH_XPATH
							+ axpPolicyCoverage, indices, "AP_ID", apID);
				}
			}
		}
	}

}
