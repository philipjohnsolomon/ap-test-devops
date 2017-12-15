/*
 * Created on Mar 11, 2005
 *
 */
package com.agencyport.shared.commercial.pdf.acord125;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.apps.common.utils.CustomDateUtil;
import com.agencyport.shared.pdf.AdditionalDataSupport;

/**
 * Prints the Prior Insurance Information
 * @author AgencyPort Inc.
 *
 */
public class PriorCarrierBox extends AdditionalDataSupport {
	
	/**
	 * The <code>CARRIER</code> is a String constant
	 */
	private static final String CARRIER = "  Carrier                : ";
	
	/**
	 * The <code>MOD_FACTOR</code>is a String constant
	 */
	private static final String MOD_FACTOR =  "  Mod Factor             : ";
	
	/**
	 * The <code>POLICY</code>is a String constant
	 */
	private static final String POLICY = "  Policy #               : ";
	
	/**
	 * The <code>TOT_PREM</code>is a String constant
	 */
	private static final String TOT_PREM  =  "  Tot Prem               : ";
	
	/**
	 * The <code>CUMBR</code>is a String constant
	 */
	private static final String CUMBR = "CUMBR";
	
	/**
	 * The <code>COMMLPOLICY_OTHERORPRIORPOLICY</code>is a String constant
	 */
	private static final String COMMLPOLICY_OTHERORPRIORPOLICY = "CommlPolicy.OtherOrPriorPolicy";
	
	/**
	 * The <code>COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EFFECTIVEDT</code>is a String constant
	 */
	private static final String COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EFFECTIVEDT  =  "CommlPolicy.OtherOrPriorPolicy.ContractTerm.EffectiveDt";
	
	
	/**
	 * The <code>COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EXPIRATIONDT</code>is a String constant
	 */
	private static final String COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EXPIRATIONDT  =  "CommlPolicy.OtherOrPriorPolicy.ContractTerm.ExpirationDt";
	
	/**
	 * The <code>COMMLPOLICY_OTHERORPRIORPOLICY_INSURERNAME</code>is a String constant
	 */
	private static final String COMMLPOLICY_OTHERORPRIORPOLICY_INSURERNAME  = "CommlPolicy.OtherOrPriorPolicy.InsurerName";
	
	/**
	 * The <code>CommlPolicy_OtherOrPriorPolicy_LOBCd</code>is a String constant
	 */
	private static final String COMMLPOLICY_OTHERORPRIORPOLICY_LOBCD  = "CommlPolicy.OtherOrPriorPolicy.LOBCd";
	
	/**
	 * The <code>COMMLPOLICY_OTHERORPRIORPOLICY_POLICYAMT_AMT</code>is a String constant
	 */
	private static final String COMMLPOLICY_OTHERORPRIORPOLICY_POLICYAMT_AMT  = "CommlPolicy.OtherOrPriorPolicy.PolicyAmt.Amt";
	
	/**
	 * The <code>COMMLPOLICY_OTHERORPRIORPOLICY_POLICYCD</code>is a String constant
	 */
	private static final String COMMLPOLICY_OTHERORPRIORPOLICY_POLICYCD  = "CommlPolicy.OtherOrPriorPolicy.PolicyCd";
	
	/**
	 * The <code>COMMLPOLICY_OTHERORPRIORPOLICY_POLICYNUMBER</code>is a String constant
	 */
	private static final String COMMLPOLICY_OTHERORPRIORPOLICY_POLICYNUMBER  = "CommlPolicy.OtherOrPriorPolicy.PolicyNumber";
	
	/**
	 * The <code>COMMLPOLICY_OTHERORPRIORPOLICY_RATINGFACTOR</code>is a String constant
	 */
	private static final String COMMLPOLICY_OTHERORPRIORPOLICY_RATINGFACTOR  = "CommlPolicy.OtherOrPriorPolicy.RatingFactor";
	
	/**
	 * The <code>PROPC</code>is a String constant
	 */
	private static final String PROPC  = "PROPC";
	
	/**
	 * The <code>PRIOR</code>is a String constant
	 */
	private static final String PRIOR  = "Prior";
	
	/**
	 * The <code>UMBRC</code>is a String constant
	 */
	private static final String UMBRC  = "UMBRC";
	
