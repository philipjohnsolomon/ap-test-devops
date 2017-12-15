<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="functionPath" value="${param.path}.@function" />
<c:set var="function" value="${tk:getFieldValue(toolkitData, functionPath, '')}"/>

<c:set var="splitFn" value="${fn:split(function, '(')}"/>
<c:set var="fn" value="${splitFn[0]}"/>

<c:set var="hidden" value="${tk:getCompareValues(fn, 'fn:substring','','display: none;')}" />					

<tk:select path="${functionPath}" label="Function" required="" helptext="xarc_helptext|function" className="change_event function_select_list_change">
	<c:out value="${tk:getOptionListHTML('xarcFunctions', fn, '')}" escapeXml="false"/>
</tk:select>

<jsp:include page="../palette/substringFunction.jsp" >
	<jsp:param name="hidden" value="${hidden}"></jsp:param>	   	
</jsp:include>		
		