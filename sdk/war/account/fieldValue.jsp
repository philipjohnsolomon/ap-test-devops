<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${param.fvalue != ''}">${param.fvalue}</c:when>
	<c:otherwise>${param.noneLabel}</c:otherwise>
</c:choose>		