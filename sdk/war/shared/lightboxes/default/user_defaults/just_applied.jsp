<script type="text/javascript">
	ap.addLoadEvent(function(){$("#lb_defaults_applied").modal();});
</script>
 
<!-- Modal -->
<div class="modal fade" id="lb_defaults_applied" tabindex="-1" role="dialog" aria-labelledby="lb_defaults_applied" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content">
    
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title" id="myModalLabel"><%=ResourceBundleStringUtils.makeSubstitutions(defaultsrb.getString("header.JustApplied.DefaultsWereApplied"), nameOfDefaultsJustApplied)%></h2>
			</div>

			<div class="modal-body">
			<%
				if (defaultsResultedInCorrections) {
					%>
					<p><%=defaultsrb.getString("message.JustApplied.MergingTheseDefaults")%> 
						<a href="#lb_tcr" data-toggle="modal"  data-dismiss="modal"  title="<%=defaultsrb.getString("title.JustApplied.MergingTheseDefaults")%>"><%=defaultsrb.getString("action.JustApplied.MergingTheseDefaults")%></a>
					</p>
					<%
				}
				else if (defaultsResultedInCompleteDataOverlay) {
					%>
					<p><%=defaultsrb.getString("message.JustApplied.AllDefaultsApplied")%></p>
					<%
				}
				else {
					%>
					<p><%=defaultsrb.getString("message.JustApplied.Nothing")%></p>
					<%
				}
				if (somethingChanged && tvrRanClean) {
					%>
					<a class="jumper fast_forward_jump" href="javascript:page.submit('FastForward');ap.pleaseWaitLB(true);void(0);" title="<%=defaultsrb.getString("title.JustApplied.Jump")%>"><div><%=defaultsrb.getString("action.JustApplied.Jump")%></div></a>
					<p style="text-align: center; margin: 2px; font-weight: bold;"><%=defaultsrb.getString("title.JustApplied.Or")%></p>
					<a class="jumper double_check_jump"  data-dismiss="modal"  title="<%=defaultsrb.getString("title.JustApplied.KeepWorking")%>"><div><%=defaultsrb.getString("action.JustApplied.KeepWorking")%></div></a>
					<%
				}
				else {
					%>
						<input type="button" value="<%=rb.getString("action.Ok")%>" data-dismiss="modal" class="btn btn-default" />
					<%
				}
				%>
			</div>
		</div>
	</div>
</div>