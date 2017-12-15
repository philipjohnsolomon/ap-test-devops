<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="listPath" value="${toolkitData.basePath}"/>
<c:set var="optionPath" value="${toolkitData.basePath}.option" />
<div class="accordion_inner">
	<fieldset id="${listPath}_containerLegend" class="fieldSet">
		<legend id="${listPath}_legend" class="fieldSet_legend">
			Option List Entries
		</legend>
		<div id="${listPath}_content" class="">
			<div id="${listPath}_options">
				<input type="hidden" class="_childClassName" value="fieldSet"></input>
				<table>
					<thead>
						<tr>
							<th>Order</th>
							<th>Value</th>
							<th>Display Value</th>
							<th></th>
						</tr>
					</thead>
					<tbody id="${optionPath}_fields_container" >
						<c:forEach var="fieldIndex" begin="1" step="1" end="${tk:getCount(toolkitData, optionPath)}">
							<jsp:setProperty property="currentIndex" name="toolkitData" value="${fieldIndex - 1}"/>
							<jsp:include page="optionListFields.jsp">
				 				<jsp:param name="path" value="${optionPath}"></jsp:param>
							</jsp:include>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</fieldset>
</div>

