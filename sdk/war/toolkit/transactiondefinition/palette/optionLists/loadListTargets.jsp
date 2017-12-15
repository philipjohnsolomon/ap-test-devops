<%@page import="com.agencyport.toolkit.data.ArtifactDataProvider"%>
<%@page import="com.agencyport.domXML.APDataCollection"%>
<%@page import="com.agencyport.toolkit.data.SearchManager"%>
<%@page import="com.agencyport.webshared.IWebsharedConstants"%>
<%@page import="com.agencyport.toolkit.data.util.ArtifactDataProviderFactory"%>
<%
	String product = request.getParameter("product");
	String artifactId = request.getParameter("artifactId");
	String reader = request.getParameter("reader");
	String source = request.getParameter("source");
	ArtifactDataProvider tdfProvider = ArtifactDataProviderFactory.createArtifactDataProvider(artifactId, product);
	APDataCollection artifactData = (APDataCollection)request.getAttribute(IWebsharedConstants.APDATACOLLECTION);
	if(artifactData == null) {
		artifactData = tdfProvider.getArtifactDataCollection();
	}
	
	SearchManager searchManager = new SearchManager(tdfProvider);
	String optionListTarget = searchManager.getOptionListTarget(reader, source, "");	
%>
<%=optionListTarget%>