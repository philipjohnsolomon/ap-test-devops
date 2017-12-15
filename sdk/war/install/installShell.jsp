<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<c:set var="installBundleName" value="installer"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>${ap:getResourceBundleValue(installBundleName, 'installer.title', '')}</title>
	
		<link href='${CONTENT_PREFIX}install/themes/style.css' rel='stylesheet' type='text/css' />
		<link href='http://fonts.googleapis.com/css?family=Droid+Sans' rel='stylesheet' type='text/css' />

		<script src="${pageContext.request.contextPath}/assets/js/agencyportal.js" type="text/javascript"></script>	
	</head>
	<body>

		<ap:ap_rb_loader  rbname="installer" />
		
		<form id="js_controls" name="js_controls">
			<input type="hidden" name="submitted" id="submitted" value="no" disabled="disabled" />
			<input type="hidden" name="message_delay" id="message_delay" value="" disabled="disabled" />					
		</form>
				
		<div id="installer">
		
			<div id="message" style="display:none">
				<span id="message_text">${ERROR_MESSAGE}</span>
			</div>
			
			<div id="body">
			
				<div id="build_stamp">version ${VERSION_NUMBER}</div>				
			
				<div id="navigation">
				
					<ul>
						<li id="pageOne" class="menu_item">${ap:getResourceBundleValue(installBundleName, 'installer.menu.page.one', '')}</li>
						<li id="pageTwo" class="menu_item">${ap:getResourceBundleValue(installBundleName, 'installer.menu.page.two', '')}</li>
						<li id="pageThree" class="menu_item">${ap:getResourceBundleValue(installBundleName, 'installer.menu.page.three', '')}</li>
						<li id="pageFour" class="menu_item">${ap:getResourceBundleValue(installBundleName, 'installer.menu.page.four', '')}</li>
					</ul>
				
				</div>
			
				<div class="contents">		
					<jsp:include page="${NEXT_PAGE}"  flush="true" />
				</div>
			
			</div>
		
		</div>
	</body>
</html>