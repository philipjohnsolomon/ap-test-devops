<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="listData" class="com.agencyport.toolkit.data.search.OptionListData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="optionListPath" value="${path}.optionList"/>

<div class="selectlists scrollTable requiresOne" >
	<table>
		<thead>
			<tr>
				<th class="header_column">Type</th>
				<th class="header_column">Collection</th>
				<th class="header_column">List</th>
				<th class="header_column">Actions</th>
			</tr>
		</thead>
		<tbody id="${optionListPath}" class="">

			<c:forEach var="index" begin="1" step="1" end="${listData.count}">
				
				<jsp:setProperty name="toolkitData" property="currentIndex" value="${index-1}"/>
				<jsp:setProperty name="toolkitData" property="basePath" value="${optionListPath}[${index-1}]"/>
				
				<jsp:include page="optionList.jsp" />
			
			</c:forEach>
			<jsp:setProperty name="toolkitData" property="basePath" value="${path}"/>
		</tbody>
		<tfoot>
			<tr>
				<td>
					
				</td>
			</tr>
	  	</tfoot>
	 </table>
</div>
		