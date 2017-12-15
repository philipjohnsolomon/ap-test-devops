<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>
<%@ page import="java.util.*,
	com.agencyport.policyadmin.PolicyImageRetrieverException,
	com.agencyport.menu.IMenuConstants,
    com.agencyport.webshared.IWebsharedConstants"%>
    <%
    	PolicyImageRetrieverException ex = (PolicyImageRetrieverException)request.getAttribute("EXCEPTION");
        String policyNumber = request.getParameter(IWebsharedConstants.POLICY_NUMBER_NAME);
        if (policyNumber == null){
        	policyNumber = "";
        }
    	String effectiveDate = request.getParameter(IWebsharedConstants.TRANSACTION_EFFECTIVE_DATE_NAME);
        if (effectiveDate == null){
        	effectiveDate = "";
        }
    	String lob = request.getParameter(IWebsharedConstants.LOB_NAME);
        if (lob == null){
        	lob = "";
        }
    	String transactionName = request.getParameter(IMenuConstants.TRANSACTION_NAME);
        if (transactionName == null){
        	transactionName = "";
        }
    	
    	String pageName = "demoPolicyAdminParams";
    %> 
<div id="pageBody" class="pageBodyWithSubmissionNavigation">

	
    <form action="FrontServlet" id="<%=pageName%>" name="<%=pageName%>" method="post">
		<input type="hidden" name="NEXT" id="NEXT" value="" />
		<input type="HIDDEN" name="PAGE_NAME" value="launchPASRequest"> 
		<input type="HIDDEN" name="METHOD" value="Display"/> 
 		<ap:csrf/>
    	<%if (ex != null) { %>
        <h4>Error: <%=ex.getMessage()%></h4>
    	<%}%> 
        <h3><%=policySummaryRB.getString("header.Title.PolicyChangeRequest") %></h3>
        
		<div>
			<label for="POLICY_NUMBER" ><span>*</span><%= policySummaryRB.getString("label.PolicyAdmin.PolicyNumber") %></label>
			<input type="text" name="POLICY_NUMBER" id="POLICY_NUMBER" size="15" maxlength="15" value="<%=policyNumber%>"  />
	    </div>
		<div>
			<label for="TRANSACTION_EFFECTIVE_DATE" ><span>*</span><%= policySummaryRB.getString("label.PolicyAdmin.EffectiveDate") %></label>
			<input type="text" name="TRANSACTION_EFFECTIVE_DATE" id="TRANSACTION_EFFECTIVE_DATE" size="10" maxlength="10" value="<%=effectiveDate%>" />
	    </div>
		<div>
			<label for="LOB" ><span>*</span><%= policySummaryRB.getString("label.PolicyAdmin.LOB") %></label>
			<input type="text" name="LOB" id="LOB" size="6" maxlength="6" value="<%=lob%>"  />
	    </div>
		<div>
			<label for="TRANSACTION_NAME" ><span>*</span><%= policySummaryRB.getString("label.PolicyAdmin.TransactionID") %></label>
			<input type="text" name="TRANSACTION_NAME" id="TRANSACTION_NAME" size="32" maxlength="32" value="<%=transactionName%>" />
	    </div>
	    <div>
			<label for="NEW_PAS_REQUEST" ><span>*</span> <%= policySummaryRB.getString("label.PolicyAdmin.NewPASRequest") %></label>
			<select name="NEW_PAS_REQUEST" id="NEW_PAS_REQUEST">
				<option value="true"><%= policySummaryRB.getString("option.Boolean.True") %></option>
				<option value="false"><%= policySummaryRB.getString("option.Boolean.False") %></option>
			</select>
		</div>
	    
        
	
		<script type="text/javascript">
			ap.processEndorsementRequestAction = function(action){
				if (action == "") return false;
				document.getElementById('NEXT').value = action;
				document.forms[0].submit();
			}
		</script>
		
	    <p style="font-weight: bold"><%= policySummaryRB.getString("message.PolicyAdmin.ClickSubmit") %></p>
		<div class="buttons">
			<button type="submit" onclick="ap.processEndorsementRequestAction(this.value);"><%= policySummaryRB.getString("action.Submit") %></button>
	    </div>
	</form>
</div>