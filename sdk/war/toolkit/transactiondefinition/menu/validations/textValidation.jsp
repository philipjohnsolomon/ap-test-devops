<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${param.validationPath}"/>

<jsp:include page="textareaValidation.jsp" />
	
<tkmenu:menuOption id="${path}_addValidation-ACORDDateFormat" title="Add ACORD Date Format Validation" text="ACORD Date Format" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-dateCompare" title="Add Date Compare Validation" text="Date Compare" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-email" title="Add Email Validation" text="Email" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-fein" title="Add FEIN Validation" text="FEIN" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-maxValue" title="Add Maximum Value Validation" text="Max Value" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-minValue" title="Add Minimum Value Validation" text="Min Value" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-numeric" title="Add Numeric Validation" text="Numeric" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-phone" title="Add Phone Number Validation" text="Phone" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-ssn" title="Add SSN Validation" text="SSN" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-USDateFormat" title="Add US Date Format Validation" text="US Date" classname="addNew"/>
<tkmenu:menuOption id="${path}_addValidation-USZipCode" title="Add US Zip Code Validation" text="US Zip Code" classname="addNew"/>