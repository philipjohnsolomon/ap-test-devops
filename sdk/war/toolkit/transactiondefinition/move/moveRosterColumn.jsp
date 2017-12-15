<%@page import="com.agencyport.toolkit.data.MoveManager"%>
<%@page import="com.agencyport.toolkit.data.ArtifactDataProvider"%>
<%@page import="com.agencyport.toolkit.data.util.ArtifactDataProviderFactory"%>
<%@page import="com.agencyport.toolkit.data.SearchResult"%>
<%@page import="com.agencyport.product.EntityType"%>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getParameter("path");
	String type = request.getParameter("type");
	String product = request.getParameter("product");
	String artifactId = request.getParameter("artifactId");
	ArtifactDataProvider dataProvider = ArtifactDataProviderFactory.createArtifactDataProvider(artifactId, product);
	
	String orderPath = path + ".@order";
	String moveToPath = path + ".@movePath";
	
	MoveManager moveManager = new MoveManager(dataProvider);
	SearchResult<String> searchResult = moveManager.getTransactionPages(path, null, EntityType.PAGE_ELEMENT);
%>
<div id="<%=path%>_<%=type%>_moveLightBox" class="toolkitLightbox">
		<fieldset class="standardForm">
			<legend>Move</legend>
			<div id="<%=path%>_formRow" class="formRow ">
				<label class="label" id="<%=path%>_labelElement" for="<%=path%>">
					<span id="<%=path%>_required">*</span>
					<span id="<%=path%>_labelText">Move</span>
				</label>
				<span>
					<select name="<%=orderPath%>" id="<%=orderPath%>" class="" >
						<option value="before">Before</option>
						<option value="after">After</option>
					</select>
				</span>
			</div>
			<div id="<%=moveToPath%>_formRow" class="formRow">
				<label class="label" id="<%=moveToPath%>_labelElement" for="<%=moveToPath%>">
					<span id="<%=moveToPath%>_required">*</span>
					<span id="<%=moveToPath%>_labelText">Page</span>
				</label>
				<span>
					<select name="<%=moveToPath%>" id="<%=moveToPath%>" class="" >
					<%=searchResult.getRealResult()%>
					</select>
				</span>
			</div>
		</fieldset>
		<div class="buttons">
			<tk:menuPill id="${param.path}_buttons">
				<tk:menuButton id="${param.path}_${param.type}_moveLightBox_move" title="Move the Page" text="Move" classname="primary movePage_event left"/>
			</tk:menuPill>
		</div>
</div>