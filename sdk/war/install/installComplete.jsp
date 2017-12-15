<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<c:set var="installBundleName" value="installer"/>

<div class="wrap_up page">

	<h1>${ap:getResourceBundleValue(installBundleName, 'installer.page.four.title', '')}</h1>
	
	${ap:getResourceBundleValue(installBundleName, 'installer.page.four.section.one', '')}

	${ap:getResourceBundleValue(installBundleName, 'installer.page.four.section.two', '')}
	

	<form method="post" action="DisplayLogonForm">
		<div class="section">
			<input type=hidden id="pageId" value="pageFour"/>
			<label for="restarted">${ap:getResourceBundleValue(installBundleName, 'installer.page.four.confirmation.label', '')}</label><input type="checkbox" id="restarted" name="restarted" value="" onclick="ap.installerPage.showFinalButton()" />
		</div>
		<div class="final_button section" id="final_button" style="display: none" >
			<input type="submit" class="button" value="${ap:getResourceBundleValue(installBundleName, 'installer.page.four.logon.link', '')}"  />
		</div>		
	</form>
	
</div>

<script type="text/javascript">
$( document ).ready(function() {
	ap.installerPage.initPage();
});
</script>