<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="messagePath" value="${param.path}[${toolkitData.currentIndex}]" />
<c:set var="messageTextPath" value="${messagePath}.text" />
<c:set var="messageText" value="${tk:getFieldValue(toolkitData, messageTextPath, '(Please enter a message)')}"/>
<c:set var="viewType" value="${param.viewType}"/>
<c:set var="evenOddClass" value="${tk:getEvenOddClass(toolkitData.currentIndex)}"/>

<tr id="${messagePath}" class="${evenOddClass} message_tr palette_toggle needs_palette" >
	<td>
		<span>
			<span id="${messagePath}_displayText" class="displayText underline">${messageText}</span>
			<span>				
				<input type="hidden" id="${messagePath}_type" value="message" />
			</span>	
		</span>	
	</td>	
</tr>
