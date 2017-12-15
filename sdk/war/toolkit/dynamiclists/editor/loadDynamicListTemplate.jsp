<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="listPath" value="${toolkitData.basePath}"/>
<c:set var="fieldPath" value="${toolkitData.basePath}.field" />
<div class="accordion_inner">
	<fieldset id="${listPath}_containerLegend" class="fieldSet">
		<legend id="${listPath}_legend" class="fieldSet_legend">
			Dynamic List Fields
		</legend>
		<div id="${listPath}_content" class="">
			<div id="${listPath}_fieldset">
				<input type="hidden" name="SP.INDEX.${listPath}" id="SP.INDEX.${listPath}" value="${listPath}"></input>
				<input type="hidden" name="${listPath}.@delete" id="${listPath}.@delete" value="<%="false"%>"></input>

				<p>The following values will be concatenated into a single string that serves as the display value for the user</p>
				<table>
					<thead>
						<tr>
							<th class="fieldTypeCol">Type</th>
							<th class="fieldValueCol">Value</th>
							<th class="fieldMenuCol"></th>
						</tr>
					</thead>
					<tbody id="${fieldPath}_fields_container" >
						<c:forEach var="fieldIndex" begin="1" step="1" end="${tk:getCount(toolkitData, fieldPath)}">
							<jsp:setProperty property="currentIndex" name="toolkitData" value="${fieldIndex - 1}"/>
							<jsp:include page="/toolkit/dynamiclists/editor/dynamicListFields.jsp">
								<jsp:param name="path" value="${fieldPath}"></jsp:param>
							</jsp:include>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</fieldset>
</div>