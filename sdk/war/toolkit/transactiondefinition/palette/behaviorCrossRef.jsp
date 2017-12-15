<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="behaviorData" class="com.agencyport.toolkit.data.search.BehaviorEntitySearchData" scope="request"/>

<c:set var="helptext" value="${tk:getOptionsListValue('crossReference_helptext','behavior')}" />

<c:if test="${not empty param.entity}">				
	<c:set var="helptext" value="${fn:replace(helptext,'Entity',param.entity)}"/>
</c:if>

<c:if test="${param.field=='true' && behaviorData.hotFieldResultsCount >0}">
	<div class = "selectlists hotFields">
		<table class="fullTable">
			<thead>
				<tr class="palette_table">
					<th class="header_column">Hot Field Identifier</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="resultsIndex" begin="1" step="1" end="${behaviorData.hotFieldResultsCount}">  
					<c:set var="result" value="${behaviorData.hotFieldResults[resultsIndex-1]}"/>
					
					<tr id="${result.toolkitIdentifyingXpath}_reference" class="behaviors_crossReference crossReference">
						<td class="transaction">
							<input type="hidden" id="${result.toolkitIdentifyingXpath}_artifactId" value="${result.artifactId}" class="artifactId"/>
							<input type="hidden" id="${result.toolkitIdentifyingXpath}_productId" value="${result.productId}" class="productId"/>
							${result.keyAsString}
						</td>	
					</tr>
		 		 </c:forEach>
			</tbody>
		</table>
	</div>
</c:if>
<div class = "selectlists behaviors">
	<table class="fullTable">
		<thead>
			<tr class="palette_table">
				<th class="header_column"><acronym title="${helptext}">Behavior Type</acronym></th>
				<th class="header_column"><acronym title="${helptext}">Behavior Title</acronym></th>
				<th class="header_column"><acronym title="${helptext}">Behavior Description</acronym></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultsIndex" begin="1" step="1" end="${behaviorData.behaviorResultsCount}">  
				<c:set var="result" value="${behaviorData.behaviorResults[resultsIndex-1]}"/>					
				<tr id="${result.toolkitIdentifyingXpath}_reference" class="behaviors_crossReference crossReference">
					<td class="transaction">
						<input type="hidden" id="${result.toolkitIdentifyingXpath}_artifactId" value="${result.artifactId}" class="artifactId"/>
						<input type="hidden" id="${result.toolkitIdentifyingXpath}_productId" value="${result.productId}" class="productId"/>
						${result.behaviorType}
					</td>
					<td class="behavior_title">${result.title}</td>
					<td class="description">${result.behaviorsDescription}</td>	
				</tr>
		 	 </c:forEach>
		</tbody>
	</table>
</div>