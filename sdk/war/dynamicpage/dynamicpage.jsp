<!--BEGIN STANDARD FRAMEWORK -->
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<%@ page import="com.agencyport.menu.Menu" %>
<%@ page import="com.agencyport.menu.IMenuConstants" %>
<%@ page import="com.agencyport.pagebuilder.Page" %>
<%@ page import="com.agencyport.jsp.JSPHelper" %>
<%@ page import="com.agencyport.locale.IResourceBundle" %>
<%@ page import="com.agencyport.locale.ResourceBundleManager" %>
<%@ page import="com.agencyport.locale.ILocaleConstants" %>
<%@ page import="com.agencyport.workitem.model.IWorkItem" %>
<%@ page import="com.agencyport.turnstile.SnippetData" %>
<%@ page import="com.agencyport.api.snippet.pojo.Coordinate" %>
<%@ page import="com.agencyport.html.elements.BaseElement" %>
<%@ page import="com.agencyport.html.elements.HiddenElement" %>
<%@ page import="com.agencyport.constants.TurnstileConstantsProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.net.URLEncoder" %>

<%
	JSPHelper jspHelper = JSPHelper.get(request);
	IResourceBundle rb = ResourceBundleManager.get()
			.getHTMLEncodedResourceBundle(
					ILocaleConstants.CORE_PROMPTS_BUNDLE);
	Page htmlPage = jspHelper.getPage();
	String pageId = htmlPage.getId();
	String subtype = htmlPage.getSubType();
	String pageTitle = htmlPage.getTitle();
	String styleClass = htmlPage.getStyleClass();
	boolean isReadOnly = htmlPage.isReadOnly();
	String readOnlyClass = "";
	if(isReadOnly){
		readOnlyClass = "read-only";
	}
	
	String multipart = "";
	if (subtype.equals("file")) {
		multipart = "ENCTYPE=\"multipart/form-data\"";
	}

	String processMethod = (String) request.getAttribute("METHOD");
	if (processMethod == null)
		processMethod = "Process";

	boolean showWorkItemAssistant = jspHelper.supportsWorkItemAssistant();
	
	Menu menu = (Menu) request.getAttribute(IMenuConstants.MENU);
	String nav_menu = "../site/submission_navigation_menu.jsp";
	
	Map<String, List<SnippetData>> snippetsMap = jspHelper.getSnippets(htmlPage);
	
	int lowConfidenceThreshold = TurnstileConstantsProvider.getLowConfidenceThresholdLevel();
	double pdfZoomRatio = TurnstileConstantsProvider.getSnippetsPDFZoomRatio();
	boolean pdfStartsOpen = TurnstileConstantsProvider.isPDFWindowOpenOnPageLoad();
%>

<jsp:include page="../shared/framework_ui.jsp" flush="true" />
	
<div id="transaction" class="container transaction">

	<!--div id="backtotop" class="back-to-top"><img src="assets/img/up-arrow.png" /><h4>Top</h4></div-->
	
	<div class="row">
	
		<div class="col-md-3" id="lower">
			<jsp:include page="<%=nav_menu%>" flush="true" />
		</div>

		<%
		if (showWorkItemAssistant) {
		%>		
		<div class="col-md-7 agencyportal-transaction">
		<%
		} else {
		%>		
		<div class="col-md-9 agencyportal-transaction">
		<%
		}
		%>	
			<div id="pageBody" class="<%=styleClass%>" style="display: none;">
		
				<jsp:include page="../shared/messageTemplate.jsp" flush="true" />
		
				<div id="dynamic_page_inner">
					<span id="transaction_content" class="dynamic_page_column left">
						<form action="FrontServlet" class="form-horizontal dataentry agencyportal-form animated fadeIn <%=readOnlyClass%>" id="<%=pageId%>" name="<%=pageId%>" method="post" <%=multipart%>>
							<ap:page/>
							<jsp:include page="../shared/accountEntities.jsp" flush="true" />
						</form>
					</span>
				</div>
			</div>

		</div>
		<%
		if (showWorkItemAssistant) {
		%>
			
		<div class="col-md-2 animated fadeIn" id="right-sidebar">
			<jsp:include page="../workitemassistant/workitemAssistant.jsp" flush="true" />
		</div>
		
		<%
		}
		%>
		
		<!-- snippet container -->
		<%
			if(!snippetsMap.isEmpty()){		
		%>
		<div class="snippet" id="snippet" style="display: block;">
			<div class="snippet-container" id="snippetContainer">
 				<div class="snippet-header">
					<button type="button" id="snippet-header-button" class="close<% if (!pdfStartsOpen){ %> collapsed<% } %>" data-toggle="collapse" data-target="#snippet-toggle" aria-expanded="false" aria-controls="snippet-body" title="Hide Uploaded PDF" onclick="redisplaySnippetWindow(this);"><i class="fa"></i></button>
				</div> 
				<div id="snippet-toggle" class="snippet-toggle collapse<% if (pdfStartsOpen){ %> in<% } %>">
				<%
					for(Map.Entry<String,List<SnippetData>> entry: snippetsMap.entrySet()){
						List<SnippetData> snippets = entry.getValue();
						String[] fileNamePageNum = entry.getKey().split("::");
				%>
					<div class="snippet-body image-container" id="snippet-body_<%=fileNamePageNum[0]%>_<%=fileNamePageNum[1]%>" style="display: none">
						<!-- 400x478 -->
							<img class="snippet-image" id="<%=fileNamePageNum[0]%>_<%=fileNamePageNum[1]%>" 
							src="SnippetImageRenderer?WORKITEMID=<%=jspHelper.getWorkItemId() %>&fileName=<%=URLEncoder.encode(jspHelper.prepareForJavaScript(fileNamePageNum[0]))%>&pageNumber=<%=jspHelper.prepareForJavaScript(fileNamePageNum[1])%>" 
							usemap="#map_<%=fileNamePageNum[0]%>_<%=fileNamePageNum[1]%>">
							<map name="map_<%=fileNamePageNum[0]%>_<%=fileNamePageNum[1]%>">
					<% 
							for(SnippetData snippet: snippets){
								BaseElement field = snippet.getReferringField();
								if(field instanceof HiddenElement || field.isExcluded()){
									continue;
								}
								for(Coordinate cord: snippet.getCoordinates()){
					%>
								<area class="all <%=field.getHTMLSafeId() %> <%=snippet.getSnippetId()%>" id="<%=snippet.getSnippetId()%>" 
								data-key="<%=snippet.getSnippetId()%>" shape="rect" coords="<%=cord.getX()%>,<%=cord.getY()%>,<%=cord.getX2()%>,<%=cord.getY2()%>" href="#" >
					<%	
								}
							}
					%>
							</map>
					</div>
					<%
						}
					%> 
				</div>
			</div>
		</div>
		
		<%
			}
		%>
		<!-- snippet container -->
		
	</div>
