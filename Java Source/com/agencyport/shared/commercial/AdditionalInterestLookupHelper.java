/*
 * Created on February 15, 2007 by rnannapaneni AgencyPort Insurance
 */
package com.agencyport.shared.commercial;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.agencyport.codelists.CodeListManager;
import com.agencyport.codelists.CodeMappingResult;
import com.agencyport.codelists.ICodeMapper;
import com.agencyport.logging.LoggingManager;

/**
 * The AdditionalInterestLookupHelper class
 */
public class AdditionalInterestLookupHelper {
	
	/**
	 * The <code>LOOKUP_LIST_DIR</code>directory with XML lookup files
	 */
	private static final String LOOKUP_LIST_DIR = "lookup_list_directory";
	/**
	 * The <code>AI_LOOKUP_LIST</code>is the name of the code list.
	 */
	private static final String AI_LOOKUP_LIST = "AILookupLists";
	/**
	 * The <code>AI_LINKTYPE_TO_ACORD_LIST</code>is the element name.
	 */
	private static final String AI_LINKTYPE_TO_ACORD_LIST = "aiLinkTypeToAcordElement";
	/**
	 * The <code>POSTFIX_INTEREST_LINK_MAP</code> is a String Constant.
	 */
	private static final String POSTFIX_INTEREST_LINK_MAP = "_InterestType_LinkMap";
	/**
	 * The <code>NOT_APPLICABLE</code> is a String Constant.
	 */
	private static final String NOT_APPLICABLE = "NA";
	/**
	 * The <code>LEVEL_MAP</code>is the element name.
	 */
	private static final String LEVEL_MAP = "levelMap";	
	/**
	 * The <code>logMessage</code> is a log message
	 */
	private static final String LOGMESSAGE="Unable to lookup the value: "; 
	/**
	 * The <code>logger</code>is our logger.
	 */
	
	private static final Logger LOGGER = 
		 LoggingManager.getLogger(AdditionalInterestLookupHelper.class.getPackage().getName());

	/**
	 * @param lobCode Line of Business Code
	 * @return String
	 */
	public String getMappedElementName(String lobCode){
		   return CodeListManager.getTargetValue(LOOKUP_LIST_DIR,
				   AI_LOOKUP_LIST, AI_LINKTYPE_TO_ACORD_LIST, lobCode);
	}
	
	/**
	 * @param interestType
	 * @param lobCode
	 * @return list
	 */
	public List<String> getInterestTypeLinkTos(String interestType, String lobCode){
		   List<String> values = new ArrayList<String>();
		   String mapname = lobCode + POSTFIX_INTEREST_LINK_MAP;
		   
		   String mvalue = null;
		   try{
			   mvalue = CodeListManager.getTargetValue(LOOKUP_LIST_DIR,
					   AI_LOOKUP_LIST, mapname, interestType);
		   }catch(Exception ex){
			   LOGGER.log(Level.FINE,LOGMESSAGE+ ex.toString(),ex);
		   }
		   
		   if(mvalue == null || mvalue.length() <= 0 || mvalue.equalsIgnoreCase(NOT_APPLICABLE)){
			   return values;
		   
		   }
		   StringTokenizer stk = new StringTokenizer(mvalue, ",");
		   while(stk.hasMoreElements()){
			   values.add((String)stk.nextElement());
		   }
		   return values;
	}
	
	/**
	 * @param lobCode
	 * @return list of Strings
	 */
	public List<String> getLOBSpecificInterestTypes(String lobCode){
		 List<String> values = new ArrayList<String>();
		 String mapname = "lobInterestTypeMap";
		   
		   String mvalue = null;
		   try{
			   mvalue = CodeListManager.getTargetValue(LOOKUP_LIST_DIR,
					   AI_LOOKUP_LIST, mapname, lobCode);
		   }catch(Exception ex){
			   LOGGER.log(Level.FINE,LOGMESSAGE+ ex.toString(),ex);			   
		   }
		   
		   if(mvalue == null || mvalue.length() <= 0 || mvalue.equalsIgnoreCase(NOT_APPLICABLE)){
			   return values;
		   }
		   
		   StringTokenizer stk = new StringTokenizer(mvalue, ",");
		   while(stk.hasMoreElements()){
			   values.add((String)stk.nextElement());
		   }
		   return values;
	}
	
	/**
	 * @param lobCode
	 * @param level
	 * @return list of Strings
	 */
	public List<String> getInterestTypes(String lobCode, String level){
		List<String> allTypesForLob = getLOBSpecificInterestTypes(lobCode);
		List<String> lobLevelAITypes = new ArrayList<String>();
		for( int i = 0 ; i < allTypesForLob.size(); i++){
			String interestType  = (String) allTypesForLob.get(i);
			List<String> values = getInterestTypeLinkTos(interestType, lobCode);
			if(values.contains(level)){
				lobLevelAITypes.add(interestType);
			}
		}
		return lobLevelAITypes;
	}
	
	/**
	 * @param levelCode
	 * @return String
	 */
	public String getLevelMappedValue(String levelCode){
		String mvalue = "";
		try{
			   mvalue = CodeListManager.getTargetValue(LOOKUP_LIST_DIR,
					   AI_LOOKUP_LIST, LEVEL_MAP, levelCode);
		}catch(Exception ex){
			LOGGER.log(Level.FINE,LOGMESSAGE+ ex.toString(),ex);			   
		}
		return mvalue;
		   
	}
	/**
	 * @param level
	 * @return String
	 */
	public String getReverseLevelMappedValue(String level){
		String mvalue = "";
		try{
			CodeListManager listManager = CodeListManager.getInstance(LOOKUP_LIST_DIR);
			ICodeMapper codeMapper = listManager.get(AI_LOOKUP_LIST, LEVEL_MAP);
			CodeMappingResult result =  codeMapper.getSourceValue(level);
			if(result.matched()){
				mvalue = result.getValue();
			}else{
				mvalue = "";
			}
			
		}catch(Exception ex){
			LOGGER.log(Level.FINE,LOGMESSAGE+ ex.toString(),ex);		   
		}
		return mvalue;
	}
	
	
	
	
}