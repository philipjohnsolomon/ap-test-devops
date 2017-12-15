<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:tk="http://www.agencyportal.com/toolkit">
<head>
	<title>AgencyPort Toolkit</title>

	<style type="text/css" title="Default Toolkit Theme">
        @import "toolkit/javascript/dojotoolkit/dojo/resources/dojo.css";
        @import "toolkit/javascript/dojotoolkit/dijit/themes/tundra/tundra.css";
		@import "toolkit/themes/style.css";
	</style>
	<style type="text/css">
            body, html { font-family:helvetica,arial,sans-serif; font-size:90%; }
        </style>
        <style type="text/css">
            html, body { width: 100%; height: 100%; margin: 0; }
        </style>
		<style type="text/css">		  
		  #mainContainer {
			width: 100%;
			height: 95%;
			margin: 0;
		  } 

        </style>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

 	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/dojotoolkit/dojo/dojo.js?${versionNumber}" djConfig="parseOnLoad:true, isDebug:false"></script>
 	<%-- the line below will contain all necessary dojo dijit widgets either inline or as require statements if in source mode --%>
 	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/dojotoolkit/apdojotoolkit.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/toolkit.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/behaviorEditor.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/viewEditor.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/dynamicListEditor.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/optionListEditor.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/tdfEditor.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/xarcruleEditor.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/ruleWizard.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/propertiesWizard.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/navigationMenu.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/coversEditor.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/dialogBox.js?${versionNumber}"></script>
	<script type="text/javascript" src="${webContentPrefix}toolkit/javascript/workItemAssistantEditor.js?${versionNumber}"></script>
</head>

<body>

	<div id="header">
		<a href="${backButtonPath}" title="Now Leaving the Land of the Luchadore"><span>&lt;&lt; Back</span></a>
		<div id="version_stamp">luchador v.${versionNumber}</div>
	</div>
	<div id="mainContainer">
            <div id="navMenu_WrapperDiv" >
				<div id="menuPane">
					<div id="navMenu"></div>
				</div>
            </div>
            <div id="pleaseWait" style="display: none; top: 2px;">Loading...</div>
			<div id="saving" style="display: none; top: 2px;">Saving...</div>
            <div id="editorPane">
            	<form id="editorForm"> 
            		<div id="editorWrapper"></div>
            	</form>
			</div>
	</div>

	<script type="text/javascript">
			dojo.addOnLoad(function() {
				ap.layoutManager = new LayoutManager();
				ap.master = null;
				ap.toolkitNavMenu = new NavigationMenu('${param.focusId}');
				ap.toolkitNavMenu.prepare();
				ap.layoutManager.navMenuPane.startup();
				ap.layoutManager.mainContainer.resize();
				dojo.connect(window, "resize", null, function() {
					ap.layoutManager.mainContainer.resize();
				});
			});


			window.onbeforeunload = function () {
				if (ap.master && ap.master.hasUnsavedChanges) {
					return 'There are unsaved changes. Are you sure you want to leave anyway?';
				} else {
					return;
				}
			};

			//on unload we destroy the menu and anything else left over
			dojo.addOnWindowUnload(function() {
				ap.destroy();
			});

			ap.destroy = function() {
				if(ap.layoutManager) {
					ap.layoutManager.destroy();
					ap.layoutManager = null;
				}
				if(ap.standby) {
					ap.standby = null;
				}
				if(ap.toolkitNavMenu) {
					ap.toolkitNavMenu.destroy();
					ap.toolkitNavMenu = null;
					ap.master = null;
					ap.AjaxManager = null;
					ap = null;
				}
			};
			// trick consoleInfo into working
			
			var debugConsole = {};

		</script>
</body>
</html>
