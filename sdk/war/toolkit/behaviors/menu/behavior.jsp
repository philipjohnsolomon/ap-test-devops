<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"></jsp:useBean>

<c:set var="path" value="${toolkitData.basePath}" />
<c:set var="propertyPath" value="${toolkitData.basePath}.do.property" />
 <c:set var="correctionHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'correction')}"/>
 <c:set var="customReaderClassNameHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'customReaderClassName')}"/>
 <c:set var="dataFilterHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'dataFilter')}"/>
 <c:set var="defaultValueHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'defaultValue')}"/>
 <c:set var="emptyRosterMessageHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'emptyRosterMessage')}"/>
 <c:set var="enableRecoverHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'enableRecover')}"/>
 <c:set var="formatMaskHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'formatMaskHelptext')}"/>
 <c:set var="groupIdHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'groupId')}"/>
 <c:set var="helpTextHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'helpText')}"/>
 <c:set var="alteridHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'alterid')}"/>
 <c:set var="javascriptHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'javascript')}"/>
 <c:set var="labelHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'label')}"/>
 <c:set var="legendHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'legend')}"/>
 <c:set var="lengthHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'maxEntries')}"/>
 <c:set var="maxEntriesHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'maxLength')}"/>
 <c:set var="minEntriesHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'minEntries')}"/>
 <c:set var="maxLengthHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'maxLength')}"/>
 <c:set var="minLengthHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'minLength')}"/>
 <c:set var="messageHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'message')}"/>
 <c:set var="messageClassFilter" value="${tk:getOptionsListValue('behavior_helptext', 'messageClassFilter')}"/>
 <c:set var="optionListReferenceTagHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'optionListReferenceTag')}"/>
 <c:set var="readonlyHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'readonly')}"/>
 <c:set var="requiredHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'required')}"/>
 <c:set var="styleClassHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'styleClass')}"/>
 <c:set var="suppressMessageDisplayHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'supressMessageDisplay')}"/>
 <c:set var="titleHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'title')}"/>
 <c:set var="validationHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'validation')}"/>
 <c:set var="valueHelptext" value="${tk:getOptionsListValue('behavior_helptext', 'value')}"/>

<div id="${path}_menu" style="" class="menu">
	<tkmenu:menuPill id="${toolkitData.basePath}_behaviorPill">
		<tkmenu:menuButton id="${path}_delete" title="Delete This Behavior" text="Delete" classname="deleteAction"/>
	</tkmenu:menuPill>
	<tkmenu:menuPill id="${path}_addPill">
		<tkmenu:menuDropDown id="${path}_alter_button" title="Add 'alter' property" text="Add 'alter' property" classname="addable alter" style="display: none;">
			<tkmenu:menuOption id="${propertyPath}_alter-correction" title="${correctionHelptext}" text="Correction" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-customRosterReaderClassName" title="${customReaderClassNameHelptext}" text="Custom RosterReader Class" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-dataFilter" title="${dataFilterHelptext}" text="Data Filter" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-defaultValue" title="${defaultValueHelptext}" text="Default Value" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-emptyRosterMessage" title="${emptyRosterMessageHelptext}" text="Empty Roster Message" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-enableRecover" title="${enableRecoverHelptext}" text="Enable Recover" classname="addNew addNewProperty"/>
			<tkmenu:menuOption id="${propertyPath}_alter-formatMask" title="${formatMaskHelptext}" text="Format Mask" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-groupId" title="${groupIdHelptext}" text="Group Id" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-helpText" title="${helpTextHelptext}" text="Help Text" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-id" title="${alteridHelptext}" text="Id" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-javascript" title="${javascriptHelptext}" text="Javascript" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-label" title="${labelHelptext}" text="Label" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-legend" title="${legendHelptext}" text="Legend" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-length" title="${lengthHelptext}" text="Length" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-maxEntries" title="${maxEntriesHelptext}" text="Max. Entries" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-maxLength" title="${maxLengthHelptext}" text="Max. Length" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-message" title="${messageHelptext}" text="Message" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-messageClassFilter" title="${messageClassFilter}" text="Message Class Filter" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-minEntries" title="${minEntriesHelptext}" text="Min. Entries" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-minLength" title="${minLengthHelptext}" text="Min. Length" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-optionListReferenceTag" title="${optionListReferenceTagHelptext}" text="Optionlist ReferenceTag" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-readonly" title="${readonlyHelptext}" text="Readonly" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-required" title="${requiredHelptext}" text="Required" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-styleClass" title="${styleClassHelptext}" text="Style Class" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-suppressMessageDisplay" title="${suppressMessageDisplayHelptext}" text="Suppress Message Display" classname="addNew addNewProperty"/>
			<tkmenu:menuOption id="${propertyPath}_alter-title" title="${titleHelptext}" text="Title" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-validation" title="${validationHelptext}" text="Validation" classname="addNew addNewProperty"/> 
			<tkmenu:menuOption id="${propertyPath}_alter-value" title="${valueHelptext}" text="Value" classname="addNew addNewProperty"/>			
		</tkmenu:menuDropDown>
		</tkmenu:menuPill>	
		<tkmenu:menuPill id="${path}_movePill">
			<tkmenu:menuButton id="${path}_copyFieldElement" title="Copy this Behavior" text="Copy" classname="copy_event"/>
		</tkmenu:menuPill>	 
</div>