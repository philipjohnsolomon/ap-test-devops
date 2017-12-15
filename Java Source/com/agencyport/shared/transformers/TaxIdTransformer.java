package com.agencyport.shared.transformers;

import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.jdom2.Element;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.transform.APDataCollectionTransformationException;
import com.agencyport.domXML.transform.IAPDataCollectionTransformer;
import com.agencyport.domXML.transform.TargetFormat;
import com.agencyport.fieldvalidation.validators.BaseValidator;

public class TaxIdTransformer implements IAPDataCollectionTransformer{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4376401542072138416L;

	@Override
	public void transform(APDataCollection dataCollection,
			TargetFormat targetFormat, Element customParameters)
			throws APDataCollectionTransformationException {

		if (targetFormat.equals(TargetFormat.ACORDSimplified)) {
        	transformToACORDSimplified(dataCollection);
        }
		
		
	}
	
	  /**
     * Handle the specific transformations needed for upload cases.
     * @param apData
     * @throws APDataCollectionTransformationException
     */
    private void transformToACORDSimplified(APDataCollection apData) throws APDataCollectionTransformationException {
    		
    			// updates Tax Id based on format of the value.
    			updateTaxIdType(apData);
        
    }
	public void updateTaxIdType(APDataCollection apData) {

		String ssnRegex = "^(?!000|666)[0-8][0-9]{2}-(?!00)[0-9]{2}-(?!0000)[0-9]{4}$";
		String taxId = apData.getFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.NameInfo.TaxIdentity.TaxId", "");
		if(!BaseValidator.checkIsEmpty(taxId)){
			if(Pattern.matches(ssnRegex, taxId)){
				apData.setFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.NameInfo.TaxIdentity[TaxIdTypeCd='FEIN'].TaxIdTypeCd", "SSN");
			}else if(StringUtils.countMatches(taxId, "-")==0 && taxId.length()==9){
				taxId = taxId.substring(0, 2) + "-" + taxId.substring(2, taxId.length());
				apData.setFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].GeneralPartyInfo.NameInfo.TaxIdentity[TaxIdTypeCd='FEIN'].TaxId", taxId);
			}
		}
		
	}

}
