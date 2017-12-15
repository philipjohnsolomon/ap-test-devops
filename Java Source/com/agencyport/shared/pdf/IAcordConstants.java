package com.agencyport.shared.pdf;

/**
 * @author djenner
 *
 */
public interface IAcordConstants {

	public static final String CHECKED = "X";
	public static final String OTHER_DESC = "Other";

	// Boolean constants
	public static final String YES = "YES";
	public static final String NO = "NO";

	// How is the rating info (class codes, etc) stored for this carrier?
	// This is non Acord.
	public static final String RATING_INFO_IS_BY_STATE 		= "ByState";
	public static final String RATING_INFO_IS_BY_LOCATION 	= "ByLocation";
	public static final String LOSS_STORED_BY_COMML_POLICY 	= "ByCommlPolicy";
	public static final String LOSS_STORED_BY_PRIOR_POLICY 	= "ByPriorPolicy";

	public static final String QUESTION_CODE_PREFIX_130 ="ACORD130_";
	public static final String QUESTION_CODE_PREFIX_125 ="ACORD125_";

	public static final String MOD_TYPE = "MOD_TYPE";
	public static final String MOD_CATEGORY = "MOD_CATEGORY";

	/***********  ACORD CODE LISTS BELOW  **************/

	// LegalEntity
	public static final String CORPORATION = "CP";
	public static final String PARTNERSHIP = "PT";
	public static final String GENERAL_PARTNERSHIP = "GP";
	public static final String INDIVIDUAL = "IN";
	public static final String S_CORP = "SCORP";
	public static final String SUBCHAPTER_S_CORP = "SS";
	public static final String LIMITED_CORP = "LC";
	public static final String LIMITED_LIABILITY_CORP = "LL";
	public static final String OTHER = "OT";

	// SupplementaryNameType
	public static final String DOING_BUSINESS_AS = "DBA";

	// Billing Method
	public static final String AGENCY_BILLED = "AB";
	public static final String COMPANY_ACCOUNT_BILLED = "CAB";
	public static final String COMPANY_POLICY_BILLED = "CPB";

	// Frequency (Payment Plan, Audit)
	public static final String ANNUAL = "AN";
	public static final String SEMI_ANNUAL = "SA";
	public static final String QUARTERLY = "QT";
	public static final String MONTHLY = "MO";
	public static final String AT_EXPIRATION = "XP";
	public static final String PREMIUM_FINANCED = "PF";
						// also available is OTHER

	// Program type codes
	public static final String PROG_UMBRELLA = "Umbrella";
	public static final String PROG_EXCESS = "Excess";

	// Policy type codes
	public static final String POL_CGM = "CGM";
	public static final String POL_OCCUR = "OCCUR";

	// ProducerRoleCd
	public static final String PRODUCER_ROLE_AGENCY = "Agency";
	public static final String PRODUCER_ROLE_AGENT = "Producer";

	// PhoneTypeCd
	public static final String PHONE_TYPE_PHONE = "Phone";
	public static final String PHONE_TYPE_CELL = "Cell";
	public static final String PHONE_TYPE_FAX 	= "Fax";

	// CommunicationUseCd
	public static final String COMMUNICATION_USE_CODE = "Business";

		// Contact RoleType
	public static final String CONTACT_ROLE_AUDIT = "AUC";
	public static final String CONTACT_ROLE_ACCOUNTING = "AC";
	public static final String CONTACT_ROLE_INSPECTION = "InspectionContact";
	public static final String CONTACT_ROLE_CLAIMS = "CC";

	// Coverage Codes
	public static final String EMPLOYERS_LIABILITY = "WCEL";
	public static final String EXPERIENCE_MOD = "EXP";
	public static final String USLH = "USLH";
	public static final String VOLUNTARY  = "VOL";
	public static final String FOREIGN = "FORRE";
													// non Acord standard
	public static final String FOREIGN_VOLUNTARY ="NonStnd_FORRE_VOL";
	public static final String DRUG_FREE_CREDIT = "DRUGF";
	public static final String MEDICAL_PROVIDER_CREDIT = "MEDPR";
	public static final String ARAP = "ARAP";
	public static final String LOSS_CONSTANT = "LCNT";
	public static final String EXPENSE_CONSTANT = "EXCNT";
	public static final String MANAGED_CARE = "MCARE";
	public static final String MERIT_RATING = "MERIT";
	public static final String DRUG_FREE = "DRUGF";
											// not in Acord Coverage Codes
	public static final String QUALIFIED_LOSS_MANAGEMENT = "QUALIFIED LOSS MANAGEMENT ";
	public static final String OUTER_CONTINENTAL_SHELF = "OUTERCONTINENTALSHELF";
	public static final String ALTERNATE_EMPLOYER = "ALTERNATE_EMPLOYER";
	public static final String WVSUB_SPECIFIC = "WVSUB_SPECIFIC";
	public static final String WVSUB_BLANKET = "WVSUB_BLANKET";
	public static final String MARITIME = "MARITIME";

	// Coverage Applies To
	public static final String EACH_ACCIDENT = "BIEachOcc";
	public static final String DISEASE_POLICY_LIMIT = "DisPol";
	public static final String DISEASE_EACH_EMPLOYEE = "DisEachEmpl";

	// Title - very partial list
	public static final String TITLE_PRESIDENT = "Pres";
	public static final String TITLE_VICE_PRESIDENT = "VP";
	public static final String TITLE_PARTNER = "Ptnr";
	public static final String TITLE_OFFICER = "ElecOfc";
	public static final String TITLE_OTHER = "Ot";
	public static final String TITLE_NON_STANDARD_RELATIVE = "NonStnd_Rel";


	// IncludedExcluded
	public static final String INCLUDED = "I";
	public static final String EXCLUDED = "E";
	
	
	// LineOfBusinessSubCode
	public static final String DISCOVERY = "DISC";
	public static final String LOSS_SUSTAINED = "LSUD";		
	
	// Coverage Type
	public static final String COV_BLANKET = "BLNKT";
	public static final String COV_SCHEDULED = "SCHED";
	
	// Risk Location	
	public static final String RISK_LOCATION_INSIDE_LIMIT = "IN";
	public static final String RISK_LOCATION_OUTSIDE_LIMIT = "OUT";
	
	// Wind Class Codes	
	public static final String WIND_CLASS_WR = "WR";
	public static final String WIND_CLASS_SWR = "SWR";
	public static final String WIND_CLASS_OT = "OT";
	
	//Inlane Marine Acord 125 related indicators
	public static final String ANNUAL_TRANSIT 			= "CommlInlandMarineLineBusiness.AnnualTransit";
	public static final String COMPUTER_EQUIPMENT 		= "CommlInlandMarineLineBusiness.ComputerEquipment";	
	public static final String CONTRACTORS_EQUIPMENT 	= "CommlInlandMarineLineBusiness.ContractorsEquipment";
	public static final String INSTALLATION 			= "CommlInlandMarineLineBusiness.Installation";
	public static final String BUILDERS_RISK 			= "CommlInlandMarineLineBusiness.BuildersRisk";
	public static final String BR_COMML_IM_CLASS_CD		= "BuildersRisk";
	public static final String CONTR_COMML_IM_CLASS_CD	= "ContractorsEquipment";
	
}