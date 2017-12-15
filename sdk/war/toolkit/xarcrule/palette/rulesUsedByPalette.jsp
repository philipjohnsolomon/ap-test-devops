<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="pageData" class="com.agencyport.toolkit.data.search.PageEntitySearchData" scope="request"/>

<c:set var="helptext" value="${tk:getOptionsListValue('crossReference_helptext', 'tdf')}"/>	

<c:if test="${not empty param.entity}">				
	<c:set var="helptext" value="${fn:replace(helptext,'Entity',param.entity)}"/>
</c:if>

<input type="hidden" class="_numberImplementations" value="${pageData.pageResultsCount}" />
<div class = "selectlists">
	<table class="fullTable">
		<thead>
			<tr class="palette_table">
				<th class="header_column"><acronym title="${helptext}">Source</acronym></th>
				<th class="header_column"><acronym title="${helptext}">Page</acronym></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultsIndex" begin="1" step="1" end="${pageData.pageResultsCount}">  
				<c:set var="result" value="${pageData.pageResults[resultsIndex-1]}"/>
				<tr id="${result.toolkitIdentifyingXpath}_reference" class="tdf_crossReference crossReference">
					<td class="transaction">
						<input type="hidden" id="${result.toolkitIdentifyingXpath}_artifactId" value="${result.artifactId}" class="artifactId"/>
						<input type="hidden" id="${result.toolkitIdentifyingXpath}_productId" value="${result.productId}" class="productId"/>
						${result.artifactTitle}
					</td>
					<td class="page">${result.pageTitle}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>