<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="variablePath" value="${param.path}.step.selectNodes.variables.variable"/>
<c:set var="conditionPath" value="${param.path}.step.selectNodes.where"/>
<c:set var="messagePath" value="${param.path}.action.message"/>

<div class="accordion_inner">

<div id="${param.path}_ruledetails_div">
	<div id="${param.path}.step.selectNodes.variables.variable_variable" class="rule_sub_container">
		<input type="hidden" id="${param.path}.step.selectNodes.variables.variable_type" value="variable" />
		<table>
			<thead>
				<tr id="${param.path}.step.selectNodes.variables.variable_header" class="super_header">
					<th colspan="3">Variables</th>
				</tr>
				<tr>
					<th class="orderHeader">Order</th>
					<th>Name</th>
					<th>Scope</th>
				</tr>
			</thead>			
			<tbody id="${param.path}.step.selectNodes.variables.variable_variableContainer" class="sortable_container">
			 	<c:forEach var="variableIndex" begin="1" step="1" end="${tk:getCount(toolkitData, variablePath)}">
			 		<jsp:setProperty property="currentIndex" name="toolkitData" value="${variableIndex - 1}"/>		
					<jsp:include page="variables.jsp">	
						<jsp:param name="path" value="${variablePath}"></jsp:param>
					</jsp:include>	
				</c:forEach>	
			</tbody>
		</table>
		<div class="rule_sub_container_actions">
			<jsp:include page="../menu/variables.jsp">	
				<jsp:param name="path" value="${variablePath}"></jsp:param>
			</jsp:include>
		</div>		
	</div>

	<div id="${param.path}_conditions" class="rule_sub_container">								
		<table>
			<thead>
				<tr id="${param.path}.step.selectNodes.where" class="super_header">
					<th colspan="4">Conditions</th>
				</tr>									
				<tr>
					<th class="orderHeader">Order</th>
					<th>Operand</th>
					<th>Operator</th>
					<th>Operand</th>
				</tr>
			</thead>
			<tbody id="${param.path}.step.selectNodes.where_conditionContainer" class="sortable_container">

				<c:set var="conditionCount" value="${tk:getCount(toolkitData, conditionPath)}"/>	
				
				<c:if test="${(conditionCount=='0')}">	
					<jsp:setProperty property="currentIndex" name="toolkitData" value="${conditionCount}"/>
					<jsp:include page="whereconditions.jsp">	
						<jsp:param name="path" value="${conditionPath}"></jsp:param>
					</jsp:include>	
				</c:if>		
				 	
			 	<c:forEach var="conditionIndex" begin="1" step="1" end="${conditionCount}">
					<jsp:setProperty property="currentIndex" name="toolkitData" value="${conditionIndex-1}"/>			 			
					<jsp:include page="whereconditions.jsp">
						<jsp:param name="path" value="${conditionPath}"></jsp:param>
					</jsp:include>
				</c:forEach>	
										
			</tbody>
		</table>
		<div class="rule_sub_container_actions">
			<jsp:include page="../menu/condition.jsp">	
				<jsp:param name="path" value="${conditionPath}"></jsp:param>
			</jsp:include>
		</div>			
	</div>
	
	<div id="${param.path}_message" class="rule_sub_container">
		<input type="hidden" id="${param.path}.action.message_type" value="message"></input>
		<table>
			<thead>
				<tr id="${param.path}.action.message" class="super_header">
					<th colspan="2">Messages</th>
				</tr>
			</thead>
			<tbody id="${param.path}.action.message_messageContainer" class="sortable_container">
		
			 	<c:set var="messageCount" value="${tk:getCount(toolkitData, messagePath)}"/>	
				
				<c:if test="${(messageCount=='0')}">	
					<jsp:setProperty property="currentIndex" name="toolkitData" value="0"/>
					<jsp:include page="message.jsp">
						<jsp:param name="path" value="${messagePath}"></jsp:param>
					</jsp:include>
				</c:if>		
	
			 	<c:forEach var="messageIndex" begin="1" step="1" end="${messageCount}">		
					<jsp:setProperty property="currentIndex" name="toolkitData" value="${messageIndex-1}"/>
					<jsp:include page="message.jsp">	
						<jsp:param name="path" value="${messagePath}"></jsp:param>
					</jsp:include>
				</c:forEach>	
			</tbody>
		</table>
		<div class="rule_sub_container_actions">
			<jsp:include page="../menu/messages.jsp">	
				<jsp:param name="path" value="${messagePath}"></jsp:param>
			</jsp:include>
		</div>			
	</div>								
</div>