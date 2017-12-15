package com.agencyport.shared.pdf;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.logging.LoggingManager;
import com.agencyport.shared.APException;

/**
 * This class calls get the Loss History data from AP data collection remarks element.
 * Loss history information is created as List for assign to OverflowPageControl
 *
 *
 */
public class PropertyLossHistoryReport {
	private static Logger logger = 
		LoggingManager.getLogger(PropertyLossHistoryReport.class.getPackage().getName());
	    
   /**
    * Prints the LossHistory on the additional PDF pages. 
    * 
    * Sample XML from Loss History:
    * 	<RemarkText IdRef="A73BDE4C57EFF0BD42BBE77919F76941CA">&lt;![CDATA[ &lt;?xml version="1.0" encoding="UTF-8"?&gt;
	*		&lt;PropertyLossHistorySvcRs&gt; &lt;meta-policy&gt;&lt;LOBCode&gt;HOME&lt;/LOBCode&gt;&lt;TransactionID&gt;home&lt;/TransactionID&gt;&lt;ServiceRequestID&gt;ACE8395541307FA41EFA87DA1EB00ECF0A&lt;/ServiceRequestID&gt;&lt;ServiceRequestDateTime&gt;Thu Oct 06 12:17:45 EDT 2005&lt;/ServiceRequestDateTime&gt;&lt;PageID&gt;policySummary&lt;/PageID&gt;&lt;UserID&gt;pegaagent1&lt;/UserID&gt;&lt;Status&gt;success&lt;/Status&gt;&lt;AgencyID&gt;100000&lt;/AgencyID&gt;&lt;/meta-policy&gt;&lt;PartyInfo id="AB562271C76C888E0ED022A2C7176F47FA"&gt;&lt;InsuredOrPrincipalRoleCd&gt;Insured&lt;/InsuredOrPrincipalRoleCd&gt;&lt;NameInfo&gt;&lt;PersonName&gt;&lt;Surname&gt;Martin&lt;/Surname&gt;&lt;GivenName&gt;Sreenivas&lt;/GivenName&gt;&lt;OtherGivenName /&gt;&lt;/PersonName&gt;&lt;/NameInfo&gt;&lt;PersonInfo&gt;&lt;GenderCd /&gt;&lt;BirthDt&gt;1978-01-08&lt;/BirthDt&gt;&lt;MaritalStatusCd&gt;M&lt;/MaritalStatusCd&gt;&lt;/PersonInfo&gt;&lt;Addr id="A73BDE4C57EFF0BD42BBE77919F76941CA"&gt;&lt;AddrTypeCd&gt;RiskLocationAddress&lt;/AddrTypeCd&gt;&lt;Addr1&gt;1900 Crown Colony drive&lt;/Addr1&gt;&lt;Addr2 /&gt;&lt;City&gt;Quincy&lt;/City&gt;&lt;StateProvCd&gt;MA&lt;/StateProvCd&gt;&lt;PostalCode&gt;012121&lt;/PostalCode&gt;&lt;/Addr&gt;&lt;Addr id="AF7BBB8FD006357129ABEEF0F3D572F1FA"&gt;&lt;AddrTypeCd&gt;PreviousAddress&lt;/AddrTypeCd&gt;&lt;Addr1&gt;44 montvale ave&lt;/Addr1&gt;&lt;Addr2 /&gt;&lt;City&gt;Woburn&lt;/City&gt;&lt;StateProvCd&gt;MA&lt;/StateProvCd&gt;&lt;PostalCode&gt;01801&lt;/PostalCode&gt;&lt;/Addr&gt;&lt;/PartyInfo&gt;&lt;PartyInfo id="AE81F29C1683339E51195780C3D241207A"&gt;&lt;InsuredOrPrincipalRoleCd&gt;Coinsured&lt;/InsuredOrPrincipalRoleCd&gt;&lt;NameInfo&gt;&lt;PersonName&gt;&lt;Surname&gt;Martin&lt;/Surname&gt;&lt;GivenName&gt;Co app&lt;/GivenName&gt;&lt;OtherGivenName /&gt;&lt;/PersonName&gt;&lt;/NameInfo&gt;&lt;PersonInfo&gt;&lt;GenderCd /&gt;&lt;BirthDt&gt;1979-01-09&lt;/BirthDt&gt;&lt;MaritalStatusCd&gt;M&lt;/MaritalStatusCd&gt;&lt;/PersonInfo&gt;&lt;/PartyInfo&gt;&lt;PropertyLossHistoryHeader id="ihub2436" idref="A73BDE4C57EFF0BD42BBE77919F76941CA"&gt;&lt;NumberOfMatches&gt;2&lt;/NumberOfMatches&gt;&lt;SearchDate&gt;08/02/2005&lt;/SearchDate&gt;&lt;/PropertyLossHistoryHeader&gt;&lt;PropertyLossHistory id="ihub1167" idref="A73BDE4C57EFF0BD42BBE77919F76941CA"&gt;&lt;BusinessName /&gt;&lt;FirstInsName&gt;MARTIN                  DAVID        &lt;/FirstInsName&gt;&lt;FirstInsGender /&gt;&lt;FirstInsSSN /&gt;&lt;FirstInsDOB /&gt;&lt;SecondInsName&gt;                                     &lt;/SecondInsName&gt;&lt;SecondInsGender /&gt;&lt;SecondInsSSN /&gt;&lt;SecondInsDOB /&gt;&lt;LossLocation&gt;12345  W LOOP RD                   FANTASY ISLAND      IL607504312&lt;/LossLocation&gt;&lt;CurrentAddress&gt;12345  W LOOP RD                   FANTASY ISLAND      IL607504312&lt;/CurrentAddress&gt;&lt;LossDate&gt;10222002&lt;/LossDate&gt;&lt;MatchType&gt;A1&lt;/MatchType&gt;&lt;LossAmount&gt;$811&lt;/LossAmount&gt;&lt;ClaimNumber&gt;12312355001418&lt;/ClaimNumber&gt;&lt;ClaimType&gt;WIND&lt;/ClaimType&gt;&lt;CauseOfLoss&gt;WIND&lt;/CauseOfLoss&gt;&lt;CatastropheNum /&gt;&lt;LossCarrier&gt;TEXAS SELECT LLOYDS&lt;/LossCarrier&gt;&lt;ClaimStatus&gt;C&lt;/ClaimStatus&gt;&lt;PolicyType&gt;HO&lt;/PolicyType&gt;&lt;PolicyNumber&gt;TXA000521800&lt;/PolicyNumber&gt;&lt;/PropertyLossHistory&gt;&lt;PropertyLossHistory id="ihub5758" idref="A73BDE4C57EFF0BD42BBE77919F76941CA"&gt;&lt;BusinessName /&gt;&lt;FirstInsName&gt;MARTIN                  DAVID        &lt;/FirstInsName&gt;&lt;FirstInsGender /&gt;&lt;FirstInsSSN /&gt;&lt;FirstInsDOB /&gt;&lt;SecondInsName&gt;                                     &lt;/SecondInsName&gt;&lt;SecondInsGender /&gt;&lt;SecondInsSSN /&gt;&lt;SecondInsDOB /&gt;&lt;LossLocation&gt;12345  W LOOP RD                   FANTASY ISLAND      IL607504312&lt;/LossLocation&gt;&lt;CurrentAddress&gt;12345  W LOOP RD                   FANTASY ISLAND      IL607564312&lt;/CurrentAddress&gt;&lt;LossDate&gt;10222002&lt;/LossDate&gt;&lt;MatchType&gt;A1&lt;/MatchType&gt;&lt;LossAmount&gt;$0&lt;/LossAmount&gt;&lt;ClaimNumber&gt;12312355001418&lt;/ClaimNumber&gt;&lt;ClaimType&gt;LIABILITY&lt;/ClaimType&gt;&lt;CauseOfLoss&gt;LIAB-PD OTHER&lt;/CauseOfLoss&gt;&lt;CatastropheNum /&gt;&lt;LossCarrier&gt;TEXAS SELECT LLOYDS&lt;/LossCarrier&gt;&lt;ClaimStatus&gt;C&lt;/ClaimStatus&gt;&lt;PolicyType&gt;HO&lt;/PolicyType&gt;&lt;PolicyNumber&gt;TXA000521800&lt;/PolicyNumber&gt;&lt;/PropertyLossHistory&gt;&lt;/PropertyLossHistorySvcRs&gt;
	*		]]</RemarkText>
    * 
    * @param overflowPageControl  OverflowPageControl reference
    * @param apData		APDataCollection of working policy
    * @param remarksIdRef	ReamarkText IdRef
    * @throws APException
    */
	public static void process(OverflowPageControl overflowPageControl, 
			APDataCollection apData, String remarksIdRef) throws APException {
			List losshistList = new ArrayList();	
			losshistList = getHistoryLossList(apData, remarksIdRef);
			for (int i =0; i< losshistList.size(); i++) {
				overflowPageControl.printLine((String) losshistList.get(i));
			}
			overflowPageControl.flush();
		}
	private static List getHistoryLossList(APDataCollection apData,String remarksIdRef){
		ArrayList losshistList = new ArrayList();	
		//String remarksIdRef = apData.getFieldValue("Location[Addr.AddrTypeCd='PhysicalRisk'].Addr.@id", "");
		// String remarksIdRef = apData.getFieldValue(refIdPath, "");
		if(remarksIdRef.length() <= 0) 
			return losshistList ; 
		String path = "RemarkText[@IdRef=\"" + remarksIdRef + "\"]" ; 
		String remark = apData.getFieldValue(path, ""); 
		losshistList.add(" ");
		losshistList.add("PROPERTY LOSS HISTORY REPORT: ");
		losshistList.add("----------------------------- ");
		losshistList.add(" ");
		int cdataIndex = remark.indexOf("CDATA[");
		int beginIndex = 0;
		int lastIndex = remark.length();
		if(cdataIndex>0){
			beginIndex = cdataIndex + 6;
			lastIndex = remark.length()-2;
		}
		if(lastIndex <=(beginIndex+2)){
			// Added code to implement team trak 1258 - property loss history.
//			losshistList.add("Clean");
//			losshistList.add(" ");
//			losshistList.add(" ");
			return losshistList;	  
		}	
			String lossHistXml = (remark.substring(beginIndex,lastIndex)).trim();
		   SAXBuilder saxBuilder = new SAXBuilder();
		   Document doc = null;
		   try
		   {
			   doc = saxBuilder.build(new StringReader(lossHistXml));
			   Element rootElement = doc.getRootElement();
			   List childrenList = rootElement.getChildren("PropertyLossHistory");
			   for(int j=0; j < childrenList.size(); j++){
				Element element = (Element)childrenList.get(j);
				//losshistList.add("  ");
				losshistList.add("Property Loss History - "+(j+1));
				losshistList.add(" ");
				losshistList.add("Match Basis : " + getChildText(element, "MatchType"));
				losshistList.add("Insured Name: " +  getChildText(element, "FirstInsName"));
				//losshistList.add(" ");
				losshistList.add("Loss Location: " +  getChildText(element, "LossLocation"));
				losshistList.add("Current Address : " +  getChildText(element, "CurrentAddress"));
				losshistList.add("Loss Date : " + getChildText(element, "LossDate"));
				losshistList.add("Loss Amount : " + getChildText(element, "LossAmount"));
				losshistList.add("Loss Type : " + getChildText(element, "ClaimType"));
				losshistList.add("Policy Type : " + getChildText(element, "PolicyType"));
				losshistList.add("Loss Caused : " + getChildText(element, "CauseOfLoss"));
				losshistList.add("Carrier : " + getChildText(element, "LossCarrier"));
				losshistList.add("Policy Number : " + getChildText(element, "PolicyNumber"));
				losshistList.add("Claim Status: " + getChildText(element, "ClaimStatus"));
				losshistList.add("Claim Number : " +  getChildText(element, "ClaimNumber"));	
				losshistList.add("  ");		   
		   }

		   }catch(Exception ex){
			   logger.severe(ex.toString());
		   }
		   return losshistList;	   
		}
		
		private static String getChildText(Element element, String childName){
			String value =  "";
			if(element != null)
				value = element.getChildText(childName);
				
			if(value == null) value = "";
			
			return value;
		}
	}