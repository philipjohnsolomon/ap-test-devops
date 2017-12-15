<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<c:set var="installBundleName" value="installer"/>
		
<div class="install_error page">
	<a href="DisplayLogonForm" >${ap:getResourceBundleValue(installBundleName, 'installer.display.logon.link', '')}</a>
</div>
