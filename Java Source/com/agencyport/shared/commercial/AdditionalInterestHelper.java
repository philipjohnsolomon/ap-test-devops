/*
 * Created on Jan 11, 2007 by rnannapaneni AgencyPort Insurance
 */
package com.agencyport.shared.commercial;

import com.agencyport.data.DataManager;
import com.agencyport.domXML.Aggregate;
import com.agencyport.domXML.ElementPathExpression;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.domXML.Index;
import com.agencyport.html.elements.BaseElement;
import com.agencyport.shared.APException;
import com.agencyport.webshared.HTMLDataContainer;
import com.agencyport.widgets.SpecialFieldHelper;

/**
 * The AdditionalInterestHelper class
 */
public class AdditionalInterestHelper extends SpecialFieldHelper {
	
	/**
	 * The <code>ADDITIONAL_INTEREST_XPATH</code> is the  to Additional Interest.
	 */
	private static final String ADDITIONAL_INTEREST_XPATH = "AdditionalInterest";
	
	/**
	 * The <code>LOCATION_ELEMENT_NAME</code> is the Location
	 */
	private static final String LOCATION_ELEMENT_NAME = "Location";
	/**
	 * The <code>SUBLOCATION_ELEMENT_NAME</code> is the SubLocation
	 */
	private static final String SUBLOCATION_ELEMENT_NAME = "SubLocation";
	
	/**
	 * The <code>SP_ADDITIONALINTEREST_LOCATIONREF</code> is a String constant Field Entry in SPECIALFIELDS Array.
	 */
	private static final String SP_ADDITIONALINTEREST_LOCATIONREF ="SP.AdditionalInterest.@LocationRef";
	/**
	 * The <code>SP_ADDITIONALINTEREST_SUBLOCATIONREF</code> is a String constant Field Entry in SPECIALFIELDS Array.
	 */
	private static final String SP_ADDITIONALINTEREST_SUBLOCATIONREF ="SP.AdditionalInterest.@SubLocationRef";
	/**
	 * The <code>SP_ADDITIONALINTEREST_LEVEL</code> is a String constant Field Entry in SPECIALFIELDS Array.
	 */
	private static final String SP_ADDITIONALINTEREST_LEVEL ="SP.AdditionalInterest.Level";
	
	/**
	 * The <code>specialFields</code> is the array of Special Fields
	 */
	private static final FieldInfoEntry[] SPECIALFIELDS = {		
		new FieldInfoEntry(SP_ADDITIONALINTEREST_LOCATIONREF, ""),
		new FieldInfoEntry(SP_ADDITIONALINTEREST_SUBLOCATIONREF, ""),
		new FieldInfoEntry(SP_ADDITIONALINTEREST_LEVEL, ""),
		
	};
	
	
	/**
	 * Default constructor
	 */
	public AdditionalInterestHelper(){
		
	}
	
	/**
	 * @param dataManager
	 * @param htmlDataContainer
	 * @throws com.agencyport.shared.APException
	 */
	public AdditionalInterestHelper(DataManager dataManager,
			HTMLDataContainer htmlDataContainer) throws APException {
		super(dataManager, htmlDataContainer);		
	}

	@Override
	protected String createForeignAggregateXPath() {		
		return null;
	}

	@Override
	protected FieldInfoEntry[] getSpecialFieldInfo() {		
		return SPECIALFIELDS;
	}
	
	/**
	 * Over-written method, to provide the actual value 
	 */
	@Override
	protected void setSpecialDisplayFieldValue(BaseElement baseEl, String xpathToForeignAggregate, 
			FieldInfoEntry fieldInfoEntry){   

		int[] currentIdArray = indexMgr.getCurrentIdArray(ADDITIONAL_INTEREST_XPATH);	
		
		String idRef = 	 apData.getFieldValue(ADDITIONAL_INTEREST_XPATH + ".@IdRef", currentIdArray, "");
		String relatedType = apData.getFieldValue(ADDITIONAL_INTEREST_XPATH + ".RelatedType", currentIdArray, "");				
		String aiLOBCd =  apData.getFieldValue("AdditionalInterest.AdditionalInterestInfo.LOBCd", currentIdArray, "");
		
		String value = "";
		if(SP_ADDITIONALINTEREST_LOCATIONREF.equalsIgnoreCase(fieldInfoEntry.screenFieldId) ||
				SP_ADDITIONALINTEREST_SUBLOCATIONREF.equalsIgnoreCase(fieldInfoEntry.screenFieldId) )	{			
			value = getDisplayRelatedValues(aiLOBCd, relatedType, idRef);
		}
		if(SP_ADDITIONALINTEREST_LEVEL.equalsIgnoreCase(fieldInfoEntry.screenFieldId)){
			value = getDisplayRelatedLevel(relatedType);
		}
		baseEl.setValue(value);
	}
	