    /**
     * The <code>UNDERLYINGINSURANCE_OTHER_EFFEXPDATE </code>is a String constant
     */
    private static final String UNDERLYINGINSURANCE_OTHER_EFFEXPDATE  = "UnderlyingInsurance.Other.EffExpDate.";
	/**
	 * Default Constructor
	 */
	public PriorCarrierBox() {
		super(5);
	}
	/**
	 * Invokes four methods responsible for printing the liability information
	 * @param pdfDocument
	 * @param apData
	 */
	public  void process (PdfDocument pdfDocument, APDataCollection apData) {
		printGeneralLiability(pdfDocument, apData);
		printAutoLiability(pdfDocument, apData);
		printPropertyLiability(pdfDocument, apData);
		printOtherLiability(pdfDocument, apData);
	}
/**
 * Prints general liability information
 * @param pdfDocument
 * @param apData
 */
	private void printGeneralLiability(PdfDocument pdfDocument, APDataCollection apData) {
		String[] values = null;
		
		int oppCount = apData.getCount(COMMLPOLICY_OTHERORPRIORPOLICY);
		for (int i =0; i< oppCount; i++) {
			int  pIndex =0;
			String policyCode =  apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYCD, i, "");		
			if (PRIOR.equalsIgnoreCase(policyCode) ) {
				String lobCode =  apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_LOBCD, i, "");
				if ("CGL".equalsIgnoreCase(lobCode) ) {
					values = getGeneralValues(apData, i);
					if (pIndex < maxSizeAllowed){
						printGenInfo(pdfDocument, values, pIndex);
					}else {
						// print first time
						if (i == maxSizeAllowed) { 
							additionalPageContent.add("ADDITIONAL GENERAL LIABILITY PRIOR CARRIER INFORMATION : ");
							additionalPageContent.add(" ");
						}
						formatGeneralAsAdditionalPageInfo(values, pIndex);
					}
					pIndex++;
				}
			}
		}
	}

	/**
	 * @param apData
	 * @param instance
	 * @return array of Strings
	 */
	public String[] getGeneralValues(APDataCollection apData, int instance){
		String[] values = new String[20];
		int index = 0;
		
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_INSURERNAME, instance, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYNUMBER, instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.ClaimsMadeInfo.ClaimsMadeInd", instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.ClaimsMadeInfo.CurrentRetroactiveDt", instance, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EFFECTIVEDT, instance, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EXPIRATIONDT, instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"GENAG\"].Limit.FormatInteger", instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"PRDCO\"].Limit.FormatInteger", instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"PIADV\"].Limit.FormatInteger", instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"EAOCC\"].Limit.FormatInteger", instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"FIRDM\"].Limit.FormatInteger", instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"MEDEX\"].Limit.FormatInteger", instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd='BI'].Limit[LimitAppliesToCd='BIEachOcc'].FormatInteger",instance,"");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd='BI'].Limit[LimitAppliesToCd='Aggregate'].FormatInteger",instance,"");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd='PD'].Limit[LimitAppliesToCd='PDEachOcc'].FormatInteger",instance,"");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd='PD'].Limit[LimitAppliesToCd='Aggregate'].FormatInteger",instance,"");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd='CSL'].Limit.FormatInteger",instance,"");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_RATINGFACTOR, instance, "");
		index++;
		values[index] =  apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYAMT_AMT, instance, "");
		
		return values;
	}
	
	/**
	 * @param pdfDocument
	 * @param values
	 * @param i
	 */
	private void printGenInfo(PdfDocument pdfDocument, String[] values, int i){
		int index =0;
		
		pdfDocument.printField(values[index],"Prior.General.Carrier." + (i +1));
		index++;
		pdfDocument.printField(values[index],"Prior.General.Policy." + (i +1));
		index++;
		// Assumptions here: If not a claims made policy, then Per Occurrence type
		if ("1".equals(values[index])){
			pdfDocument.printField("X","Prior.General.ClaimsMade." + (i +1));
		}else{
			pdfDocument.printField("X","Prior.General.Occurence." + (i +1));
		}
		index++;
		pdfDocument.printField(values[index], "Prior.General.RetroDate." + (i+1));
		index++;
		String effectiveDate = values[index];
		index++;
		String expiryDate = values[index];
		
		if(effectiveDate.length() > 0) {
			pdfDocument.printField(effectiveDate + "|" + expiryDate, "Prior.General.EffExpDate." + (i+1));
		}else {
			pdfDocument.printField(expiryDate, "Prior.General.EffExpDate." + (i+1));
		}
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.GeneralAggr." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.ProdCompOpsAggregate." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.PersonalAdvInjury." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.EachOccurance." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.DamageToRentedPremises." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.MedicalExpense." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.BodilyInjury.Occurence." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.BodilyInjury.Aggregate." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.PropertyDamage.Occurence." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.PropertyDamage.Aggregate." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.CombinedSingleLimit." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.RatingMod." + (i +1));
		index++;
		pdfDocument.printField(values[index], "Prior.General.Limits.TotalPremium." + (i +1));
	}
	
	/**
	 * @param values
	 * @param index
	 */
	private void formatGeneralAsAdditionalPageInfo(String[] values, int index){
		for (int seq=0; seq< values.length;seq++) {
			if (seq == 0) {
				additionalPageContent.add(CARRIER + values[seq]);
			} else if (seq == 1) {
				additionalPageContent.add(POLICY + values[seq]);
			} else if (seq == 2) {
				additionalPageContent.add("  Claims Made Indicator  : " +values[seq]);
			}else if (seq == 3) {
				// intentionally left unimplemented
			} else if (seq == 5) {
				additionalPageContent.add("  Effective / Expiry DT  : " + values[seq-1] + "/ " +  values[seq]);
			} else if (seq == 6) {
				additionalPageContent.add("  Gen Agr Limit          : " + values[seq]);
			} else if (seq == 7) {
				additionalPageContent.add("  Prod Agr Limit         : " + values[seq]);
			} else if (seq == 8) {
				additionalPageContent.add("  Pers Inj Limit         : " +values[seq]);
			} else if (seq == 9) {
				additionalPageContent.add("  Each Occ Limit         : " + values[seq]);
			} else if (seq == 10) {
				additionalPageContent.add("  Fire Dam Limit         : " + values[seq]);
			} else if (seq == 11) {
				additionalPageContent.add("  Med Exp Limit          : " + values[seq]);
			} else if (seq == 12) {
				// intentionally left unimplemented
			} else if (seq == 13) {
				// intentionally left unimplemented
			} else if (seq == 14) {
				// intentionally left unimplemented
			} else if (seq == 15) {
				// intentionally left unimplemented
			} else if (seq == 16) {
				// intentionally left unimplemented
			} else if (seq == 17) {
				additionalPageContent.add(MOD_FACTOR+ values[seq]);
			} else if (seq == 18) {
				additionalPageContent.add(TOT_PREM + values[seq]);
			}
		}
		
		additionalPageContent.add(" ");
	}
	
	/**
	 * @param pdfDocument
	 * @param apData
	 */
	private void printAutoLiability(PdfDocument pdfDocument, APDataCollection apData) {
		
		
		int lobCount = apData.getCount(COMMLPOLICY_OTHERORPRIORPOLICY);
		for (int i =0; i< lobCount; i++) {
			int pIndex =0;
			String policyCode =  apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYCD, i, "");
			if (PRIOR.equalsIgnoreCase(policyCode) ) {
				String lobCode =  apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_LOBCD, i, "");
				//refactored to reduce Cyclomatic complexity
				pIndex = printAutoLiabilityContinued(pdfDocument, apData, i, pIndex, lobCode);
			}
		}
	}
	/**
	 * @param pdfDocument
	 * @param apData
	 * @param i
	 * @param pIndex
	 * @param lobCode
	 * @return int
	 */
	private int printAutoLiabilityContinued(PdfDocument pdfDocument, APDataCollection apData, int i, int pIndex, String lobCode) {
		int pIndexTemp = pIndex;
		String[] values = null;
		if ("AUTOB".equalsIgnoreCase(lobCode) ) {
			values = getAutoValues(apData, i);
			if (pIndexTemp < maxSizeAllowed){
				printAutoInfo(pdfDocument, values, pIndexTemp);
			}else {
				if (i == maxSizeAllowed) { 
					additionalPageContent.add("ADDITIONAL AUTO LIBILITY INFORMATION : ");
					additionalPageContent.add(" ");
				}
				formatAutoAsAdditionalPageInfo(values, pIndexTemp);
			}
			pIndexTemp++;
		}
		return pIndexTemp;
	}

	/**
	 * @param apData
	 * @param path
	 * @return array of Strings
	 */
	public String[] getAutoValues(APDataCollection apData, int path){
		String[] values = new String[12];
		int index = 0;
		
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_INSURERNAME, path, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYNUMBER, path, "");
		index++;
		String lobcd = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_LOBCD, path, "");
		String policytype = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYCD, path, "");		
		values[index] = lobcd + "/" + policytype;
		index++;
		
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EFFECTIVEDT, path, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EXPIRATIONDT, path, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"CSL\"].Limit.FormatInteger", path, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"BISPL\"].Limit[LimitAppliesToCd=\"PerPerson\"].FormatInteger", path, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"BISPL\"].Limit[LimitAppliesToCd=\"PerAcc\"].FormatInteger", path, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd=\"PD\"].Limit.FormatInteger", path, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_RATINGFACTOR, path, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYAMT_AMT, path, "");
		
		return values;
	}
	
	/**
	 * @param pdfDocument
	 * @param values
	 * @param i
	 */
	private void printAutoInfo(PdfDocument pdfDocument, String[] values, int i){
		int index =0;
		pdfDocument.printField(values[index],"UnderlyingInsurance.Auto.Carrier." + (i+1));
		index++;
		pdfDocument.printField(values[index],"UnderlyingInsurance.Auto.Policy." + (i+1));
		index++;
		pdfDocument.printField(values[index],"UnderlyingInsurance.Auto.PolicyType." + (i+1));
		index++;
		String effectiveDate = values[index];
		index++;
		String expiryDate = values[index];
		index++;
		if(effectiveDate.length() > 0) {
			pdfDocument.printField(effectiveDate + "|" + expiryDate, "UnderlyingInsurance.Auto.EffExpDate." + (i+1));
		}else {
			pdfDocument.printField(expiryDate, "UnderlyingInsurance.Auto.EffExpDate." + (i+1));
		}
			

		pdfDocument.printField(values[index], "UnderlyingInsurance.Auto.Limits.CSLEachAcc." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Auto.Limits.BIEachPer." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Auto.Limits.BIEachAcc." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Auto.Limits.PDEachAcc." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Auto.RatingMod." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Auto.TotalPremium." + (i+1));
	}
	
	/**
	 * @param values
	 * @param index
	 */
	private void formatAutoAsAdditionalPageInfo(String[] values, int index){
		for (int seq=0; seq< values.length;seq++) {
			if (seq == 0) {
				additionalPageContent.add(CARRIER + values[seq]);
			} else if (seq == 1) {
				additionalPageContent.add(POLICY + values[seq]);
			} else if (seq == 2) {
				additionalPageContent.add("  Policy Type            : " + values[seq]);
			} else if (seq == 3) {
				additionalPageContent.add("  Effective / Expiry DT  : " + values[seq++] + "/ " + values[seq]);
			} else if (seq == 5) {
				additionalPageContent.add("  Comb Single Limit      : " + values[seq]);
			} else if (seq == 6) {
				additionalPageContent.add("  BI Each Per Limit      : " + values[seq]);
			} else if (seq == 7) {
				additionalPageContent.add("  BI Each Acc Limit      : " + values[seq]);
			} else if (seq == 8) {
				additionalPageContent.add("  Prop Dam Limit         : " + values[seq]);
			} else if (seq == 9) {
				additionalPageContent.add(MOD_FACTOR + values[seq]);
			} else if (seq == 10) {
				additionalPageContent.add(TOT_PREM + values[seq]);
			}
		}
		
		additionalPageContent.add(" ");
	}
	
	/**
	 * @param pdfDocument
	 * @param apData
	 */
	private void printOtherLiability(PdfDocument pdfDocument, APDataCollection apData) {
		String[] values = null;
		boolean bPrintOtherLiabilityName = false;
		int lobCount = apData.getCount(COMMLPOLICY_OTHERORPRIORPOLICY);
			
		for (int i =0; i< lobCount; i++) {
			int pIndex =0;
			String policyCode =  apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYCD, i, "");
			if(!PRIOR.equalsIgnoreCase(policyCode)) {
				continue;
			}
			String lobCode =  apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_LOBCD, i, "");
			if ( ("CGL".equalsIgnoreCase(lobCode) && PRIOR.equalsIgnoreCase(policyCode) ) || ("AUTOB".equalsIgnoreCase(lobCode) && PRIOR.equalsIgnoreCase(policyCode) )  ||
			     (PROPC.equalsIgnoreCase(lobCode) && PRIOR.equalsIgnoreCase(policyCode) )
				) {
				continue; 
			}
	
			if (!bPrintOtherLiabilityName) {
				String description = getLineOfBusiness(lobCode);
				String[] split = description.split(" ");
				
				for (int j = 0; j < split.length; j++) {
					PdfBox box = pdfDocument.getBox("UnderlyingInsurance.Other.Description" + (j + 1));
					box.addText(split[j]);	
					box.print();
				}
				bPrintOtherLiabilityName = true;
			}
			
			values = getOtherValues(apData, i, lobCode);
			if (pIndex < maxSizeAllowed){
				printOtherInfo(pdfDocument, values, pIndex, lobCode);
			}else {
				if (pIndex == maxSizeAllowed) { 
					additionalPageContent.add("ADDITIONAL OTHER LIBILITY INFORMATION : ");
					additionalPageContent.add(" ");
				}
				formatOtherAsAdditionalPageInfo(values, pIndex, lobCode);
			}
			pIndex++;
		}
	}

	/**
	 * @param apData
	 * @param path
	 * @param lobCode
	 * @return array of Strings
	 */
	public String[] getOtherValues(APDataCollection apData, int path, String lobCode){
		String[] values = new String[10];
		int index = 0;
		
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_INSURERNAME, path, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYNUMBER, path, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_LOBCD, path, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EFFECTIVEDT, path, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EXPIRATIONDT, path, "");
		index++;
		if(lobCode!= null && (CUMBR.equalsIgnoreCase(lobCode) || UMBRC.equalsIgnoreCase(lobCode))){
			values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd='EAOCC'].Limit.FormatInteger", path, "");
			index++;
			values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd='GENAG'].Limit.FormatInteger", path, "");	
			index++;
			values[index] = "";
			index++;
		}else{
			values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage.Limit.FormatInteger", path, "");
			index++;
		}
		
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_RATINGFACTOR, path, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYAMT_AMT, path, "");
		
		return values;
	}
	/**
	 * Prints the Garage and Dealer Prior Carrier Information
	 * @param pdfDocument
	 * @param values
	 * @param i
	 * @param lobCode
	 */
	private void printOtherInfo(PdfDocument pdfDocument, String[] values, int i, String lobCode){
		int index =0;
		pdfDocument.printField(values[index],"UnderlyingInsurance.Other.Carrier." + (i+1));
		index++;
		pdfDocument.printField(values[index],"UnderlyingInsurance.Other.Policy." + (i+1));
		index++;
		String policyType = getLineOfBusiness(values[index]);
		index++;
		pdfDocument.printField(policyType, "UnderlyingInsurance.Other.PolicyType." + (i+1));
		
		String effectiveDate = values[index];
		index++;
		String expiryDate = values[index];
		index++;
		if (effectiveDate.length() == 10){
			effectiveDate= CustomDateUtil.format(effectiveDate,CustomDateUtil.DATE_FORMAT_YYYY_DASH_MM_DASH_DD,CustomDateUtil.DATE_FORMAT_MM_SLASH_DD_SLASH_YYYY);
		}
		
		if (expiryDate.length() == 10){
			expiryDate= CustomDateUtil.format(expiryDate,CustomDateUtil.DATE_FORMAT_YYYY_DASH_MM_DASH_DD,CustomDateUtil.DATE_FORMAT_MM_SLASH_DD_SLASH_YYYY);
		}

		if (effectiveDate.length()==10 && expiryDate.length()==10){
			pdfDocument.printField(effectiveDate + "|"+ expiryDate, UNDERLYINGINSURANCE_OTHER_EFFEXPDATE + (i+1));
		}else if(effectiveDate.length()==10 && expiryDate.length()==0){
			pdfDocument.printField(effectiveDate +"|"+"          ", UNDERLYINGINSURANCE_OTHER_EFFEXPDATE + (i+1));
		}else if(effectiveDate.length()==0 && expiryDate.length()==10){
			pdfDocument.printField("          "+"|"+ expiryDate, UNDERLYINGINSURANCE_OTHER_EFFEXPDATE + (i+1));
		}
		
		String limitStr = values[index];
		index++;
		if(lobCode!= null && (CUMBR.equalsIgnoreCase(lobCode) || UMBRC.equalsIgnoreCase(lobCode)) ){
			limitStr = limitStr + "/" + values[index];
			index++;
			index++;
		}		
		pdfDocument.printField(limitStr, "UnderlyingInsurance.Other.Limit." + (i+1));
		pdfDocument.printField(values[index], "UnderlyingInsurance.Other.RatingMod." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Other.TotalPremium." + (i+1));
	}
	
	/**
	 * @param values
	 * @param index
	 * @param lobCode
	 */
	private void formatOtherAsAdditionalPageInfo(String[] values, int index, String lobCode){
		int seq = 0;
		int seq2= 0;
		additionalPageContent.add("  Carrier                    : " + values[seq]);
		seq++;
		additionalPageContent.add("  Policy #              	     : " + values[seq]);
		seq++;
		additionalPageContent.add("  Policy Type                : " + getLineOfBusiness(values[seq]) );
		seq++;
		seq2=seq+1;
		additionalPageContent.add("  Effective / Expiraion Date : " + 
				CustomDateUtil.format(values[seq],CustomDateUtil.DATE_FORMAT_MM_DASH_DD_DASH_YYYY,CustomDateUtil.DATE_FORMAT_MM_SLASH_DD_SLASH_YYYY) +
				" - " +  
				CustomDateUtil.format(values[seq2],CustomDateUtil.DATE_FORMAT_MM_DASH_DD_DASH_YYYY,CustomDateUtil.DATE_FORMAT_MM_SLASH_DD_SLASH_YYYY));
		seq=seq2;
		seq++;
		String limitStr = values[seq];
		seq++;
		
		if(lobCode!= null && (CUMBR.equalsIgnoreCase(lobCode) || UMBRC.equalsIgnoreCase(lobCode)) ){
			limitStr = limitStr + "/" + values[seq];
			// move the index further to account dummy value in array
			seq++;
			seq++; 
			additionalPageContent.add("  Limit (PerOcc/Aggregate)   : " + limitStr);					
		}else{			
					additionalPageContent.add("  Limit                  : " + values[seq]);
					seq++;	
		}
		additionalPageContent.add("  Mod Factor                 : " +values[seq]);
		seq++;
		additionalPageContent.add("  Tot Prem                   : " + values[seq]);
		additionalPageContent.add(" ");
	}
	/**
	 * @param pdfDocument
	 * @param apData
	 */
	private void printPropertyLiability(PdfDocument pdfDocument, APDataCollection apData) {
	

		int oppCount = apData.getCount(COMMLPOLICY_OTHERORPRIORPOLICY);
		for (int i =0; i< oppCount; i++) {
			int  pIndex =0;
			String policyCode =  apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYCD, i, "");		
			if (PRIOR.equalsIgnoreCase(policyCode) ) {
				String lobCode =  apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_LOBCD, i, "");
				//Refactored to reduce complexity
				printPropertyLiabilityContinued(pdfDocument, apData, i, pIndex, lobCode);
			}
		}
	}
	/**
	 * @param pdfDocument
	 * @param apData
	 * @param i
	 * @param pIndex
	 * @param lobCode
	 */
	private void printPropertyLiabilityContinued(PdfDocument pdfDocument, APDataCollection apData, int i, int pIndex, String lobCode) {
		String[] values;
		if (PROPC.equalsIgnoreCase(lobCode) ){			
			values = getPropertyValues(apData, i);
			if (pIndex < maxSizeAllowed){
				printPropertyInfo(pdfDocument, values, pIndex);
			}else {
				if (i == maxSizeAllowed) {
					additionalPageContent.add("ADDITIONAL PROPERTY PRIOR CARRIER INFORMATION : ");
					additionalPageContent.add(" ");
				}
				formatPropertyAsAdditionalPageInfo(values, pIndex);
			}
			
		}
	}
	/**
	 * @param pdfDocument
	 * @param values
	 * @param i
	 */
	private void printPropertyInfo(PdfDocument pdfDocument, String[] values, int i){
		int index =0;
		pdfDocument.printField(values[index],"UnderlyingInsurance.Property.Carrier." + (i+1));
		index++;
		pdfDocument.printField(values[index],"UnderlyingInsurance.Property.Policy." + (i+1));	
		index++;
		String effDt = values[index];
		index++;
		String expDt = values[index];

		
		pdfDocument.printField(effDt + "|" + expDt, "UnderlyingInsurance.Property.EffExpDate." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Property.Building." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Property.PersProperty." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Property.RatingMod." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Property.Premium." + (i+1));
		index++;
		pdfDocument.printField(values[index], "UnderlyingInsurance.Property.PolicyType." + (i+1));
	}
	
	/**
	 * @param values
	 * @param index
	 */
	private void formatPropertyAsAdditionalPageInfo(String[] values, int index){
		for (int seq=0; seq< values.length;seq++) {
			if (seq == 0) {
				additionalPageContent.add(CARRIER+ values[seq]);
			} else if (seq == 1) {
				additionalPageContent.add(POLICY +values[seq]);
			} else if (seq == 8) {
				additionalPageContent.add("  Policy Type            : " +values[seq]);
			} else if (seq == 2) {
				//intentionally left unimplemented
			} else if (seq == 4) {
				additionalPageContent.add("  Building Amt           : " +values[seq]);
			} else if (seq == 5) {
				additionalPageContent.add("  Pers Prop Amt          : " +values[seq]);
			} else if (seq == 6) {
				additionalPageContent.add(MOD_FACTOR +values[seq]);
			} else if (seq == 7) {
				additionalPageContent.add(TOT_PREM +values[seq]);
			} 
		}
		
		additionalPageContent.add(" ");
	}
	
	
	/**
	 * @param apData
	 * @param instance
	 * @return array of Strings
	 */
	public String[] getPropertyValues(APDataCollection apData, int instance){
		String[] values = new String[9];
		int index = 0;
		
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_INSURERNAME, instance, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYNUMBER, instance, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EFFECTIVEDT, instance, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_CONTRACTTERM_EXPIRATIONDT, instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd='BLDG'].Limit.FormatInteger", instance, "");
		index++;
		values[index] = apData.getFieldValue("CommlPolicy.OtherOrPriorPolicy.Coverage[CoverageCd='PP'].Limit.FormatInteger", instance, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_RATINGFACTOR, instance, "");
		index++;
		values[index] = apData.getFieldValue(COMMLPOLICY_OTHERORPRIORPOLICY_POLICYAMT_AMT, instance, "");	
		index++;
		values[index] = PRIOR;
		return values;
	}
	
	/**
	 * @param lobCd
	 * @return String
	 */
	private String getLineOfBusiness(String lobCd) {
		String line = "";
		
		if ("GARAG".equals(lobCd)){
			line = "Garage Dealer";
		}else if ("CGL".equals(lobCd)){
			line = "General Liability";
		}else if ("CFIRE".equals(lobCd)){
			line = "Commercial Fire";
		}else if ("CPKGE".equals(lobCd)){
			line = "Commercial Package";
		}else if ("CRIM".equals(lobCd) || "CRIME".equals(lobCd)){
			line = "Crime";
		}else {
			
			//refactored to reduce Cyclomatic complexity
			line = getLineOfBusinessContinued(lobCd, line);
	}
		return line;
	}
	/**
	 * @param lobCd
	 * @param line
	 * @return String
	 */
	private String getLineOfBusinessContinued(String lobCd, String line) {
		String lineTemp=line;
		if ("INMRC".equals(lobCd)){
			lineTemp = "Inland Marine";
}else if (PROPC.equals(lobCd)){
	lineTemp = "Commercial Property";
}else if ("BOP".equals(lobCd)){
	lineTemp = "Business Owner";
}else if (CUMBR.equals(lobCd) || UMBRC.equals(lobCd)){
	lineTemp = "Commercial Umbrella";
}else if ("EQPFL".equals(lobCd)){
	lineTemp = "Equipment Floater";	
}else if ("EDP".equals(lobCd)){
	lineTemp = "Electronic Data";		
}
		return lineTemp;
	}
}
