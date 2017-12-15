/*
 * Created on Jan 11, 2007 by AgencyPort Insurance
 */
package com.agencyport.shared.commercial;

import java.util.List;
import java.util.logging.Logger;

import com.agencyport.data.DataManager;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.dynamiclists.DynamicListField;
import com.agencyport.dynamiclists.DynamicListTemplate;
import com.agencyport.dynamiclists.IDynamicListBuilder;
import com.agencyport.html.optionutils.OptionEntry;
import com.agencyport.html.optionutils.OptionList;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.logging.LoggingManager;
import com.agencyport.shared.APException;
import com.agencyport.shared.LoggableStackTrace;

/**
 * This class generates the Line Of Business code options based on
 * the Policy level LOBCd. Intention to reuse page across commercial
 * mono lines and package applications.
 */
public class LobCodeSelectiontBuilder implements IDynamicListBuilder {
	
	  /**
	 * The <code>LOGGER</code> is my logger
	 */
	private static final Logger LOGGER = 
		  LoggingManager.getLogger(LobCodeSelectiontBuilder.class.getPackage().getName());
	  
	  /**
	 * The <code>CPP_LOB_OPTIONS</code>key values in cpp line of business optionlist.
	 */
	private static final OptionList.Key CPP_LOB_OPTIONS = new OptionList.Key("xmlreader:cppCodeListRef.xml:cppSupportedLOBCodes");
	  /**
	 * The <code>COMML_LOB_OPTIONS</code>key values in comml line of business optionlist.
	 */
	private static final OptionList.Key COMML_LOB_OPTIONS = new OptionList.Key("xmlreader:codeListRef.xml:commlLineOfBusinessCodes");
	  
	  /**
	   * Defines the Umbrella Policy Type Code
	   */
	  private String policyLevelLobCdUmbrella="UMBRL";
	
	  /**
	   * Defines the Comml Umbrella - Excess Policy Type Cd 
	   */
	  private String policyLevelLobCdExcess="EXLIA";	
	
	  /**
	   * Defines the Comml Umbrella Other Or Prior Policy Lob Cd
	   */
	  
	private String policyLevelLobCdCommlUmbrella="UMBRC";
	  
	/* (non-Javadoc)
	 * @see com.agencyport.dynamiclists.IDynamicListBuilder#generate(com.agencyport.data.DataManager, com.agencyport.dynamiclists.DynamicListTemplate, java.util.List)
	 */
	
	/**
	 * Generate the Lob code options 
	 */
	@Override
	public OptionList generate(DataManager dataManager, DynamicListTemplate template, OptionList existingListToUpdate) {
		try {
			APDataCollection apData = dataManager.getAPDataCollection();
			DynamicListField [] fieldList = template.getFieldList();
			
			String lobCode = "";			
			if( fieldList.length > 0){
				lobCode = apData.getFieldValue(fieldList[0].getValue(), "");
			}else{
				lobCode = apData.getFieldValue("CommlPolicy.LOBCd", "");
			}
			
			if(policyLevelLobCdUmbrella.equals(lobCode) || 
					policyLevelLobCdExcess.equals(lobCode)){
				lobCode = policyLevelLobCdCommlUmbrella;
			}
			
			if(lobCode.length() <= 0 || "CPKGE".equalsIgnoreCase(lobCode)){				
				OptionList optionList = OptionsMap.getSingleList(CPP_LOB_OPTIONS); 				
				existingListToUpdate.addAll(optionList);			
			}else{			 
				String lobDesc = OptionsMap.lookupDisplayValue(lobCode, COMML_LOB_OPTIONS, lobCode, dataManager);		
				OptionEntry entry = new OptionEntry(lobCode, lobDesc);
				existingListToUpdate.add (entry);
			}
		}catch (APException apEx) {
			LOGGER.severe(LoggableStackTrace.getStackTrace(apEx));
			LOGGER.severe("Encountered problem in LobCodeSelectiontBuilder.generate(): "
					+ apEx.getMessage());
			throw new RuntimeException(apEx.getMessage());//NOSONAR
		}
		return existingListToUpdate;		
	}
	
	@Override
	public String getDefaultValue(DataManager dataManager, DynamicListTemplate template, OptionList displayList){
		List<String> selectOne = OptionsMap.getSingleList("xmlreader:codeListRef.xml:selectOne"); 	
		
		if(displayList.contains(selectOne.get(0)) ){
			return (String)(selectOne.get(0));		
		}
		if (displayList.isEmpty()) {
			OptionEntry entry = displayList.get(0);
			return entry.getValue();
		} else {
			return null;
		}
	
	}
	

}
