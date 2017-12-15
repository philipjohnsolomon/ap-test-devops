<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="behaviorPath" value="${toolkitData.basePath}"/>
<c:set var="pathId" value="${behaviorPath}.@id"/>
<c:set var="pathIdValue" value="${tk:getFieldValue(toolkitData, pathId, '')}"/>
<c:set var="actionPath" value="${behaviorPath}.do.@action"/>
<c:set var="titlePath" value="${behaviorPath}.@title"/>
<c:set var="descriptionPath" value="${behaviorPath}.description"/>
<c:set var="propertyPath" value="${behaviorPath}.do.property"/>
<c:set var="forPath" value="${behaviorPath}.for"/>
<c:set var="wherePath" value="${behaviorPath}.where.preCondition"/>

<c:set var="defaultTitle" value="${tk:getFieldValue(toolkitData, pathId, '')}"/>

<tk:basePalette path="${behaviorPath}">
	<tk:tabs path="${behaviorPath}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${behaviorPath}"></tk:tab>
		<tk:tab tabName="alterProperties" tabDisplayName="Alter Properties" focusOnLoad="false" path="${behaviorPath}"></tk:tab>
		<tk:tab tabName="for" tabDisplayName="Page Entities" focusOnLoad="false" path="${behaviorPath}"></tk:tab>
		<tk:tab tabName="Where" focusOnLoad="false" path="${behaviorPath}"></tk:tab>
	</tk:tabs>
	<tk:tabContent tabName="Options" path="${behaviorPath}">
		<c:set var="defaultValue" value="${tk:getFieldValue(toolkitData, actionPath, '')}"/>
		<input type="hidden" name="${behaviorPath}.@delete" id="${behaviorPath}.@delete" value=""/>
		<tk:select path="${actionPath}" label="Action" required="*" helptext="behavior_helptext|action" className="change_event accordion_update">
			<c:out value="${tk:getOptionsHTML(toolkitData, 'action', actionPath, defaultValue)}" escapeXml="false"/>
		</tk:select>
		<tk:input path="${titlePath}" label="Title" fieldValue="${tk:getFieldValue(toolkitData,titlePath,defaultTitle)}"
			elementName="${titlePath}" required="*" size="20" className="change_event accordion_update" helptext="behavior_helptext|title">
		</tk:input>
		<tk:input path="${pathId}" label="ID" fieldValue="${tk:getFieldValue(toolkitData,pathId,'')}"
			elementName="${pathId}" required="*" size="20" className="" helptext="behavior_helptext|id">
		</tk:input>
		<tk:textarea path="${descriptionPath}" label="Description" fieldValue="${tk:getFieldValue(toolkitData,descriptionPath,'')}"
			elementName="${descriptionPath}" required="" defaultValue="" size="20" className="" helptext="behavior_helptext|description">
		</tk:textarea>
	</tk:tabContent>
	<tk:tabContent tabName="alterProperties" path="${behaviorPath}" styleValue="display: none">
		<table>
			<thead>
				<tr class="propertyPaletteRow paletteRow">
					<td class="propName">
						Property Name
					</td>
					<td class="propActions" colspan="2">
						Actions
					</td>
				</tr>
			</thead>
			<tbody id="${propertyPath}_container" class="propertyPalette childPalette">
				<c:set var="propertyCount" value="${tk:getCount(toolkitData, propertyPath)}"/>
				<c:forEach var="count" begin="1" step="1" end="${propertyCount}">
					<tk:setBeanContext index="${count-1}" path="${propertyPath}[${count-1}]" />
					<jsp:include page="property.jsp" >
						<jsp:param name="product" value="${param.product}"></jsp:param>
			   			<jsp:param name="artifactId" value="${param.artifactId}"></jsp:param>
					</jsp:include>
				</c:forEach>
		  	</tbody>
		  </table>
	</tk:tabContent>
	<tk:tabContent tabName="for" path="${behaviorPath}" styleValue="display: none">
		<table>
			<thead>
				<c:set var="forHelpText" value="${tk:getOptionsListValue('behavior_helptext', 'forpageentity')}"/>
				<tr class="forPaletteRow paletteRow">
					<td class="forValue" colspan="2">
						<acronym title="${forHelpText}">
						Transaction
						</acronym>
					</td>
					<td class="forValue" colspan="2">
						<acronym title="${forHelpText}">
						Page
						</acronym>
					</td>
					<td class="forValue" colspan="2">
						<acronym title="${forHelpText}">
						Section/Connector Type
						</acronym>
					</td>
					<td class="forValue" colspan="2">
						<acronym title="${forHelpText}">
						Field/Connector/Instruction
						</acronym>
					</td>
				</tr>
			</thead>
			<tbody id="${forPath}_container" class="forPalette childPalette">
				<c:set var="forCount" value="${tk:getCount(toolkitData, forPath)}"/>
				<c:if test="${forCount == 0}">
					<c:set var="forCount" value="1"/>
				</c:if>
				
				<c:forEach var="count" begin="1" step="1" end="${forCount}">		
					<tk:setBeanContext index="${count-1}" path="${forPath}[${count-1}]" />
					<c:set var="PAGEENTITYDATA" value="${PAGEENTITYLIST[count-1]}" scope="request"/>	
					<jsp:include page="for.jsp" >
						<jsp:param name="product" value="${param.product}"></jsp:param>
		   				<jsp:param name="artifactId" value="${param.artifactId}"></jsp:param>
					</jsp:include>
				</c:forEach>
			
		  	</tbody>
		  	<tfoot>
		  		<tr>
		  			<td colspan="9">
		  				<tkmenu:menuPill id="${forPath}_behaviorPill">
							<tkmenu:menuButton id="${forPath}_addFor" title="Add 'for' clause" text="Add 'for' clause" classname="addNew action addable for solo"/>
						</tkmenu:menuPill>
		  			</td>
		  		</tr>
		  	</tfoot>
		</table>
	</tk:tabContent>
	<tk:tabContent tabName="Where" path="${behaviorPath}" styleValue="display: none">
			<table>
				<thead>
					<c:set var="preconditionHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'whereprecondition')}"/>
					<c:set var="testHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'wheretest')}"/>
					<c:set var="actionsHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'whereactions')}"/>
					<tr class="wherePaletteRow paletteRow">
						<td class="wherePreconditionName">
							<acronym title="${preconditionHelptext}">
							Precondition Returns
							</acronym>
						</td>
						<td class="wherePreconditionName">
							<acronym title="${preconditionHelptext}">
							Precondition
							</acronym>
						</td>
						<td class="wherePreconditionTest">
							<acronym title="${testHelptext}">
							Operand
							</acronym>
						</td>
						<td class="wherePreconditionActions">
							<acronym title="${actionsHelptext}">
							Values
							</acronym>
						</td>
					</tr>
				</thead>
				<tbody id="${wherePath}_container" class="wherePalette childPalette">
					<c:set var="whereCount" value="${tk:getCount(toolkitData, wherePath)}"/>
					<c:forEach var="count" begin="1" step="1" end="${whereCount}">
						<tk:setBeanContext index="${count-1}" path="${wherePath}[${count-1}]"/>						
						<c:set var="WHEREDATA" value="${WHEREDATALIST[count-1]}" scope="request"/>
						<jsp:include page="where.jsp" >
							<jsp:param name="artifactId" value="${param.artifactId}"></jsp:param>
							<jsp:param name="product" value="${param.product}"></jsp:param>
						</jsp:include>
					</c:forEach>
			  	</tbody>
			  	<tfoot>
			  		<tr>
			  			<td colspan="4">
							<tkmenu:menuPill id="${wherePath}_behaviorPill">
								<tkmenu:menuButton id="${wherePath}_addWhere" title="Add precondition to 'where' clause" text="Add precondition to 'where' clause" classname="addNew addable where"/>
							</tkmenu:menuPill>
			  			</td>
			  		</tr>
			  	</tfoot>
		  	</table>
	</tk:tabContent>
</tk:basePalette>