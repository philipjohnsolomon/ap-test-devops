<%@page import="com.agencyport.account.model.IAccount"%>
<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@page import="com.agencyport.account.AccountDetails" %>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.shared.locale.ISharedLocaleConstants"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
%>

<%

	AccountDetails details = (AccountDetails)request.getAttribute("accountDetails");
	String lastUpdated = ResourceBundleStringUtils.makeSubstitutions(accountRB.getString("account.management.lastupdatedby"), 
						details.getLastUpdated().getStringDate(), details.getLastUpdatedBy());
						
	String createdBy = ResourceBundleStringUtils.makeSubstitutions(accountRB.getString("account.management.createdby"), 
						details.getCreatedTime().getStringDate(), details.getCreatedBy());
							
	String noneLabel = accountRB.getString("account.management.none");

%>

<div class="account-detail">
	<input type="hidden" id="worklist_accountId" value="${accountDetails.accountId}" />
	
		<div class="info-account row" id="${accountDetails.accountType}">
			<div class="account-column col-sm-4 col-md-4 nametag">
				<dl>
					<dt class="account-name">
						<%=JSPHelper.prepareForHTML(details.getAccountName()) %>
					</dt> 
					<dd class="account-type"><span data-toggle="tooltip" data-placement="right" title="<%=(IAccount.AccountType.isPersonal(details.getAccountType()))?accountRB.getString("account.management.label.person"):accountRB.getString("account.management.label.company")%>"><%=(IAccount.AccountType.isPersonal(details.getAccountType()))?accountRB.getString("account.management.label.person"):accountRB.getString("account.management.label.company")%></span></dd>
					<dd class="account-number"><%=accountRB.getString("account.management.label.accountHashTag","Account #")%>&nbsp;<%=JSPHelper.prepareForHTML(details.getAccountNumber()) %></dd>
				</dl>
			</div>
			<div class="account-column col-sm-4 col-md-4 contact-info">
				<dl>
					<dt><%=accountRB.getString("header.Title.ContactInformation") %></dt>
					<dd class="address" id="account_address" data-toggle="tooltip" data-placement="right" title="<%=accountRB.getString("account.management.label.accountAddr")%>"><%=JSPHelper.prepareForHTML(details.getStreetAddress()) %></dd>
					<dd class="address" id="account_address" data-toggle="tooltip" data-placement="right" title="<%=accountRB.getString("account.management.label.accountAddr")%>"><%=JSPHelper.prepareForHTML(details.getCityStateZip()) %> </dd>
				<c:if test="${accountDetails.accountType == 'P'}">
				    <c:if test="${accountDetails.homePhone != ''}">
						<dd class="phone-home" id="phone_home" data-toggle="tooltip" data-placement="right" title="<%=accountRB.getString("account.management.homePhone")%>">
							<jsp:include page="fieldValue.jsp" flush="true">
								<jsp:param name="fvalue" value="${accountDetails.homePhone}"/>
								<jsp:param name="noneLabel" value="<%=noneLabel%>" />
							</jsp:include> <span class="phone-label">(Home)</span>
						</dd>
					</c:if>
					<c:if test="${accountDetails.workPhone != ''}">
						<dd class="phone-work" id="phone_work" data-toggle="tooltip" data-placement="right" title="<%=accountRB.getString("account.management.workPhone")%>">
							<jsp:include page="fieldValue.jsp" flush="true">
								<jsp:param name="fvalue" value="${accountDetails.workPhone}"/>
								<jsp:param name="noneLabel" value="<%=noneLabel%>" />
							</jsp:include> <span class="phone-label">(Work)</span>
						</dd>
					</c:if>
					<c:if test="${accountDetails.mobilePhone != ''}">
					<dd class="phone-mobile" id="phone_mobile" data-toggle="tooltip" data-placement="right" title="<%=accountRB.getString("account.management.mobilePhone")%>">
						<jsp:include page="fieldValue.jsp" flush="true">
							<jsp:param name="fvalue" value="${accountDetails.mobilePhone}"/>
							<jsp:param name="noneLabel" value="<%=noneLabel%>" />
						</jsp:include> <span class="phone-label">(Mobile)</span>
					</dd>
					</c:if>
				</c:if>
				 <c:if test="${accountDetails.accountType == 'C'}">
				 	 <c:if test="${not empty fn:trim(accountDetails.businessPhone)}">
						<dd class="phone-business" id="phone_business" data-toggle="tooltip" data-placement="right" title="<%=accountRB.getString("account.management.businessPhone")%>">
							<jsp:include page="fieldValue.jsp" flush="true">
								<jsp:param name="fvalue" value="${accountDetails.businessPhone}"/>
								<jsp:param name="noneLabel" value="<%=noneLabel%>" />
							</jsp:include> 
						</dd>
					</c:if>
				 </c:if>
				 <c:if test="${accountDetails.emailAddress != ''}">
						<dd class="email" id="account_email" data-toggle="tooltip" data-placement="right" title="<%=accountRB.getString("account.management.email")%>">
							<jsp:include page="fieldValue.jsp" flush="true">
								<jsp:param name="fvalue" value="${accountDetails.emailAddress}"/>
								<jsp:param name="noneLabel" value="<%=noneLabel%>" />
							</jsp:include>		
					</dd>
				  </c:if>
				</dl>
			</div>
			<div class="account-column col-sm-4 col-md-4 timestamp">
				<dl>
					<dt><%=accountRB.getString("header.Title.Created") %></dt>
					<dd><%=createdBy%></dd>
				</dl>
				<dl>
					<dt><%=accountRB.getString("header.Title.LastUpdated") %></dt>
					<dd><%=lastUpdated %></dd>
				</dl>
			</div>
		</div>

</div>

