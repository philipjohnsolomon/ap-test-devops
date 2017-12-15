<div class="modal fade"  id="lb_confirm_account_delete">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title">${ACCOUNT_MANAGEMENT_RB['header.Title.ConfirmAccountDeletion']}</h2>
			</div>
			<div class="modal-body">
				<p>
				${ACCOUNT_MANAGEMENT_RB['account.actions.delete.warn']}
				</p>
				
				<div class="button-row">
					<button type="button" class="btn btn-primary" onclick="ap.account.doAccountDelete();">${CORE_RB['modal.confirmation.button.yes']}</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">${CORE_RB['modal.confirmation.button.no']}</button>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


