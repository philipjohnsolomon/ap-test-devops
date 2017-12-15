<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="executeWhenPath" value="${path}.executeWhen"/>
<c:set var="executeWhenCount" value="${tk:getCount(toolkitData, executeWhenPath)}"/>
<c:set var="executeWhenIdHelpText" value="${tk:getOptionsListValue('connector_helptext', 'triggeringactionid')}"/>
<c:set var="executeWhenActionHelpText" value="${tk:getOptionsListValue('connector_helptext', 'action')}"/>

<div class="selectlists scrollTable executeWhen">
	<table>
		<thead>
			<tr id="executeWhenPaletteRow paletteRow">
				<th><acronym title="${executeWhenIdHelpText}">ID</acronym></th>
				<th colspan="2"><acronym title="${executeWhenActionHelpText}">Actions</acronym></th>
			</tr>
		</thead>
		<tbody id= "${path}.executeWhen_container">
		<tr style="hidden">
			<td colspan="3" style="hidden"><input type="hidden" class="_childClassName" value="executeWhen"/></td>
		</tr>
					
		<c:forEach var="index" begin="1" step="1" end="${executeWhenCount}">
			
			<jsp:setProperty name="toolkitData" property="currentIndex" value="${index-1}"/>
			<jsp:setProperty name="toolkitData" property="basePath" value="${executeWhenPath}[${index-1}]"/>
			
			<jsp:include page="executeWhen.jsp" />
		
		</c:forEach>
		<jsp:setProperty name="toolkitData" property="basePath" value="${path}"/>	
		
		</tbody>
			
		<tfoot>
	  		<tr>
	  			<td colspan="3">
					<tkmenu:menuPill id="${path}_addPill">
						<tkmenu:menuButton id="${path}.executeWhen_addConnectorExecuteWhen" title="Add Triggering Action" text="Add Triggering Action" classname="addNew"/>
					</tkmenu:menuPill> 
	  			</td>
	  		</tr>
	  	</tfoot>
	</table>	
</div>