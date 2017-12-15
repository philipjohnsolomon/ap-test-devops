<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="${param.path}_${param.type}_moveLightBox" class="toolkitLightbox">
<p>Moving will save your work.  If you do not wish to save your work please close the window.</p>

	<div class="buttons">
		<tk:menuPill id="${param.path}_buttons">
			<tk:menuButton id="${param.path}_${param.type}_moveLightBox_move" title="Move the Page" text="Move" classname="primary movePage_event left"/>
		</tk:menuPill>
	</div>
</div>