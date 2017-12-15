<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal"%>
<div id="wizard" >
	<div id="editor_wrapper">
		<div id = "contextAction" class="context_action">
			<div id="product_menu" style="" class="menu">
				<jsp:include page="${menu}"/>
			</div>
		</div>
		<div id="editor_background">
			<div id="editor_shadow">
				<div id="editor">
					<div id="editor_inner">
						<jsp:include page="${editor}">
							<jsp:param name="artifactTitle" value="${ResourceTitle}" />
						</jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
