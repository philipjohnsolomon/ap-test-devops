<%@ page import="java.util.Iterator,
	java.util.List,
	java.util.ArrayList,
	com.agencyport.domXML.Index,
	com.agencyport.data.DataManager,
	com.agencyport.data.IndexManager,
    com.agencyport.fieldvalidation.javascript.*,
    com.agencyport.html.elements.BaseElement,
    com.agencyport.html.elements.CheckboxElement,
    com.agencyport.jsp.JSPHelper,
    com.agencyport.pagebuilder.BasePageElement,
    com.agencyport.pagebuilder.PageScriptPageElement,
    com.agencyport.pagebuilder.Page,
    com.agencyport.utils.AppProperties,
    com.agencyport.trandef.Transaction,
    com.agencyport.menu.IMenuConstants,
    com.agencyport.trandef.provider.HotField,
    com.agencyport.html.elements.IHTMLConstants,
    com.agencyport.product.ProductDefinitionsManager,
    com.agencyport.trandef.provider.TransactionDefinitionProvider"%>
<% 
	JSPHelper jspHelper = JSPHelper.get(request);
	Page htmlPage = (Page)request.getAttribute("page");	
	if(null != htmlPage){
		Transaction tran = htmlPage.getOwningTransaction();
		boolean hasHotFields = htmlPage.containsHotFields();
		boolean hasDataAvailable = htmlPage.getVisitedState() == IMenuConstants.PAGE_VISISTED;
		boolean pageSupportsIPDTRDynamicContent = htmlPage.supportsIPDTRDynamicContent();
	
		TransactionDefinitionProvider tdp = tran.getTransactionDefinitionProvider();
		List<BasePageElement> pageElementList = htmlPage.getPageContent();
		List<BasePageElement> scriptElements = new ArrayList<BasePageElement>();
		List<BasePageElement> nonScriptElements = new ArrayList<BasePageElement>();
		Iterator<BasePageElement> pageElementIt = pageElementList.iterator();
		JavaScriptValidationManager javaScriptManager = new JavaScriptValidationManager(true);
		String versionNumber= ProductDefinitionsManager.getCurrentlyRunningVersion().toString();
	
		DataManager dataManager = jspHelper.getDataManager();
		IndexManager indexManager = dataManager.getIndexManager();
		// Establish index value (if applicable) that will be ultimately applied to java script page object
		String indexValue = null;
		if ( indexManager != null ){
			Index entry = indexManager.getLastEntry();
			if ( entry.hasIndexState()){
				indexValue = indexManager.buildXPathExpression(entry.getElementPath(), entry.getIdArray());
			}
		}
		if ( indexValue == null ) {
			BaseElement indexField = htmlPage.getIndexField();
			if ( indexField != null ){
				indexValue = indexField.getValue();
			}
		}
	
		String app = AppProperties.getAppProperties().getStringProperty("APPLICATION_NAME", "");
		while (pageElementIt.hasNext()){
			BasePageElement pageElement = pageElementIt.next();
			if(pageElement instanceof PageScriptPageElement){
				scriptElements.add(pageElement);
			}else{
				nonScriptElements.add(pageElement);
			}
		}
		
%>

    <input type="hidden" name="PAGE_NAME" id="PAGE_NAME" value="<%=htmlPage.getId()%>" />
    <input type="hidden" name="PAGE_READONLY" id="PAGE_READONLY" value="<%=htmlPage.isReadOnly()%>" />
	
	<script type="text/javascript">	

	ap.accoutInit<%=htmlPage.getId()%> = function() {	
	
		ap.page.fieldsets = null;
		ap.page.fieldsets = new Array();
		ap.page.form.clearFields();
		page.setId('<%=htmlPage.getId()%>');
		ap.account.clearFields();
		ap.page.setHasHotFields(<%=hasHotFields%>);
		ap.page.setCompoundKey("<%=htmlPage.getPageKey()%>"); 
		ap.page.setReadOnly(<%=htmlPage.isReadOnly()%>);
		ap.page.setHasDataAvailable(<%=hasDataAvailable%>);
		ap.page.setSupportsIPDTRDynamicContent(<%=pageSupportsIPDTRDynamicContent%>);
		page.setType('<%=jspHelper.getPageType()%>');
		<%if ( indexValue != null ) {%>
			page.setIndex("<%=indexValue%>"); 	 	
		<%}%>
		
		var currentField = null;	
		var fieldset = null;
	<%	
		Iterator<BasePageElement> nonScriptElementIt = nonScriptElements.iterator();
		while (nonScriptElementIt.hasNext()){
			BasePageElement pageElement = nonScriptElementIt.next();
			if ( !pageElement.supportedByJavaScriptBasedFieldSet() ){
				continue;
			}
			String pageElementId = pageElement.getUniqueId();
			int pageElementInterestLevel = pageElement.getInterestLevel();
			%>
				fieldset = new ap.Fieldset(ap.page, "<%=pageElementId%>", <%=pageElementInterestLevel%>);
			<%
			if ( !pageElement.isDataEntryType() ){
				continue;	
			}
			
			List<BaseElement> baseElementList = pageElement.getContent();
			Iterator<BaseElement> it = baseElementList.iterator();
			while ( it.hasNext() ){
				BaseElement baseEl = (BaseElement) it.next();
				String safeHtmlId = baseEl.getHTMLSafeId();
				String uniqueId = baseEl.getUniqueId();
				if (safeHtmlId == null || safeHtmlId.equals(""))
					continue;
				boolean isReadOnly = baseEl.isReadOnly();
				boolean isHot = baseEl.isHot();
				boolean autoInvokeAJAX = false;
				boolean blockDataEntry = false;
				if ( isHot ){
					HotField hotField = tdp.getHotField(baseEl.getFieldElementKey());
					if ( hotField != null ){
						autoInvokeAJAX = hotField.isAutoInvoke();
						blockDataEntry = hotField.isBlockDataEntry(); 
					}
				}
				String fieldType = baseEl.getType();
				if (fieldType == null || fieldType.startsWith("worksheet") ) 
					continue;
				else if ( pageSupportsIPDTRDynamicContent && baseEl.isExcluded())
					continue; 	
				
				int interestLevel = baseEl.getInterestLevel();
				String defaultValue = JSPHelper.prepareForJavaScript(baseEl.getDefaultValue());
				String originalValue = JSPHelper.prepareForJavaScript(baseEl.getOriginalValue());
				safeHtmlId = BaseElement.escapeJavaScriptCharacters(safeHtmlId, true);
				uniqueId = BaseElement.escapeJavaScriptCharacters(uniqueId, true);
				%>
				currentField = new ap.Field(ap.page.form, "<%=safeHtmlId%>", "<%=uniqueId%>", fieldset, <%=interestLevel%>, 
						"<%=fieldType%>", <%=isHot%>, <%=autoInvokeAJAX%>, <%=blockDataEntry%>, null, -1);
				
				ap.account.addField(currentField, '<%=htmlPage.getId()%>');		
				<%if(fieldType.equals(IHTMLConstants.TA_CHECKBOX)) {
					CheckboxElement checkBox = (CheckboxElement)baseEl;
					String uncheckedValue = JSPHelper.prepareForJavaScript(checkBox.getUncheckedValue());
					String checkedDisplayValue = JSPHelper.prepareForJavaScript(checkBox.getCheckedDisplayValue());
					String uncheckedDisplayValue = JSPHelper.prepareForJavaScript(checkBox.getUncheckedDisplayValue());
					%>
					currentField.setUncheckedValue("<%=uncheckedValue%>");
					currentField.setUncheckedDisplayValue("<%=uncheckedDisplayValue%>");
					currentField.setCheckedDisplayValue("<%=checkedDisplayValue%>");
					//need to set the current value after all values are set otherwise initial value is incorrect
					currentField.initalValue = currentField.getValue();
				<%
				}
				%>
				currentField.setReadOnly(<%=isReadOnly%>);
				<%if ( defaultValue != null ) {%>
					currentField.setDefaultValue("<%=defaultValue%>");
				<%}
				if ( originalValue != null ) {
				%>
					currentField.setOriginalValue("<%=originalValue%>");
				<%
				}
				if(baseEl.getFormatMaskElement() != null)  {
				%>
					currentField.initFormatmask(<%=baseEl.getFormatMaskElement().supportsMask()%>,<%=baseEl.getFormatMaskElement().getFormatSettings()%>,"<%=baseEl.getFormatMaskElement().getFormatMask()%>");
				<%
				}
				%>	
				<%=javaScriptManager.buildValidationHook(baseEl, "currentField")%>
		<%  }
		}
		%>
		ap.page.form.setupHotFields();		
		<% if(scriptElements.size() == 0){ %>
			ap.page.paint();
		<%}else{
			int  count = scriptElements.size();
			Iterator<BasePageElement> scriptElementIt = scriptElements.iterator();
			while (scriptElementIt.hasNext()){
				BasePageElement pageElement = scriptElementIt.next();
				String src = "/" + app + "/" + ((PageScriptPageElement)pageElement).getScriptSource();		
			%>	
		
		  		$.ajax({
		       	 	url: "<%= src %>",
		        	dataType: "script",
		       	 	cache: true,
		        	crossDomain: true	        
		  		}).done(function() {
		  			ap.consoleInfo('loaded account script element:' + '<%=src %>');
		  			<% count--;
		  				if(count == 0){%>
		  					setTimeout(function() {ap.page.paint();}, 500); 
		  			<%}%>
				}).fail(function() {
					ap.consoleInfo('failed to load account script element:' + '<%=src %>');
		 		});	
		  	<%}
		}%>
	};
	

	ap.accoutInit<%=htmlPage.getId()%>();
	</script>
<%} %>


