<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<c:set var="installBundleName" value="installer"/>

<div class="template_install page">
		
	<h1>${ap:getResourceBundleValue(installBundleName, 'installer.page.three.title', '')}</h1>

	${ap:getResourceBundleValue(installBundleName, 'installer.page.three.section.one', '')}

	<form id="add_templates" name="add_template" 
		action="Install?type=import&amp;page=installTemplates"  
		method="POST" 
		enctype="multipart/form-data" >

		<input type=hidden id="pageId" value="pageThree" />	
		
		<div class="add_new_template section">
			<label for="importFile">${ap:getResourceBundleValue(installBundleName, 'installer.template.select.legend', '')}</label>
			<input type="file" name="importFile" id="importFile"/>
			<input type="button" class="button small" value="${ap:getResourceBundleValue(installBundleName, 'installer.button.import', '')}" onClick="return ap.installerPage.uploadTemplate();" id="GO"/>
		</div>
	</form>	
	
	<div class="installed_templates section">
		<h3>${ap:getResourceBundleValue(installBundleName, 'installer.template.installed.templates.table.title', '')}</h3>
		<table class="templates">
			<thead>
					<tr class="headerRow">
						<th>
							${ap:getResourceBundleValue(installBundleName, 'installer.template.installed.product', '')}
						</th>
						<th>
							${ap:getResourceBundleValue(installBundleName, 'installer.template.installed.version', '')}
						</th>	
					</tr>
				</thead>
			<tbody id="message_center_inbox_messages">
				<c:forEach items="${INSTALLED_PRODUCTS}" var="current">
     				<tr>
						<td class="title"><c:out value="${current.title}" /></td>
						<td><c:out value="${current.version}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<form name="continue" action="Install?type=finished" method="POST">
		<input type=hidden id="pageId" value="pageThree" />		
		<input type="submit" class="button" value="${ap:getResourceBundleValue(installBundleName, 'installer.button.next', '')}" id="NEXT"/>
	</form>
	
</div>
<script type="text/javascript">
$( document ).ready(function() {
	ap.installerPage.initPage();
});
</script>