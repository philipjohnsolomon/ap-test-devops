<%@ page import="com.agencyport.servlets.base.IBaseConstants,
				 com.agencyport.shared.ExceptionReport"%>
<%@page import="java.util.Locale,com.agencyport.utils.text.HtmlTransliterator"%>

<%
	ExceptionReport exRpt = (ExceptionReport) request.getAttribute(IBaseConstants.ERROR_REPORT); 
    String errorString = (String)request.getAttribute("ERROR_STRING");
	if(null == errorString){
		errorString = HtmlTransliterator.encode(exRpt.getHighLevelMessage());
	}
%>

<div id="roster_error"> <%= errorString %></div>

		