	/**
	 * @param lobCode is Line of Business Code
	 * @param relatedType is relatedType
	 * @param cIdRef
	 * @return String
	 */
	private String getDisplayRelatedValues(String lobCode, String relatedType, String cIdRef){
		 String retValue = "";
		 if(relatedType.length() <= 0 ){
			   return retValue;
		 }	  
		 
		 if(relatedType.equalsIgnoreCase(LOCATION_ELEMENT_NAME)){
			 retValue = cIdRef;
		 }else if(relatedType.equalsIgnoreCase(SUBLOCATION_ELEMENT_NAME)){
			 retValue = cIdRef;
		 }
		 return retValue;
	}
	
	/**
	 * @param relatedType
	 * @return String
	 */
	private String getDisplayRelatedLevel(String relatedType){
		String retValue = "";
		 if(relatedType.length() <= 0 ){
			   return retValue;
		 }	  
		 AdditionalInterestLookupHelper aiHelper = new AdditionalInterestLookupHelper();
		 retValue = aiHelper.getReverseLevelMappedValue(relatedType);
		 if(retValue.length() <= 0){
			 retValue = "LOB";
		 }
		 return retValue;
	}
	
	
   /**
    * Updates the elements on the foreign aggregate from the screen values.
    */
	@Override
   public void updateForeignAggregate(){	
	   String lobCode = htmlDataContainer.getStringValue("AdditionalInterest.AdditionalInterestInfo.LOBCd");	   
	   if(lobCode.length() <= 0){
		   lobCode = apData.getFieldValue("CommlPolicy.LOBCd", "");
	   }
	   String attachLevel = htmlDataContainer.getStringValue(SP_ADDITIONALINTEREST_LEVEL);
	   AIInterestLinkValue interestValue = deriveInterestValue(lobCode, attachLevel);
	   int[] currentIdArray = indexMgr.getCurrentIdArray(ADDITIONAL_INTEREST_XPATH);	   
	   
	   apData.setFieldValue(ADDITIONAL_INTEREST_XPATH + ".@IdRef", currentIdArray, interestValue.idRef);
	   apData.setFieldValue(ADDITIONAL_INTEREST_XPATH + ".RelatedType", currentIdArray, interestValue.relatedType);  	  
	  
   }  
    
  
   /**
    * This method returns the AIInterestLinkValue object, contains all the values related to
    * update the AI aggregate.
 * @param lobCode is Line of Business Code
 * @param attachLevel Level where the Interest is attached to
 * @return object of AIInterestLinkValue
    */
   private AIInterestLinkValue deriveInterestValue(String lobCode, String attachLevel){
	   String relatedType = "";	 
	   
	   AIInterestLinkValue interestValue = new AIInterestLinkValue();	   
	   AdditionalInterestLookupHelper aiHelper = new AdditionalInterestLookupHelper();
	   relatedType = aiHelper.getLevelMappedValue(attachLevel);
	   if("LOB".equalsIgnoreCase(attachLevel)){
		   relatedType = aiHelper.getMappedElementName(lobCode);
	   }
	   interestValue.relatedType = relatedType;
	   interestValue.level = attachLevel;
	   if(interestValue.relatedType.equalsIgnoreCase(LOCATION_ELEMENT_NAME) ){
		   interestValue.idRef = htmlDataContainer.getStringValue(SP_ADDITIONALINTEREST_LOCATIONREF);
	   }else if(interestValue.relatedType.equalsIgnoreCase(SUBLOCATION_ELEMENT_NAME) ){
		   interestValue.idRef = htmlDataContainer.getStringValue(SP_ADDITIONALINTEREST_SUBLOCATIONREF);
	   }else{
		   if(interestValue.relatedType.length() > 0 && apData.getCount(interestValue.relatedType) > 0 ){
			   interestValue.idRef = apData.getFieldValue(interestValue.relatedType + ".@id", "");
		   }		  
	   }
	   return interestValue;
   }
   