</div>

<jsp:include page="../home/footer.jsp" flush="true" />

<script type="text/javascript">

	<% if(!snippetsMap.isEmpty()) {	%>
	
		var zoomRatio = <%=pdfZoomRatio%>;
		var button_left_pos = 400;
		var sUsrAg = navigator.userAgent;
		var lastPageShown = 0;
		
		function redisplaySnippetWindow(element) {
			var allPages = $(".snippet-body");
			
			if ($(element).hasClass('collapsed')) {
				for (var i = 0; i < allPages.length; i++ ) {
					if (i == lastPageShown) {
						$(allPages[i]).show();
					}
					else{
						$(allPages[i]).hide();
					}
				}				
			}
			else {
				for (var j = 0; j < allPages.length; j++ ) {
					if ($(allPages[j]).css('display') == 'block') {
						lastPageShown = j;
						break;
					}
				}
			}
		}
	
		function isZoomed(element) {
			zoomed = false;
			style = $(element).attr('style');
			
			if (sUsrAg.indexOf("Firefox") > -1) {
				zoomed = style != null && (style.indexOf('transform') != -1);
			}
			else {
				zoomed = style != null && (style.indexOf('zoom') != -1);
			}
			
			return zoomed;
		}	
		
		function zoomIn(element) {			
			if (sUsrAg.indexOf("Firefox") > -1) {
				$(element).css('MozTransform', 'scale(' + zoomRatio + ')').css('MozTransformOrigin', '0.0');
				var top = zoomRatio * 100 - 28;
				$('.snippet-header').css('top', '-' + top + 'px');
			}
			else {
				$(element).animate({ 'zoom': zoomRatio }, 50);
			}
			
			$('.snippet-header').css('left', (button_left_pos * zoomRatio) + 'px');			
		}
		
		function clearZoom(element) {
			if (sUsrAg.indexOf("Firefox") > -1) {
				$('.snippet-header').css('top', '0px');
			}
			
			$(element).removeAttr('style');
        	$('.snippet-header').css('left', button_left_pos + 'px');			
		}
	
		$('.snippet-body').on('dblclick',
		    function() {
				style = $(this).attr('style');
				zoomed = isZoomed(this);
				if (zoomed) {
					clearZoom(this);
				}
				else {
					zoomIn(this);
				}
		    }
		);
		
		function hideSnippetWindow() {
			$("#snippet").removeAttr('style').css('width', '28px');
			$('.snippet-header').css('left', '28px').css('top', '0px');
			$('#snippet-header-button').attr('title', 'Show Uploaded PDF');
			$('.snippet-body').removeAttr('style');			
		}
	
		$('#snippet-toggle').on('hidden.bs.collapse', function(){
			hideSnippetWindow();
		});
		
		$('#snippet-toggle').on('show.bs.collapse', function(){
			$("#snippet").css('width', '400px');
			$('.snippet-header').css('left', button_left_pos + 'px');
			$('#snippet-header-button').attr('title', 'Hide Uploaded PDF');
		});	
		
		$("#snippet").draggable(); 
		
		<% if (!pdfStartsOpen){ %> 
			hideSnippetWindow();
		<% } %>
		
		page.setLowConfidenceThreshold(<%=lowConfidenceThreshold%>);
	<% } %>
	

	page.initialize();
</script>
