<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal"%>
<tk:menuPill id="${param.productId}_${param.artifactType}_artifactPill">
	<tk:menuButton id="${param.productId}_${param.artifactType}_addbutton"
		title="Add ${param.artifactType}" text="Add"
		classname="primary addable addArtifact ${param.artifactType}" />
	<tk:menuButton
		id="${param.productId}_${param.artifactType}_importbutton"
		title="Import ${param.artifactType}" text="Import"
		classname="addable addArtifactFromXML" />
</tk:menuPill>