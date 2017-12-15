/**
 * May 20, 2005  @author Agencyport Insurance Services, Inc.
 */
package com.agencyport.shared.personal;

import com.agencyport.data.apdata.RosterReader;

/**
 * This Custom Roster reader class provides the filter for the
 * PersPolicy.OtherOrPriorPolicy aggregate based on the 
 * PolicyCd and LOBCd vlaues.
 * eg: 
 */
public abstract class PersPolicyOtherOrPriorPolicyRoster extends RosterReader {
	
	/**
	 * The <code>LOB_CD</code>is line of business code
	 */
	private static final String LOB_CD = "PersPolicy.OtherOrPriorPolicy.LOBCd";

	/**
	 * The <code>POLICY_CODE</code>is policy code.
	 */
	private static final String POLICY_CODE = "PersPolicy.OtherOrPriorPolicy.PolicyCd";

	/**
	 * The <code>PRIOR_POLICY_CD</code>is prior policy code
	 */
	protected static final String PRIOR_POLICY_CD = "Prior";
	
	/**
	 * The <code>priorPolicyLOBCd</code> 
	 */
	//protected String priorPolicyLOBCd = "";
	
	/* (non-Java doc)
	 * @see com.agencyport.data.apdata.RosterReader#passesFilterCriterion(int[])	
	 */
	@Override
	protected boolean passesFilterCriterion(int[] idArray){
		
		boolean passesBaseClassFilter = super.passesFilterCriterion(idArray);
		if ( !passesBaseClassFilter ){
			return passesBaseClassFilter;
		}
		String policyCd = data.getFieldValue(POLICY_CODE, idArray, "");
		String lobCd = data.getFieldValue(LOB_CD, idArray, "");
		//priorPolicyLOBCd = lobCd;
		
		return policyCd.equals(getPolicyCd()) && lobCd.equals(getPolicySpecificLOBCd());
		
	}
	
	/**
	 * Returns the CommlPolicy.OtherOrPriorPolicy.PolicyCd value, which is being used in filter  
	 * @return String
	 */
	protected String getPolicyCd(){
		return PRIOR_POLICY_CD;
	}
	
	/**
	 * Returns the CommlPolicy.OtherOrPriorPolicy.LOBCd value, which is being used in filter  
	 * @return  abstract method String
	 */
	protected abstract String getPolicySpecificLOBCd();	
	
	
}
