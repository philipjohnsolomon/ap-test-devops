<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${param.validationPath}"/>

<tkmenu:menuOption id="${path}_addValidation-dateCompare" title="Add Date Compare Validation" text="Date Compare" classname="addNew"/>