   /**
 * The AIInterestLinkValue class
 */
 static class AIInterestLinkValue {
	   /**
	 * The <code>level</code>Level where the Interest is attached to
	 */
	private String level = ""; 
	   /**
	 * The <code>relatedType</code>actual element name, which goes in to AI aggregate
	 */
	private String relatedType = "";
	   /**
	 * The <code>idRef</code>related idRef
	 */
	  private String idRef = "";
   }
 
   
   /**
    * Deletes the Remarks Text Aggregate that is related to that Additional Interest Information
    */
   @Override
   public void deleteForeignAggregate(){
	   
	   //Get the id array index for the Additional Interest Aggregate based on the current roaster item  
	   int[] currentIdArrayAdditionalInterest = indexMgr.getCurrentIdArray(ADDITIONAL_INTEREST_XPATH);
	   
	   //Get the additional interest id from the data
	   String additionalInterestId =  apData.getFieldValue(ADDITIONAL_INTEREST_XPATH + ".@id", currentIdArrayAdditionalInterest, "");	   
	   
	   if (additionalInterestId.length() > 0 ){
		  
		   String remarksTextXPath = "RemarkText[@apType='AdditionalInterestDesc' && @IdRef='" +
		   	additionalInterestId + "']";
		   
		   // remove the RemarksText
		   if (apData.getCount(remarksTextXPath) > 0 ){
			   apData.deleteElement(remarksTextXPath);
		   }
		      
	   }
	 }
   
   /**
	 * recover the elements on the foreign aggregate .
	 * In this case Additional Interest Item Description, which will be RemarksText
	 */
    @Override
	public void recoverForeignAggregate(ElementPathExpression recoverAggregateXPath){

		int save = apData.changeViewType(indexMgr.getViewTypeForIndex());
		
		try{
			dataManager.getIndexManager().setViewTypeForIndex(IXMLConstants.VIEW_ORIGINAL_DOCUMENT);
			// Assumption that the last entry made into the index manager
	    	// is the one that we want to recover.
	    	Index entry = indexMgr.getLastEntry();    	
	    	// Switch to the document view for which this index entry applies -
	    	// Typically this should be the original document view
	    	apData.changeViewType(indexMgr.getViewTypeForIndex());
	    	// 	Getting the recovered location and sublocation ref.
			String currentAIId = apData.getFieldValue(ADDITIONAL_INTEREST_XPATH + ".@id", entry.getIdArray(),"");
			
			dataManager.getIndexManager().setViewTypeForIndex(IXMLConstants.VIEW_CURRENT_DOCUMENT);
			apData.changeViewType(IXMLConstants.VIEW_CURRENT_DOCUMENT);
			if(apData.getCount(ADDITIONAL_INTEREST_XPATH + "[@id='" + currentAIId + "']")<=0){				
				return;
			}
			
			apData.changeViewType(IXMLConstants.VIEW_ORIGINAL_DOCUMENT);
			//Recover SubLocation
			ElementPathExpression targetXpath = new ElementPathExpression("RemarkText[@IdRef='"+ currentAIId +"']");
			int[] array = apData.normalizeXPathExpressionToIdArray(targetXpath,null);
			Aggregate remarksAgg = new Aggregate();
			remarksAgg.acquireFrom(apData, "RemarkText", array);
			remarksAgg = (Aggregate) remarksAgg.clone();

			apData.changeViewType(IXMLConstants.VIEW_CURRENT_DOCUMENT);
	    	
			remarksAgg.appendTo(apData, "", null);			
			
		}finally{
			dataManager.getIndexManager().setViewTypeForIndex(save);
		    apData.changeViewType(save);
		}	
	}
	
}
