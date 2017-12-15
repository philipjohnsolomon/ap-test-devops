<!--begin policychange/readOnlyView.jsp 
	Use for displaying policy details portion of a summary page 
	for a new business -->
<!--  The caller can pass a CHANGE_REQUEST_TITLE jsp:param to this jsp include 
to override the default label for this section -->

<!--BEGIN STANDARD FRAMEWORK -->
<%@include file="../policychange/pageSetup.jsp" %>
<%@include file="../policychange/style.jsp" %> 
<jsp:include page="../policychange/changeRequests.jsp" flush="true" />
