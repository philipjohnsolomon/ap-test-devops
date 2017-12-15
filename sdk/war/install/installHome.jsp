<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<c:set var="installBundleName" value="installer"/>

<div class="getting_started page">
	<form name="input" action="Install?type=configure&amp;page=installHome"  method="POST">

		<input type="hidden" name="pageId" id="pageId" value="pageOne"/>
			
		<h1>${ap:getResourceBundleValue(installBundleName, 'installer.page.one.title', '')}</h1>
	
		${ap:getResourceBundleValue(installBundleName, 'installer.page.one.section.one', '')}
	
		<input type="submit" class="button" value="${ap:getResourceBundleValue(installBundleName, 'installer.button.next', '')}" id="NEXT"/>

	</form>
</div>

<script type="text/javascript">
$( document ).ready(function() {
	ap.installerPage.initPage();
});
</script>