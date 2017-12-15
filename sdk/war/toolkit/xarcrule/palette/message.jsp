<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="messagePath" value="${path}.text"/>
<c:set var="messageSeverityPath" value="${path}.@severity"/>
<c:set var="showMultiplesPath" value="${path}.@showMultiple"/>
<c:set var="messageClassPath" value="${path}.@messageClass"/>

<tk:basePalette path="${path}">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
	</tk:tabs>
	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="false"/>
		<tk:textarea path="${messagePath}"
				label="Display Message"
				fieldValue="${tk:getFieldValue(toolkitData,messagePath,'')}"
				required="*"
				defaultValue=""
				size="40"
				elementName="${messagePath}"
				className="change_event accordion_update"
				helptext="xarc_helptext|displaymessage">
			</tk:textarea>
			<tk:select path="${messageSeverityPath}"
				label="Message Severity"
				elementName="${messageSeverityPath}"
				required="*"
				helptext="xarc_helptext|messageseverity"
				className="message_editor">
				<c:out value="${tk:getOptionsHTML(toolkitData, 'messageSeverity', messageSeverityPath, '')}" escapeXml="false"/>
			</tk:select>
			<tk:select path="${showMultiplesPath}"
				label="Show Multiple Messages"
				elementName="${showMultiplesPath}"
				required="*"
				helptext="xarc_helptext|showduplicatemessages"
				className="message_editor">
				<c:out value="${tk:getOptionsHTML(toolkitData, 'noYesFalse', showMultiplesPath, '')}" escapeXml="false"/>
			</tk:select>

			<tk:textarea path="${messageClassPath}"
				label="Message Class"
				fieldValue="${tk:getFieldValue(toolkitData,messageClassPath,'')}"
				required=""
				defaultValue=""
				size="40"
				elementName="${messageClassPath}"
				className="message_editor">
			</tk:textarea>
	</tk:tabContent>
</tk:basePalette>