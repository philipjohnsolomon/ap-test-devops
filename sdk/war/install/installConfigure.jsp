<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<c:set var="installBundleName" value="installer"/>

<div class="database_setup page">
	<form id="configure_db" name="input" 
		action="Install?type=dbSelect&amp;page=installConfigure"  
		method="POST">
		
		<input type="hidden" id="pageId" value="pageTwo"/>

		<h1>${ap:getResourceBundleValue(installBundleName, 'installer.page.two.title', '')}</h1>
		
		${ap:getResourceBundleValue(installBundleName, 'installer.page.two.section.one', '')}
		
		<div id="pageSelect">
			<select id="dbType" name="dbType" class="database_type">
				<option value="">Select One</option>
				<option value="sqlserver">SQLServer</option>
				<option value="db2">DB2</option>
				<option value="db29">DB2 XML</option>
				<option value="oracle">Oracle</option>
				<option value="mysql">MySql</option>
			</select>
		</div>
	
		${ap:getResourceBundleValue(installBundleName, 'installer.page.two.section.two', '')}
		
		<input type="button" class="button" value="${ap:getResourceBundleValue(installBundleName, 'installer.button.next', '')}" onclick="return ap.installerPage.configureDatabase();" id="NEXT"/>
		
	</form>
</div>
	
<script type="text/javascript">
$( document ).ready(function() {
	ap.installerPage.initPage();
});
</script>
	