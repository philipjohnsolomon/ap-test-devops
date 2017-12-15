<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>
<c:set var="type" value="${tdfData.artifactType}"/>

<c:set var="connectorDisplayStyle" value="display:none;"/>
<c:set var="connectorFocusOnLoad" value="false"/>
<c:if test="${not showSections}">
	<c:set var="connectorDisplayStyle" value="display:inline;"/>
	<c:set var="connectorFocusOnLoad" value="true"/>
</c:if>

<tk:tabs path="${basePath}_editor">
	<c:if test="${showSections}">
		<tk:tab tabName="Sections" focusOnLoad="true" path="${basePath}"></tk:tab>
	</c:if>
	<tk:tab tabName="Connectors" path="${basePath}" focusOnLoad="${connectorFocusOnLoad}"></tk:tab>
</tk:tabs>

<c:if test="${showSections}">
	<tk:tdfTabContent path="${basePath}" tabName="Sections">
		<tk:pageEntities path="${basePath}" entityPath="pageElement"/>
	</tk:tdfTabContent>
</c:if>

<tk:tdfTabContent path="${basePath}" tabName="Connectors" styleValue="${connectorDisplayStyle}">
	<tk:accordion fieldPath="${basePath}.connectors[@type='process']" action="loadEntry" fieldValue="Process Side"/>
	<tk:accordion fieldPath="${basePath}.connectors[@type='display']" action="loadEntry" fieldValue="Display Side"/>
</tk:tdfTabContent>