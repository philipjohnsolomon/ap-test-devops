<a class="problem_fix_jump jumper btn btn-primary"
	href="javascript:page.submit('FastForward');<%if(!firstPageIsBad){%>ap.pleaseWaitLB(true);<% } %>$('#lb_upload_welcome').modal('hide');void(0);"
	title="<%=uploadrb.getString("title.FastForward.Jump")%>">
	<div>
		<%=uploadrb.getString("action.FastForward.Jump")%>
	</div>
</a>