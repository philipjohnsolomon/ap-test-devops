<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${param.validationPath}"/>

<tkmenu:menuOption id="${path}_addValidation-alphanumeric" title="Add Alphanumeric Validation" text="Alphanumeric" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-format" title="Add Regular Expression Validation" text="Regular Expression" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-length" title="Add Length Validation" text="Length" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-maxLength" title="Add Maximum Length Validation" text="Max Length" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-minLength" title="Add Minimum Length Validation" text="Min Length" classname="addNew"/>