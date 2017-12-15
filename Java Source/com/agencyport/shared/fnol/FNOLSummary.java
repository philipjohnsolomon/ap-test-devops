/**
 * Jun 17, 2005  @author Agencyport Insurance Services, Inc.
 */
package com.agencyport.shared.fnol;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.logging.LoggingManager;
import com.agencyport.shared.APException;
import com.agencyport.shared.LoggableStackTrace;
import com.agencyport.shared.apps.common.utils.NumberFormatter;
import com.agencyport.shared.pdf.DataConverter;
import com.agencyport.utils.APDate;
import com.agencyport.utils.AppProperties;


/**
 * This bean holds the Policy related data accross LOB's
 */
public class FNOLSummary {
	  /**
	 * The <code>LOGGER</code>IS MY logger
	 */
	private static final Logger LOGGER = LoggingManager.getLogger(
	  		FNOLSummary.class.getPackage().getName());
	  
	  /**
	 * The <code>MMDDYYYYWSLASHES</code>
	 */
	
	
	private static final DateTimeFormatter MMDDYYYYWSLASHES = DateTimeFormat.forPattern("MM/dd/yyyy");
	/*
	 * WorkItemId - Reference to the workItemId
	 */
	/**
	 * The <code>workItemId</code>
	 */
	private String workItemId;
	
	/**
	 * Applicant name
	 */
	private String insured = ""; 
	
	/**
	 * The <code>generalRemarks</code>
	 */
	private String generalRemarks = "";
	
	/**
	 * Policy effective date
	 */
	protected String effectiveDate;
	
	/**
	 * Policy expiration date
	 */
	protected String expirationDate;
	
	/**
	 * Agency Name - Agent's default Agency name
	 */
	protected String agencyName;
	
	/**
	 * Agent producer code
	 */
	protected String producerCode;
	
	/**
	 * CustomerId if any exist at Agency 
	 */
	protected String agencyCustomerId;
	
	/**
	 * WorkItem status description
	 */
	protected String workItemStatus;
	
	/**
	 * The <code>workItemStatusId</code>
	 */
	protected int workItemStatusId;
	
	
	/**
	 * The <code>submissionDate</code>
	 */
	protected APDate submissionDate = null;

	/**
	 * WorkItem Prefix based on Lob ex: WorkersComp is WC-
	 */
	protected String workItemPrefix = "";
	
	/**
	 * DownPayment Type
	 */
	private String downPaymentType = "";
	
	/**
	 * DownPayment Amount
	 */
	private String downPaymentAmount = "";
	
	/**
	 * The <code>electronicPaymentUrl</code>
	 */
	private String  electronicPaymentUrl;
	
	/**
	 * Agency Id
	 */
	private String agencyId = "";
	
	/**
	 * The <code>validateAgencyId</code>
	 */
	private String validateAgencyId = "";
	
	
	/**
	 * FNOL Loss variables
	 */
	private String lossDate = "";
	/**
	 * The <code>lossTime</code>
	 */
	private String lossTime = "";
	/**
	 * The <code>lossLocation</code>
	 */
	private String lossLocation = "";
	/**
	 * The <code>lossClaimType</code>
	 */
	private String lossClaimType = "";
	/**
	 * The <code>lossProbableAmount</code>
	 */
	private String lossProbableAmount = "";
	/**
	 * The <code>lossDescription</code>
	 */
	private String lossDescription = "";
	/**
	 * The <code>lossReportedBy</code>
	 */
	private String lossReportedBy = "";
	/**
	 * The <code>lossReportedTo</code>
	 */
	private String lossReportedTo = "";
	
	/**
	 * FNOL Contact variables
	 */
	private String contactName = "";
	/**
	 * The <code>contactAddress</code>
	 */
	private String contactAddress = "";
	/**
	 * The <code>contactPrimaryPhone</code>
	 */
	private String contactPrimaryPhone = "";
	/**
	 * The <code>contactPrimaryEmail</code>
	 */
	private String contactPrimaryEmail = "";
	/**
	 * The <code>contactWhenTo</code>
	 */
	private String contactWhenTo = "";

	/**
	 * The <code>insuredLocationCode</code>
	 */
	private String insuredLocationCode;

	/**
	 * The <code>lossReportNumber</code>
	 */
	private String lossReportNumber;

