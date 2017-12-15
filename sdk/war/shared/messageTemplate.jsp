<!-- \shared\messageTemplate.jsp-->

<%@ page import="java.util.ArrayList,
                com.agencyport.webshared.IWebsharedConstants,
                com.agencyport.connector.Result,
                com.agencyport.connector.MessageMap,
                com.agencyport.connector.IConnectorConstants, 
                java.util.List,
                com.agencyport.jsp.JSPHelper,
                com.agencyport.connector.MessageMapStore, 
                com.agencyport.product.ProductDefinitionsManager"%>
                
<div id="initialDisplayMessages" class="initial-display-messages">

<%
/** 
  Assuming an object called MessageMap, that is in fact - believe it 
  or not - a container full of messages. This object has one method that's 
  used on this page "getMessages(messageType)" that
  accepts a parameter describing the type of message needed, 
  and returns all the messages that the object contains as an array of strings. 
**/
JSPHelper jspHelper = JSPHelper.get(request);

String versionNumber = ProductDefinitionsManager.getCurrentlyRunningVersion().toString();
MessageMap messageMap = (MessageMap) request.getAttribute(IWebsharedConstants.MESSAGES);
boolean hasTLSMessageMap = MessageMapStore.hasMessageMap();
boolean msgsAvailable = true;
if (messageMap == null) {
	if ( !hasTLSMessageMap )
    	msgsAvailable = false;
    else	
    	messageMap = MessageMapStore.getMessageMap();	
}
else if ( hasTLSMessageMap ){
	MessageMap tlsMessageMap = MessageMapStore.getMessageMap();
	messageMap.copy(tlsMessageMap);
}
if ( hasTLSMessageMap )
	MessageMapStore.clearMessageMap();
	
List<Result> msgsRendered = new ArrayList<Result>(); 

if ( msgsAvailable ){
	List<Result> errors = messageMap.getResultsByType(IConnectorConstants.MESSAGE_ERROR_LITERAL); 
	String message = null;
	String cssStyleClass = null;
	String heading = null;
	
	if (errors.size() > 0 ) {
		msgsRendered.addAll(errors);
		cssStyleClass = errors.get(0).getCSSStyleClass();
		heading = errors.get(0).getHeading(); 
	    %>
	    <div id="<%=cssStyleClass%>" class="alert <%=cssStyleClass%>">
	        <h4 class="<%=cssStyleClass%>"><%=JSPHelper.prepareForHTML(heading)%>!</h4>
	        <i class="fa"></i>
	    <% 
	    
	    // paint ONLY the 'critical' box. Even if warnings and 
	    // informationals were generated, do not print them to the screen.
	    for (int ix = 0; ix < errors.size(); ix++) {
	        //print each error message to the screen.
	        Result result = errors.get(ix);
	        message = result.getMessage();
	        if ( result.shouldEncode() ){
	        	message = JSPHelper.prepareForHTML(message);
	        }
	        %>
	            <p><%=message%></p>
	            <%
	    }
	    %>
	    </div>
	    <%  
	}
	
	//to enter the else condition, NO CRITICAL errors can exist.
	else {  
		List<Result> warnings = messageMap.getResultsByType(IConnectorConstants.MESSAGE_WARNING_LITERAL); 
		List<Result> infos = messageMap.getResultsByType(IConnectorConstants.MESSAGE_INFO_LITERAL); 
	    //paint all warning & info messages in one box (if they exist).
	    if (warnings.size() > 0 ) {
			msgsRendered.addAll(warnings);
			cssStyleClass = warnings.get(0).getCSSStyleClass(); 
			heading = warnings.get(0).getHeading(); 
	        %>
	        <div id="<%=cssStyleClass%>" class="alert <%=cssStyleClass%>">
	            <h4 class="<%=cssStyleClass%>"><%=JSPHelper.prepareForHTML(heading)%>!</h4>
	        	<i class="fa"></i>
	            <% 
	            for (int ix = 0; ix < warnings.size(); ix++) {
	                //print each warning message to the screen.
			        Result result = warnings.get(ix);
			        message = result.getMessage();
			        if ( result.shouldEncode() ){
			        	message = JSPHelper.prepareForHTML(message);
			        }
	                %>
	                    <p><%=message%></p>
	                    <%
	            }
	            %>
	        </div>
	        <%  
	    }
	    // paint all informational messages (if they exist).
	    if (infos.size() > 0 ) {
			msgsRendered.addAll(infos);
			cssStyleClass = infos.get(0).getCSSStyleClass(); 
			heading = infos.get(0).getHeading(); 
	    %>
	   <div id="<%=cssStyleClass%>" class="alert <%=cssStyleClass%>">
	        <h4 class="<%=cssStyleClass%>"><%=JSPHelper.prepareForHTML(heading)%>!</h4>
	        <i class="fa"></i>
	        <% 
	        for (int ix = 0; ix < infos.size(); ix++) {
	            //print each informational message to the screen.
		        Result result = infos.get(ix);
		        message = result.getMessage();
		        if ( result.shouldEncode() )
		        	message = JSPHelper.prepareForHTML(message);
	            %>
	                <p><%=message%></p>
	                <%
	        }
	        %>
	    </div>
	    <%  
	    }
	}
}
%>
</div>             

<div id="ajaxMessages" class="ajax-messages" ></div>

<script type="text/javascript">
	var message;
	<% for ( Result msg : msgsRendered ) { %>
		message = new ap.Message("<%=msg.getType()%>", "<%=JSPHelper.prepareForJavaScript(msg.getMessage())%>", 
				"<%=msg.getCSSStyleClass()%>", "<%=JSPHelper.prepareForJavaScript(msg.getHeading())%>");
		ap.initialDisplayMessageMap.addMessage(message);	
	<% } %>
</script>