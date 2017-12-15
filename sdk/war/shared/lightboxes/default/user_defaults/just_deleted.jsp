<script type="text/javascript">
	ap.addLoadEvent(function(){$("#lb_defaults_deleted").modal();});
</script>

<!-- Modal -->
<div class="modal fade" id="lb_defaults_deleted" tabindex="-1" role="dialog" aria-labelledby="lb_defaults_deleted" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title" id="myModalLabel"><%=defaultsrb.getString("header.JustDeleted.DefaultsWereDeleted")%></h2>
			</div>
			<div class="modal-body">
				<p><%= messageForActionJustApplied %></p>   
			</div>

		</div>
	</div>
</div>