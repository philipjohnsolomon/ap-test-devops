<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>
<a id="${basePath}" class="fieldHelperBalloon palette_toggle needs_palette fieldHelper">
	<input type="hidden" id="${basePath}_type" value="balloonFieldHelper"/>
</a>