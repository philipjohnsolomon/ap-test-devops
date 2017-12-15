<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="basePath" value="${toolkitData.basePath}"/>
<c:set var="fieldTypePath" value="${basePath}.@type"/>
<c:set var="fieldType" value="${tk:getFieldValue(toolkitData, fieldTypePath, 'id')}"/>
<c:set var="fieldValue" value="${tk:getFieldValue(toolkitData,basePath, '')}"/>
<c:set var="formatInfo" value="true"/>

<c:if test="${(toolkitData.currentIndex % 2 == 0) && (fieldType=='id')}">	
	<c:set var="formatInfo" value="false"/>
</c:if>

<div id="${basePath}_field_container" class="field field_toggle">	
	<c:if test="${formatInfo=='true'}">	
		Then split on this value,
		<table class="noborder">
			<tbody>
				<tr>					
					<td>
						<input type="hidden" name="${basePath}.@delete" id="${basePath}.@delete" value="${fieldValue}"></input>
						<select name="${basePath}.@type" id="${basePath}.@type" class="change_event select_list_change">	
							<c:if test="${(fieldType=='formatInfo')}">
								<option value="formatInfo" selected="selected">Literal</option>
								<option value="singleSpace">SingleSpace</option>
							</c:if>
							<c:if test="${(fieldType=='singleSpace')}">
								<option value="formatInfo">Literal</option>
								<option value="singleSpace" selected="selected">SingleSpace</option>
							</c:if>		
						</select>
					</td>
					<td>
						<input type="text" name="${basePath}" id="${basePath}" class="required" size="40" value="${fieldValue}" ></input>						
					</td>				
				</tr>
			</tbody>
		</table>
		then
	</c:if>
	
	<c:if test="${formatInfo=='false'}">
		<input type="hidden" name="${basePath}.@delete" id="${basePath}.@delete" value="" />	
		<input type="hidden" name="${basePath}.@type" id="${basePath}.@type" value="${fieldType}" />	
		
		<tk:textarea label="Show the value from this path" 
			required="" 
			path="${basePath}" 
			className="required" 
			defaultValue="" 
			fieldValue="${fieldValue}"
			size="">
		</tk:textarea>
	</c:if>
</div>



