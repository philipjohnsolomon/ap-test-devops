<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>

	<td id="${basePath}" class="join_info palette_toggle needs_palette joinInfo">
		<input type="hidden" id="${basePath}_type" value="joinInfo"/>
		<p id="${basePath}_joinInfo">
			<span id="${basePath}_span">Join</span>
		</p>
	</td>