	/**
	 * The <code>policeOrFireDeptContacted</code>
	 */
	private String policeOrFireDeptContacted;
	
	/**
	 * @return Returns the workItemStatusId.
	 */
	public int getWorkItemStatusId() {
		return workItemStatusId;
	}
	/**
	 * @return Returns the submissionDate.
	 */
	public APDate getSubmissionAPDate() {
		return submissionDate;
	}
	/**
	 * @return Returns the submissionDate.
	 */
	public String  getDisplaySubmissionDate() {
		if(submissionDate != null){
			
			return MMDDYYYYWSLASHES.print(new DateTime(submissionDate.getUtilDate()));
		}
		return "";
	}
	/**
	 * @return Returns the agencyCustomerId.
	 */
	public String getAgencyCustomerId() {
		return agencyCustomerId;
	}
	/**
	 * @param agencyCustomerId The agencyCustomerId to set.
	 */
	public void setAgencyCustomerId(String agencyCustomerId) {
		this.agencyCustomerId = agencyCustomerId;
	}
	/**
	 * @return Returns the agencyName.
	 */
	public String getAgencyName() {
		return agencyName;
	}
	/**
	 * @param agencyName The agencyName to set.
	 */
	public void setAgencyName(String agencyName) {
		this.agencyName = agencyName;
	}
	/**
	 * @return Returns the effectiveDate.
	 */
	public String getEffectiveDate() {
		if(effectiveDate == null || effectiveDate.length() <= 0){
			return "";
		}
		return DataConverter.standardDateFormat(this.effectiveDate);
	}	
	
	/**
	 * @param dateFormat
	 * @return String
	 */
	public String getEffectiveDate(String dateFormat) {
		return getFormatterDate(effectiveDate, dateFormat);
	}
	
	/**
	 * @param effectiveDate The effectiveDate to set.
	 */
	public void setEffectiveDate(String effectiveDate) {
		this.effectiveDate = effectiveDate;
	}
	/**
	 * @return Returns the expirationDate.
	 */
	public String getExpirationDate() {
		if(expirationDate == null || expirationDate.length() <= 0){
					return "";
		}
		return DataConverter.standardDateFormat(this.expirationDate);
	}
	
	/**
	 * @param dateFormat 
	 * @return Returns the expirationDate.
	 */
	public String getExpirationDate(String dateFormat) {
		return getFormatterDate(expirationDate, dateFormat);
	}
	
	/**
	 * @param dateStr
	 * @param dateFormat
	 * @return object of type APData
	 * @throws ParseException
	 */
	public APDate getAPDate(String dateStr, String dateFormat) 
		throws ParseException {
		SimpleDateFormat dtFormat = new SimpleDateFormat(dateFormat);			
		return new APDate(dateStr, dtFormat);
		
	}
	
