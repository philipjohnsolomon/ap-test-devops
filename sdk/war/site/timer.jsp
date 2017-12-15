<%@ page import="com.agencyport.locale.IResourceBundle"%>
<%@ page import="com.agencyport.locale.ResourceBundleManager"%>
<%@ page import="com.agencyport.locale.ILocaleConstants"%>
<%@ page import="com.agencyport.webshared.IWebsharedConstants"%>
<%@ page import="com.agencyport.utils.AppProperties"%>

<%
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
	int idleTimeout = AppProperties.getAppProperties().getIntProperty(IWebsharedConstants.CLIENT_UPDATE_MAX_TIMEOUT, 10);
	int idleCountdownStart = AppProperties.getAppProperties().getIntProperty("IDLE_TIMEOUT_COUNTDOWN_START", 1);
	int countdownSeconds = (idleCountdownStart * 60);

%>

<div class="modal fade" id="lb_idle_message" data-backdrop="static" role="dialog"  data-keyboard="false" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"><h2 class="modal-title"><%=rb.getString("message.session.header")%></h2></div>
			<div class="modal-body">
				<p><%=rb.getString("message.session.expire")%> <span id="timer"><%= countdownSeconds %></span>&nbsp;seconds.&nbsp;
				<%=rb.getString("message.session.expire1")%></p>
				<div lass="button-row">
				   <input name="continueButton" class="btn btn-primary continue" type="button" value="<%=rb.getString("action.Continue")%>"
							onclick="ap.timer.continueWork();" />
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
		var ap = ap || {};

		var idleTimeout =<%=idleTimeout%>;
		var idleCountdownStart =<%=idleCountdownStart%>;
		var timeout = (idleTimeout - idleCountdownStart) * 60 * 1000;

		ap.timer = new ap.Timer({
			id : 'timer',
			countDownStart : idleCountdownStart
		});

		$.idleTimer(timeout);

		$(document).bind("idle.idleTimer", function() {
			ap.timer.start();
		});
	
</script>
