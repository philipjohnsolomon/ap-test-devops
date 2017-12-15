package com.agencyport.autob.pdf.eform;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.fieldvalidation.validators.BaseValidator;
import com.agencyport.pdf.FieldValue;
import com.agencyport.pdf.GeneralOverfowGetter;
import com.agencyport.pdf.IFieldValueGetter;
import com.agencyport.pdf.PDFContext;
import com.agencyport.pdf.resource.FormField;
import com.agencyport.shared.APException;

public class AutobOverflowGetter implements IFieldValueGetter,
		GeneralOverfowGetter {

	private static String PERSPOLICYLOSS = "CommlPolicy.Loss";
	private static String PRIORCARRIER = "CommlPolicy.OtherOrPriorPolicy";
	private static String VEHICLEINFO = "CommlAutoLineBusiness.CommlRateState.CommlVeh";
	private static final String EXPLANATION = "Explanation : ";

	@Override
	public List<String> getGeneralOverFlow(APDataCollection apData)
			throws APException {
		// TODO Auto-generated method stub
		System.out.println(apData);
		List<String> builder = new ArrayList<String>();
		builder.addAll(getGeneralInfo(apData));
		builder.addAll(getVehicleInfo(apData));
		builder.addAll(getQuestionsOverflow(apData));
		builder.addAll(getLossHistory(apData));
		builder.addAll(getPriorCarrier(apData));
		return builder;
	}

	private List<String> getGeneralInfo(APDataCollection apData) {
		List<String> builder = new ArrayList<String>();
		builder.add("\n General Information : ");
		builder.add("\n");
		builder.add("\n Doing Business As : "
				+ apData.getFieldValue(
						"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.NameInfo.SupplementaryNameInfo[SupplementaryNameCd='DBA'].SupplementaryName",
						null));
		builder.add("\n Legal Entity : "
				+ apData.getFieldValue(
						"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.NameInfo.LegalEntityCd",
						null));
		builder.add("\n  Date Business Started : "
				+ apData.getFieldValue(
						"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].InsuredOrPrincipalInfo.BusinessInfo.BusinessStartDt",
						null));
		builder.add("\n  Billing Method : "
				+ apData.getFieldValue("CommlPolicy.BillingMethodCd", null));
		builder.add("\n  Gross Annual Revenues : "
				+ apData.getFieldValue(
						"CommlPolicy.CommlPolicySupplement.CommlParentOrSubsidiaryInfo[MiscParty.MiscPartyInfo.MiscPartyRoleCd='ParentCompany'].AnnualGrossReceiptsAmt.Amt",
						null));
		builder.add("\n E-Mail Address  : "
				+ apData.getFieldValue(
						"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.Communications.EmailInfo[CommunicationUseCd='Business'].EmailAddr",
						null));
		builder.add("\n Inspection Contact Information");
		builder.add("\n Name : "
				+ apData.getFieldValue(
						"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd='InspectionContact'].GeneralPartyInfo.NameInfo.CommlName.CommercialName",
						null));
		builder.add("\n Phone : "
				+ apData.getFieldValue(
						"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd='InspectionContact'].GeneralPartyInfo.Communications.PhoneInfo[PhoneTypeCd='Phone' &amp;&amp; CommunicationUseCd='Business'].PhoneNumber",
						null));
		builder.add("\n Business Email Address : "
				+ apData.getFieldValue(
						"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd='InspectionContact'].GeneralPartyInfo.Communications.EmailInfo[CommunicationUseCd='Business'].EmailAddr",
						null));
		builder.add("\n Accounting Contact Information");
		builder.add("\n Name : "
				+ apData.getFieldValue(
						"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd='AC'].GeneralPartyInfo.NameInfo.CommlName.CommercialName",
						null));
		builder.add("\n Phone : "
				+ apData.getFieldValue(
						"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd='AC'].GeneralPartyInfo.Communications.PhoneInfo[PhoneTypeCd='Phone' &amp;&amp; CommunicationUseCd='Business'].PhoneNumber",
						null));
		builder.add("\n Business Email Address : "
				+ apData.getFieldValue(
						"CommlPolicy.MiscParty[MiscPartyInfo.MiscPartyRoleCd='AC'].GeneralPartyInfo.Communications.EmailInfo[CommunicationUseCd='Business'].EmailAddr",
						null));
		builder.add("\n Nature Of Business");
		builder.add("\n Please describe the nature of the business in the space below. : "
				+ apData.getFieldValue(
						"InsuredOrPrincipal.InsuredOrPrincipalInfo[InsuredOrPrincipalRoleCd='Insured'].BusinessInfo.OperationsDesc",
						null));
		builder.add("\n");
		return builder;

	}

	public List<String> getVehicleInfo(APDataCollection apData) {
		List<String> builder = new ArrayList<String>();

		int count = apData.getCount(VEHICLEINFO);
		if (count > 0) {

			builder.add("\n\n Vehicle Information : \n");
			//for (int i = 0; i < count; i++) {
			for (int[] indices : apData.createIndexTraversalBasis(VEHICLEINFO)) {

				if ("NYMA".equals(apData.getFieldValue(VEHICLEINFO + ".CommlCoverage[CoverageCd='NYMA'].CoverageCd", indices,
						null))) {

					builder.add("\n Mutual Aid : YES");
				}

				if ("POLUT"
						.equals(apData
								.getFieldValue(
										VEHICLEINFO + ".CommlCoverage[CoverageCd='POLUT'].CoverageCd", indices,
										null))) {

					builder.add("\n Pollution Liability Broadened Coverage : YES");
				}
				if ("INLW".equals(apData.getFieldValue(VEHICLEINFO + ".CommlCoverage[CoverageCd='INLW'].CoverageCd", indices,
						null))) {

					builder.add("\n Cov for Injury - Leased Workers : YES");
				}
				builder.add("\n Fellow Empl Cov - Name Person(s) : "
						+ apData.getFieldValue(
								VEHICLEINFO	+ ".CommlCoverage[CoverageCd='FELIA'].MiscParty[MiscPartyInfo.MiscPartyRoleCd='Employee'].GeneralPartyInfo.NameInfo.CommlName.CommercialName", indices,
								null));
				builder.add("\n Fellow Empl Coverage - Job Title(s) or Position(s) : "
						+ apData.getFieldValue(
								VEHICLEINFO + ".CommlCoverage[CoverageCd='FELIA'].CoverageDesc", indices,
								null));
				builder.add("\n Accident Prevention Course Date : "
						+ apData.getFieldValue(
								VEHICLEINFO + ".CommlCoverage[CoverageCd='APC'].EffectiveDt", indices,
								null));
				builder.add("\n Motorcycle Training Course Completion Date : "
						+ apData.getFieldValue(
								VEHICLEINFO + ".CommlCoverage[CoverageCd='MCTR'].EffectiveDt", indices,
								null));
				builder.add("\n Defensive Driving Course Date : "
						+ apData.getFieldValue(
								VEHICLEINFO + ".CommlCoverage[CoverageCd='DD'].EffectiveDt", indices,
								null));
				builder.add("\n Anti-Theft Device : "
						+ apData.getFieldValue(VEHICLEINFO + ".AntiTheftDeviceInfo.AntiTheftDeviceCd", indices,
								null));

				if ("DAYLT"
						.equals(apData
								.getFieldValue(
										VEHICLEINFO + ".CommlCoverage[CoverageCd='DAYLT'].CoverageCd", indices, null))) {

					builder.add("\n Auxiliary Running Lamps : YES");
				}
				builder.add("\n Passive Restraint : "
						+ apData.getFieldValue(
								VEHICLEINFO + ".CommlCoverage[CoverageCd='PASSR'].CreditOrSurcharge.CreditSurchargeCd", indices,
								null));

				if ("DC"
						.equals(apData
								.getFieldValue(
										VEHICLEINFO + ".CommlVehSupplement[VehUseCd='DC'].VehUseCd", indices,
										null))) {

					builder.add("\n Day Care Center Vehicle : YES");
				}
				builder.add("\n");
			}

		}

		return builder;

	}

	private List<String> getQuestionsOverflow(APDataCollection apData) {
		List<String> builder = new ArrayList<String>();
		builder.add("\n Underwriting Questions : ");
		builder.add("\n");
		builder.add("\n Is the applicant a subsidiary of another entity?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL34'].Explanation",
				null));
		builder.add("\n Does the applicant have any subsidiaries?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL35'].Explanation",
				null));
		builder.add("\n Is a formal safety program in operation?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL47'].Explanation",
				null));
		builder.add("\n Any exposure to flammables, explosives, chemicals? ");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL41'].Explanation",
				null));
		builder.add("\n Any other insurance with this company or being submitted? ");
		builder.add("\n " + EXPLANATION);

		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL22'].Explanation",
				null));
		builder.add("\n Any policy or coverage declined, cancelled or non-renewed during the prior 3 years? (Not applicable in MO)");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL06'].Explanation",
				null));
		builder.add("\n Any past losses or claims relating to sexual abuse or molestation allegations, discrimination or negligent hiring?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL07'].Explanation",
				null));
		builder.add("\n During the Last Five Years (Ten in RI), has any Applicant been Indicted for or Convicted of any degree of the crime of fraud,");
		builder.add("\n  Bribery, Arson Or any other Arson-Related crime in Connection with this or any other property ? ");
		builder.add("\n ( In RI, this question must be answered by any applicant for property insurance. Failure to disclose the existence of an");
		builder.add("\n arson conviction is a misdemeanor punishable by a sentence of up to one year of imprisonment)");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL61'].Explanation",
				null));
		builder.add("\n Any uncorrected fire code violations?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL09'].Explanation",
				null));
		builder.add("\n Has applicant had a foreclosure, repossession or bankruptcy during the past five years?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL25'].Explanation",
				null));
		builder.add("\n Has applicant had a judgement or lien during the specified number of years?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL63'].Explanation",
				null));
		builder.add("\n Has business been placed in a trust?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL40'].Explanation",
				null));
		builder.add("\n  Any foreign operations, foreign products distributed in USA, or US products sold/distributed in foreign countries?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL52'].Explanation",
				null));
		builder.add("\n Does applicant have other business ventures for which coverage is not requested?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData.getFieldValue(
				"CommlPolicy.QuestionAnswer[QuestionCd='GENRL64'].Explanation",
				null));
		builder.add("\n");

		builder.add("\n With the exception of encumbrances, are any vehicles not solely owned by and registered to the applicant?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOP11'].Explanation",
						null));
		builder.add("\n Do over 50% of the employees use their autos in the business?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB11'].Explanation",
						null));
		builder.add("\n Is there a vehicle maintenance program in operation? ");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='INMRC09'].Explanation",
						null));
		builder.add("\n Are any vehicles leased to others?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='CUMBR07'].Explanation",
						null));
		builder.add("\n Are any vehicles customized, altered or have special equipment?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB07'].Explanation",
						null));
		builder.add("\n Are ICC, PUC or other filings required?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB04'].Explanation",
						null));
		builder.add("\n Do operations involve transporting hazardous material?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB06'].Explanation",
						null));
		builder.add("\n Any hold harmless agreements?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB01'].Explanation",
						null));
		builder.add("\n Any vehicles used by family members?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB02'].Explanation",
						null));
		builder.add("\n Does the applicant obtain MVR verifications?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='INMRC10'].Explanation",
						null));
		builder.add("\n Does the applicant have a specific driver recruiting method?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='INMRC14'].Explanation",
						null));
		builder.add("\n Are any drivers not covered by Worker's Compensation?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB08'].Explanation",
						null));
		builder.add("\n Any vehicles owned but not scheduled on this application?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB03'].Explanation",
						null));
		builder.add("\n Any drivers with convictions for moving traffic violations?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB09'].Explanation",
						null));
		builder.add("\n Has agent inspected vehicles?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB12'].Explanation",
						null));
		builder.add("\n Are all vehicles to be included in this policy part of a fleet?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.QuestionAnswer[QuestionCd='AUTOB17'].Explanation",
						null));
		builder.add("\n Do you have electronic monitoring devices that record and transmit data in any of your vehicles?");
		builder.add("\n " + EXPLANATION);
		builder.add("\n");
		builder.add(apData
				.getFieldValue(
						"CommlAutoLineBusiness.CommlAutoPolicyInfo.ElectronicMonitoringInfo.OtherMonitoringUse.OtherUseDescription",
						null));
		builder.add("\n");
		return builder;
	}

	/**
	 * @param apData
	 * @return list with overflow loss history.
	 */
	public List<String> getLossHistory(APDataCollection apData) {

		List<String> builder = new ArrayList<String>();

		int count = apData.getCount(PERSPOLICYLOSS);
		if (count > 3) {

			builder.add("\n\n Loss History : \n");

			for (int i = 3; i < count; i++) {
				builder.add("\n Date Of Occurence : "
						+ apData.getFieldValue(PERSPOLICYLOSS + "[" + i + "]"
								+ ".LossDt", null));
				builder.add("\n Description : "
						+ apData.getFieldValue(PERSPOLICYLOSS + "[" + i + "]"
								+ ".LossDesc", null));
				builder.add("\n Date Of Claim : "
						+ apData.getFieldValue(PERSPOLICYLOSS + "[" + i + "]"
								+ ".ReportedDt", null));
				builder.add("\n Amount Paid : "
						+ apData.getFieldValue(PERSPOLICYLOSS + "[" + i + "]"
								+ ".TotalPaidAmt.Amt", null));
				builder.add("\n Amount Reserved : "
						+ apData.getFieldValue(PERSPOLICYLOSS + "[" + i + "]"
								+ ".ProbableIncurredAmt.Amt", null));
				builder.add("\n Amount : "
						+ apData.getFieldValue(PERSPOLICYLOSS + "[" + i + "]"
								+ ".ClaimSettledInd", null));
				builder.add("\n");
			}

		}

		return builder;

	}

	public List<String> getPriorCarrier(APDataCollection apData) {

		List<String> builder = new ArrayList<String>();

		int count = apData.getCount(PRIORCARRIER);
		if (count > 3) {

			builder.add("\n Prior Carrier : \n");

			for (int i = 3; i < count; i++) {
				builder.add("\n Carrier : "
						+ apData.getFieldValue(PRIORCARRIER + "[" + i + "]"
								+ ".InsurerName", null));
				builder.add("\n Policy Number : "
						+ apData.getFieldValue(PRIORCARRIER + "[" + i + "]"
								+ ".PolicyNumber", null));
				builder.add("\n Premium : "
						+ apData.getFieldValue(PRIORCARRIER + "[" + i + "]"
								+ ".PolicyAmt.Amt", null));
				builder.add("\n Effective Date : "
						+ apData.getFieldValue(PRIORCARRIER + "[" + i + "]"
								+ ".ContractTerm.EffectiveDt", null));
				builder.add("\n Expiration Date : "
						+ apData.getFieldValue(PRIORCARRIER + "[" + i + "]"
								+ ".ContractTerm.ExpirationDt", null));

				builder.add("\n");
			}

		}

		return builder;

	}

	@Override
	public FieldValue get(FormField field, PDFContext context, int[] indices,
			Map<String, String> customParams) throws APException {
		// TODO Auto-generated method stub
		return null;
	}

}
