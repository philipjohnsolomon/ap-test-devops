<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<div id="wizard">
	<div id="contextAction" class="context_action">
		<div id="status_message" style="display: none"><span></span></div>
			<jsp:include page="${menu}"/>
	</div>
	<div id="editor">
		<tk:header/>
		<div id="editor_inner">
			<jsp:include page="${editor}"/>
		</div>
	</div>
	<div id="paletteContainer">
		<div class="paletteContainer" id="${param.artifactId}_paletteContainer">
			<jsp:include page="${palette}"/>
		</div>
	</div>
</div>