	/**
	 * @param dateStr
	 * @param dateFormat
	 * @return String
	 */
	public String getFormatterDate(String dateStr, String dateFormat) {
		String formattedDate = dateStr;
		String tempDateFormat="";
		try{
			if(dateFormat == null || dateFormat.length() <= 0){
				tempDateFormat = "MM-dd-yyyy";
			}else{
			tempDateFormat=dateFormat;
			}
				APDate apDate = getAPDate(dateStr, tempDateFormat);
				
				formattedDate = MMDDYYYYWSLASHES.print(new DateTime(apDate.getUtilDate()));
		}catch(Exception exp){
			LOGGER.log(Level.WARNING,"Unable to covert date: " + exp.getMessage(), exp);
			return formattedDate;
		}
		return formattedDate;
	}
	/**
	 * @param expirationDate The expirationDate to set.
	 */
	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}
	/**
	 * @return Returns the insured.
	 */
	public String getInsuredName() {
		return insured;
	}
	/**
	 * @param insured The insured to set.
	 */
	public void setInsuredName(String insured) {
		this.insured = insured;
	}
	/**
	 * @return Returns the producerCode.
	 */
	public String getProducerCode() {
		return producerCode;
	}
	/**
	 * @param producerCode The producerCode to set.
	 */
	public void setProducerCode(String producerCode) {
		this.producerCode = producerCode;
	}
	/**
	 * @return Returns the workItemId.
	 */
	public String getWorkItemId() {
		return workItemId;
	}
	/**
	 * @param workItemId The workItemId to set.
	 */
	public void setWorkItemId(String workItemId) {
		this.workItemId = workItemId;
	}
	/**
	 * @return Returns the workItemStatus.
	 */
	public String getWorkItemStatus() {
		return workItemStatus;
	}
	/**
	 * @param workItemStatus The workItemStatus to set.
	 */
	public void setWorkItemStatus(String workItemStatus) {
		this.workItemStatus = workItemStatus;
	}
	
	/**
	 * Loads the Policy summary bean from APDataCollection 
	 * 
	 * @param data	APDatacollection of webapp data
	 * @throws APException
	 */
	public void loadSummary( APDataCollection data) 
		throws APException{     	
       	try{
       	    // Variables for Insured section of Summary
       		this.setWorkItemId(String.valueOf(data.getId()));
       		
    		String firstName = data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='Insured'].GeneralPartyInfo.NameInfo.PersonName.GivenName", "");
    		String middleName = data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='Insured'].GeneralPartyInfo.NameInfo.PersonName.OtherGivenName", "");
    		String lastName = data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='Insured'].GeneralPartyInfo.NameInfo.PersonName.Surname", "");
    		StringBuilder fullName = new StringBuilder();
    		fullName.append(firstName);
    		fullName.append(' ');
         	if (middleName.length()>0) {
         		fullName.append(middleName);
         		fullName.append(' ');     		
         	}
         	fullName.append(lastName);
         	this.setInsuredName(fullName.toString());
    		
         	this.setAgencyCustomerId(data.getFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].ItemIdInfo.AgencyId", ""));

        	// Variables for Loss section of Summary
         	this.setLossDate(data.getFieldValue("ClaimsOccurrence.LossDt", ""));
        	this.setLossTime(data.getFieldValue("ClaimsOccurrence.LossTime", ""));

         	StringBuilder mailingAddress = new StringBuilder("");
         	mailingAddress.append(data.getFieldValue("ClaimsOccurrence.Addr.Addr1", ""));
         	if (data.getFieldValue("ClaimsOccurrence.Addr.Addr2", "").trim().length() > 0) {
             	mailingAddress.append(", ").append(data.getFieldValue("ClaimsOccurrence.Addr.Addr2", ""));  		
         	}
         	mailingAddress.append(", ").append(data.getFieldValue("ClaimsOccurrence.Addr.City", ""));  		
         	mailingAddress.append(", ").append(data.getFieldValue("ClaimsOccurrence.Addr.StateProvCd", ""));  		
         	mailingAddress.append(", ").append(data.getFieldValue("ClaimsOccurrence.Addr.PostalCode", ""));  		
         	this.setLossLocation(mailingAddress.toString());

         	this.setLossClaimType(data.getFieldValue("ClaimsOccurrence.ClaimTypeCd", ""));
         	this.setLossProbableAmount(data.getFieldValue("ClaimsOccurrence.ProbableIncurredAmt.Amt", ""));
         	this.setLossDescription(data.getFieldValue("ClaimsOccurrence.IncidentDesc", ""));
         	this.setLossReportedBy(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='ReptBy'].GeneralPartyInfo.NameInfo.CommlName.CommercialName", ""));
         	this.setLossReportedTo(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='ReptTo'].GeneralPartyInfo.NameInfo.CommlName.CommercialName", ""));

        	// Variables for Contact section of Summary
    		firstName = data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.NameInfo.PersonName.GivenName", "");
    		middleName = data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.NameInfo.PersonName.OtherGivenName", "");
    		lastName = data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.NameInfo.PersonName.Surname", "");
    		fullName = new StringBuilder();
    		fullName.append(firstName);
    		fullName.append(' ');
         	if (middleName.length()>0) {
         		fullName.append(middleName);
         		fullName.append(' ');     		
         	}
         	fullName.append(lastName);
         	this.setContactName(fullName.toString());

         	mailingAddress = new StringBuilder("");
         	mailingAddress.append(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.Addr[AddrTypeCd='MailingAddress'].Addr1", ""));
         	if (data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.Addr[AddrTypeCd='MailingAddress'].Addr2", "").trim().length() > 0) {
             	mailingAddress.append(", ").append(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.Addr[AddrTypeCd='MailingAddress'].Addr2", ""));  		
         	}
         	mailingAddress.append(", ").append(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.Addr[AddrTypeCd='MailingAddress'].City", ""));  		
         	mailingAddress.append(", ").append(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.Addr[AddrTypeCd='MailingAddress'].StateProvCd", ""));  		
         	mailingAddress.append(", ").append(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.Addr[AddrTypeCd='MailingAddress'].PostalCode", ""));  		
         	this.setContactAddress(mailingAddress.toString());
         	this.setContactPrimaryPhone(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.Communications.PhoneInfo[@id='1'].PhoneNumber", ""));
         	this.setContactPrimaryEmail(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.Communications.EmailInfo[CommunicationUseCd='Day'].EmailAddr", ""));
         	this.setContactWhenTo(data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='CC'].GeneralPartyInfo.PreferredContact.ContactDuration.Description", ""));
         	
         	String remarks = data.getFieldValue("RemarkText[@apType='AgentComments']","");
         	this.setGeneralRemarks(remarks);
         	String claimOccurenceLocationCode = data.getFieldValue("ClaimsOccurrence.LossTime", "");
         	this.setInsuredLocationCode(claimOccurenceLocationCode);
         	String reportNum = data.getFieldValue("ClaimsOccurrence.ClaimsReported.ReportNumber", "");
         	this.setLossReportNumber(reportNum);
         	String policeOrFireDeptContactedTemp = data.getFieldValue("ClaimsParty[ClaimsPartyInfo.ClaimsPartyRoleCd='Emergency'].GeneralPartyInfo.NameInfo.CommlName.CommercialName", "");
       	    this.setPoliceOrFireDeptContacted(policeOrFireDeptContactedTemp);
       	}catch(Exception exception){
       		LOGGER.warning(LoggableStackTrace.getStackTrace(exception));
       		throw new APException(exception.getMessage());
	    }
     }
	
	 /**
	 * @throws APException
	 */
	private void getExternalAgencyId() throws APException{
		AppProperties appProps = AppProperties.getAppProperties(); 
		validateAgencyId  = appProps.getStringProperty("TEST_AGENCYID");
	 }

	/**
	 * @param string
	 */
	public void setWorkItemPrefix(String string){
		workItemPrefix = string;
	}
	
	/**
	 * @return String
	 */
	public String getDownPaymentAmount() {
		return NumberFormatter.getCommatizeDollars(downPaymentAmount,true);
	}

	/**
	 * @return String
	 */
	public String getDownPaymentType() {
		return downPaymentType;
	}

	/**
	 * @param string
	 */
	public void setDownPaymentAmount(String string) {
		downPaymentAmount = string;
	}

	/**
	 * @param string
	 */
	public void setDownPaymentType(String string) {
		downPaymentType = string;
	}

	/**
	 * @return Boolean
	 */
	public boolean isElectronicPayment(){
		return !"".equals(getDownPaymentType()) && "Electronic Payment".equals(getDownPaymentType());
	}
	
	/**
	 * @return String
	 */
	public String getElectronicPaymentUrl(){
		return electronicPaymentUrl;
	}
	/**
	 * @return String
	 */
	public String getAgencyId() {
		return agencyId;
	}

	/**
	 * @param string
	 */
	public void setAgencyId(String string) {
		agencyId = string;
	}

	/**
	 * @return String
	 */
	public String getValidateAgencyId(){
		try{
			getExternalAgencyId();
		}catch(Exception e){
			LOGGER.log(Level.FINE,e.getMessage(),e);
		}
		return validateAgencyId;
	}

	/**
	 * @param agencyId 
	 */
	public void setValidateAgencyId(String agencyId) {
		validateAgencyId = agencyId;
	}
	
	
	/**
	 * FNOL Loss Getters and Setters 
	 * @return String
	 */
	public String getLossClaimType() {
		return lossClaimType;
	}
	/**
	 * @param lossClaimType
	 */
	public void setLossClaimType(String lossClaimType) {
		this.lossClaimType = lossClaimType;
	}
	/**
	 * @return String
	 */
	public String getLossDate() {
		if(lossDate == null || lossDate.length() <= 0){
					return "";
		}
		return DataConverter.standardDateFormat(this.lossDate);
	}
	/**
	 * @param dateFormat
	 * @return String
	 */
	public String getLossDate(String dateFormat) {
		return getFormatterDate(lossDate, dateFormat);
	}
	/**
	 * @param lossDate
	 */
	public void setLossDate(String lossDate) {
		this.lossDate = lossDate;
	}
	/**
	 * @return String
	 */
	public String getLossDescription() {
		return lossDescription;
	}
	/**
	 * @param lossDescription
	 */
	public void setLossDescription(String lossDescription) {
		this.lossDescription = lossDescription;
	}
	/**
	 * @return String
	 */
	public String getLossLocation() {
		return lossLocation;
	}
	/**
	 * @param lossLocation
	 */
	public void setLossLocation(String lossLocation) {
		this.lossLocation = lossLocation;
	}
	/**
	 * @return String
	 */
	public String getLossProbableAmount() {
		return lossProbableAmount;
	}
	/**
	 * @param lossProbableAmount
	 */
	public void setLossProbableAmount(String lossProbableAmount) {
		this.lossProbableAmount = lossProbableAmount;
	}
	/**
	 * @return String
	 */
	public String getLossReportedBy() {
		return lossReportedBy;
	}
	/**
	 * @param lossReportedBy
	 */
	public void setLossReportedBy(String lossReportedBy) {
		this.lossReportedBy = lossReportedBy;
	}
	/**
	 * @return String
	 */
	public String getLossReportedTo() {
		return lossReportedTo;
	}
	/**
	 * @param lossReportedTo
	 */
	public void setLossReportedTo(String lossReportedTo) {
		this.lossReportedTo = lossReportedTo;
	}
	/**
	 * @return String
	 */
	public String getLossTime() {
		return lossTime;
	}
	/**
	 * @param lossTime
	 */
	public void setLossTime(String lossTime) {
		this.lossTime = lossTime;
	}
	
	/**
	 * FNOL Contact Getters and Setters 
	 * @return String
	 */
	public String getContactAddress() {
		return contactAddress;
	}
	/**
	 * @param contactAddress
	 */
	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}
	/**
	 * @return String
	 */
	public String getContactName() {
		return contactName;
	}
	/**
	 * @param contactName
	 */
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	/**
	 * @return String
	 */
	public String getContactPrimaryEmail() {
		return contactPrimaryEmail;
	}
	/**
	 * @param contactPrimaryEmail
	 */
	public void setContactPrimaryEmail(String contactPrimaryEmail) {
		this.contactPrimaryEmail = contactPrimaryEmail;
	}
	/**
	 * @return String
	 */
	public String getContactPrimaryPhone() {
		return contactPrimaryPhone;
	}
	/**
	 * @param contactPrimaryPhone
	 */
	public void setContactPrimaryPhone(String contactPrimaryPhone) {
		this.contactPrimaryPhone = contactPrimaryPhone;
	}
	/**
	 * @return String
	 */
	public String getContactWhenTo() {
		return contactWhenTo;
	}
	/**
	 * @param contactWhenTo
	 */
	public void setContactWhenTo(String contactWhenTo) {
		this.contactWhenTo = contactWhenTo;
	}
	/**
	 * @return the generalRemarks
	 */
	public String getGeneralRemarks() {
		return generalRemarks;
	}
	/**
	 * @param generalRemarks the generalRemarks to set
	 */
	public void setGeneralRemarks(String generalRemarks) {
		this.generalRemarks = generalRemarks;
	}
	/**
	 * @return String
	 */
	public String getInsuredLocationCode() {
		return insuredLocationCode;
	}
	/**
	 * @param insuredLocationCode
	 */
	public void setInsuredLocationCode(String insuredLocationCode) {
		this.insuredLocationCode = insuredLocationCode;
	}
	/**
	 * @return String
	 */
	public String getLossReportNumber() {
		return lossReportNumber;
	}
	/**
	 * @param lossReportNumber
	 */
	public void setLossReportNumber(String lossReportNumber) {
		this.lossReportNumber = lossReportNumber;
	}
	/**
	 * @return String
	 */
	public String getPoliceOrFireDeptContacted() {
		return policeOrFireDeptContacted;
	}
	/**
	 * @param policeOrFireDeptContacted
	 */
	public void setPoliceOrFireDeptContacted(String policeOrFireDeptContacted) {
		this.policeOrFireDeptContacted = policeOrFireDeptContacted;
	}
}
