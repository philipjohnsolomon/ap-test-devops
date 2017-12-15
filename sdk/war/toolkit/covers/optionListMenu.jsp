<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal"%>
<tk:menuPill id="${param.productId}_${param.artifactType}_artifactPill">
	<tk:menuDropDown
		id="${param.productId}_${param.artifactType}_artifactAddPill"
		title="Add" text="Add List">
		<tk:menuOption id="${param.productId}_${param.artifactType}_addbutton"
			title="Add ${param.artifactType}" text="Option List"
			classname="primary addable addArtifact ${param.artifactType}" />
		<tk:menuOption id="${param.productId}_dynamicListTemplate_addbutton"
			title="Add dynamicListTemplate" text="Dynamic List"
			classname="primary addable addArtifact dynamicListTemplate" />
	</tk:menuDropDown>
	<tk:menuDropDown
		id="${param.productId}_${param.artifactType}_artifactImportPill"
		title="Import" text="Import List">
		<tk:menuOption
			id="${param.productId}_${param.artifactType}_importbutton"
			title="Import ${param.artifactType}" text="Option List"
			classname="addable addArtifactFromXML" />
		<tk:menuOption
			id="${param.productId}_dynamicListTemplate_importbutton"
			title="Import dynamicListTemplate" text="Dynamic List"
			classname="addable addArtifactFromXML" />
	</tk:menuDropDown>
</tk:menuPill>