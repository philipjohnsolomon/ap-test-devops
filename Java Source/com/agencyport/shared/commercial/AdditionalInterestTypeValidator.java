/*
 * Created on Feb 6, 2007 by rnannapaneni AgencyPort Insurance
 */
package com.agencyport.shared.commercial;

import java.util.List;
import java.util.Properties;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.fieldvalidation.ValidationContext;
import com.agencyport.fieldvalidation.javascript.JavaScriptMethodBodyInfo;
import com.agencyport.fieldvalidation.javascript.JavaScriptMethodInvocationAndErrorInfo;
import com.agencyport.fieldvalidation.validators.BaseValidator;
import com.agencyport.fieldvalidation.validators.IValidator;
import com.agencyport.webshared.HTMLDataContainer;

/**
 * The AdditionalInterestTypeValidator class
 */
public class AdditionalInterestTypeValidator extends BaseValidator {

	/**
	 * The <code>defaultErrorMessageTemplate</code>
	 */
	private static final String DEFAULT_ERROR_MESSAGE_TEMPLATE = "";

    /**
     * @param validationContext
     * @param errorMessage
     */
    private void setErrorMessage(ValidationContext validationContext, String errorMessage){
    	validationContext.getValidationElement().setErrorMessageTemplate(errorMessage);
    }

	/* (non-Javadoc)
	 * @see com.agencyport.fieldvalidation.validators.IValidator#validate(com.agencyport.fieldvalidation.ValidationContext)
	 */
    /** 
     * {@inheritDoc}
     */ 
    @Override
	public boolean isValid(ValidationContext validationContext) {
		String errorMessage = "";
		HTMLDataContainer dataContainer = validationContext.getHtmlDataContainer();		
		String hLocationRef = dataContainer.getStringValue("SP.AdditionalInterest.@LocationRef");
		String hSublocationRef = dataContainer.getStringValue("SP.AdditionalInterest.@SubLocationRef");
		String hLOBCd = dataContainer.getStringValue("AdditionalInterest.AdditionalInterestInfo.LOBCd");
		String hNatureInterestCd = dataContainer.getStringValue("AdditionalInterest.AdditionalInterestInfo.NatureInterestCd");
		String hAttachLevel = dataContainer.getStringValue("SP.AdditionalInterest.Level");
		
		String mappedElement = getMappedElementName(hLOBCd);
		APDataCollection apData = validationContext.getApData();		
		if("default".equalsIgnoreCase(mappedElement)){
			errorMessage ="Selected Line Of Business (" + hLOBCd
					+ ") is currently not available.";
			setErrorMessage(validationContext, errorMessage);
			return false;	
		}
		
		AdditionalInterestLookupHelper lookupHelper = new AdditionalInterestLookupHelper();
		
		List<String> values = lookupHelper.getInterestTypeLinkTos(hNatureInterestCd, hLOBCd);
		
		// new UI design it should never happens
		if(values.isEmpty()){
			errorMessage ="Selected Nature of Interest Type (" + hNatureInterestCd
			+ ") is not applicable to the selected Line Of Business (" + hLOBCd + ").";
			setErrorMessage(validationContext, errorMessage);
			return false;	
		}
		

		return setapdata(validationContext, hLocationRef, hSublocationRef, hLOBCd, hNatureInterestCd, hAttachLevel, mappedElement, apData);
		
		
	}

	/**
	 * @param validationContext
	 * @param hLocationRef
	 * @param hSublocationRef
	 * @param hLOBCd
	 * @param hNatureInterestCd
	 * @param hAttachLevel
	 * @param mappedElement
	 * @param apData
	 * @return boolean
	 */
	private boolean setapdata(ValidationContext validationContext, String hLocationRef, String hSublocationRef, String hLOBCd, String hNatureInterestCd,
			String hAttachLevel, String mappedElement, APDataCollection apData) {
		String errorMessage;
		boolean linkToValid = false;
		if( ("LOC".equalsIgnoreCase(hAttachLevel) && hLocationRef.length() > 0 ) ||
			("SUBLOC".equalsIgnoreCase(hAttachLevel) && hSublocationRef.length() > 0 )	) {
			linkToValid = true;
		}else if("LOB".equalsIgnoreCase(hAttachLevel)){
			if(apData.getCount(mappedElement) <= 0){
				errorMessage ="Selected Line Of Business (" + hLOBCd
				+ ") is currently not available to attach the Additional Interest.";
				setErrorMessage(validationContext, errorMessage);
				return false;	
			}
			return true;
		}
		if(!linkToValid){
			errorMessage ="Selected Nature of Interet Type (" + hNatureInterestCd
			+ ") requires attached level (Location or Sublocation) information";
			setErrorMessage(validationContext, errorMessage);			
		}
		return linkToValid;
	}
	
	/**
	 * @param lobCode
	 * @return String
	 */
	private String getMappedElementName(String lobCode){
		AdditionalInterestLookupHelper lookupHelper = new AdditionalInterestLookupHelper();
		return lookupHelper.getMappedElementName(lobCode);
	}	
	
	@Override
	protected Properties getVariableMapForErrorMessageTemplate(
			ValidationContext validationContext) {
		return createStartingMapWithFieldLabelVariable(validationContext);
	}

	@Override
	protected String getDefaultErrorMessageTemplate(
			ValidationContext validationContext) {
		return DEFAULT_ERROR_MESSAGE_TEMPLATE;
	}
	
	@Override
	protected String getType() {
		return IValidator.CUSTOM_VALIDATOR_TYPE;
	}	

	@Override
	protected void appendJavaScriptValidationBody(JavaScriptMethodBodyInfo jsmi) {
		/*
		 * Intentionally left unimplemented
		 */
		
	}
	
	/* (non-Javadoc)
	 * @see com.agencyport.fieldvalidation.validators.IValidator#generateJavaScriptInfo(com.agencyport.fieldvalidation.ValidationContext)
	 */
	@Override
	public JavaScriptMethodInvocationAndErrorInfo generateJavaScriptInfo(ValidationContext validationContext) {		
		return null;
	}

	/* (non-Javadoc)
	 * @see com.agencyport.fieldvalidation.validators.IValidator#getJavaScriptMethodInfo()
	 */
	@Override
	public JavaScriptMethodBodyInfo getJavaScriptMethodInfo() {		
		return null;
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	protected String getJavaScriptMethodName() {
		return "validation_additionalInterestType";
	}
}
