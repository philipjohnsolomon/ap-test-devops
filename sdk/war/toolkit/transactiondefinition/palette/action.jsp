<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="splitPath" value="${fn:split(path, '.')}"/>
<c:set var="rosterSubType" value="${splitPath[0]}.@subtype"/>

<c:set var="copyPath" value="${path}[@type='copy']"/>
<c:set var="copyValuePath" value="${copyPath}.@type"/>
<c:set var="copyDescription" value="${tk:getOptionsListValue('fieldElement_helptext', 'copy')}"/>	
<c:set var="copyValue" value="${tk:getFieldValue(toolkitData, copyValuePath, '')}"/>
<c:set var="copyChecked" value="${tk:getCompareValues(copyValue, '', '', 'checked')}" />
<c:set var="copyHiddenValue" value="true"/>

<c:set var="editPath" value="${path}[@type='edit']"/>
<c:set var="editValuePath" value="${editPath}.@type"/>
<c:set var="editDescription" value="${tk:getOptionsListValue('fieldElement_helptext', 'edit')}"/>	
<c:set var="editValue" value="${tk:getFieldValue(toolkitData, editValuePath, '')}"/>
<c:set var="editChecked" value="${tk:getCompareValues(editValue, '', '', 'checked')}" />
<c:set var="editHiddenValue" value="true"/>

<c:set var="deletePath" value="${path}[@type='delete']"/>
<c:set var="deleteValuePath" value="${deletePath}.@type"/>
<c:set var="deleteDescription" value="${tk:getOptionsListValue('fieldElement_helptext', 'delete')}"/>	
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deleteValuePath, '')}"/>
<c:set var="deleteChecked" value="${tk:getCompareValues(deleteValue, '', '', 'checked')}" />
<c:set var="deleteHiddenValue" value="true"/>

<c:set var="viewPath" value="${path}[@type='viewFile']"/>
<c:set var="viewValuePath" value="${viewPath}.@type"/>
<c:set var="viewValue" value="${tk:getFieldValue(toolkitData, viewValuePath, '')}"/>
<c:set var="viewChecked" value="${tk:getCompareValues(viewValue, '', '', 'checked')}" />
<c:set var="viewHiddenValue" value="true"/>

<c:if test="${copyChecked == 'checked'}">
	<c:set var="copyHiddenValue" value="false"/>
</c:if>

<c:if test="${editChecked == 'checked'}">
	<c:set var="editHiddenValue" value="false"/>
</c:if>

<c:if test="${deleteChecked == 'checked'}">
	<c:set var="deleteHiddenValue" value="false"/>
</c:if>

<c:if test="${viewChecked == 'checked'}">
	<c:set var="viewHiddenValue" value="false"/>
</c:if>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
	</tk:tabs>
	<tk:tabContent tabName="Options" path="${path}">

		<div id="${copyValuePath}_formRow" class="formRow">
			<label class="label" id="${copyValuePath}_labelElement" for="${copyPath}.@delete">
				<span id="${copyValuePath}_required" ></span> 
				<span id="${copyValuePath}_label">
					<acronym title="${copyDescription}">Copy</acronym>
				</span> 
			</label>
			<span class="checkBoxCell">		
				<input class="checkbox change_event validateCheckBoxGroup" type="checkbox" ${copyChecked} id="${copyValuePath}" name="" value="copy"/>
				<input class="hidden" type="hidden" id="${copyPath}.@delete" name="${copyPath}.@delete" value="${copyHiddenValue}"/>
	  		</span>
	  	</div>
			
		<div id="${editValuePath}_formRow" class="formRow">
			<label class="label" id="${editValuePath}_labelElement" for="${editPath}.@delete">
				<span id="${editValuePath}_required" ></span> 
				<span id="${editValuePath}_label">
			  		<acronym title="${editDescription}">Edit</acronym>
			  	</span> 
			</label>
			<span class="checkBoxCell">
				<input class="checkbox change_event validateCheckBoxGroup" type="checkbox" ${editChecked} id="${editValuePath}" name="" value="edit"/>
				<input class="hidden" type="hidden" id="${editPath}.@delete" name="${editPath}.@delete" value="${editHiddenValue}"/>
	  		</span>
	  	</div>

		<div id="${deleteValuePath}_formRow" class="formRow">
			<label class="label" id="${deleteValuePath}_labelElement" for="${deletePath}.@delete">
			  	<span id="${deleteValuePath}_required" ></span> 
			  	<span id="${deleteValuePath}_label">
			  		<acronym title="${deleteDescription}">Delete</acronym>
			  	</span> 
	  		</label>
			<span class="checkBoxCell">
				<input class="checkbox change_event validateCheckBoxGroup" type="checkbox" ${deleteChecked} id="${deleteValuePath}" name="" value="delete"/>
				<input class="hidden" type="hidden" id="${deletePath}.@delete" name="${deletePath}.@delete" value="${deleteHiddenValue}"/>
  			</span>
  		</div>
  		
  		<c:if test="${rosterSubType == 'file'}">	
			<div id="${viewValuePath}_formRow" class="formRow">
				<label class="label" id="${viewValuePath}_labelElement" for="${viewPath}.@delete">
				  <span id="${viewValuePath}_required" ></span> 
				  <span id="${viewValuePath}_label">View File</span> 
		  		</label>
				<span class="checkBoxCell">
					<input class="checkbox change_event validateCheckBoxGroup" type="checkbox" ${viewChecked} id="${viewValuePath}" name="${viewValuePath}" value="viewFile"/>
					<input class="hidden" type="hidden" id="${viewPath}.@delete" name="${viewPath}.@delete" value="${viewHiddenValue}"/>
	  			</span>
	  		</div>
	  	</c:if>
	</tk:tabContent>
</div>