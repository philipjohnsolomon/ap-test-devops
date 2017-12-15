/**
 * May 20, 2005  @author Agencyport Insurance Services, Inc.
 */
package com.agencyport.shared.commercial;

import com.agencyport.data.apdata.RosterReader;

/**
 * This Custom Roster reader class provides the filter for the
 * CommlPolicy.OtherOrPriorPolicy aggregate based on the 
 * PolicyCd and LOBCd values.
 * eg: 
 * 	It is implementing the following logic.
 * 	dataFilter="CommlPolicy.OtherOrPriorPolicy.PolicyCd='Prior' 
 * 		&& CommlPolicy.OtherOrPriorPolicy.LOBCd='PROP'">   
 */
public abstract class CommlPolicyOtherOrPriorPolicyRoster extends RosterReader {
	
	/**
	 * The <code>PRIOR_POLICY_CD</code>is value of prior policy.
	 */
	protected static final String PRIOR_POLICY_CD = "Prior";
	

	
	/* (non-Javadoc)
	 * @see com.agencyport.data.apdata.RosterReader#passesFilterCriterion(int[])	
	 */
	@Override
	protected boolean passesFilterCriterion(int[] idArray){
		
		boolean passesBaseClassFilter = super.passesFilterCriterion(idArray);
		if ( !passesBaseClassFilter ){
			return passesBaseClassFilter;
		}
		String policyCd = data.getFieldValue("CommlPolicy.OtherOrPriorPolicy.PolicyCd",
				idArray, "");
		String lobCd = data.getFieldValue("CommlPolicy.OtherOrPriorPolicy.LOBCd",
				idArray, "");
		
		
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
	 * @return String
	 */
	protected abstract String getPolicySpecificLOBCd();	
	
	
}
