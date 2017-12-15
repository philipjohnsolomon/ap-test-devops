<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${param.validationPath}"/>

<tkmenu:menuOption id="${path}_addValidation-verifyListSelection" title="Add Verify List Selection Validation" text="Verify List" classname="addNew"/>