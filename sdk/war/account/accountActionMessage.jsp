<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.shared.locale.ISharedLocaleConstants"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
%>

<!-- Account Merge success message -->
<div class="modal fade"  id="lb_account_action_merge_message">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" onclick="window.location.reload()" aria-hidden="true">&times;</button>
        <h2 class="modal-title">${ACCOUNT_MANAGEMENT_RB['account.actions.merge.account.success.header']}</h2>
      </div>
      <div class="modal-body">
        <p>${ACCOUNT_MANAGEMENT_RB['account.actions.merge.account.success']}</p>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- WorkItem Move success message -->
<div class="modal fade"  id="lb_account_action_move_message">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h2 class="modal-title">${ACCOUNT_MANAGEMENT_RB['account.actions.move.workitem.success.header']}</h2>
      </div>
      <div class="modal-body">
        <p>${ACCOUNT_MANAGEMENT_RB['account.actions.move.workitem.success']}</p>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- Account action error message -->
<div class="modal fade"  id="lb_account_action_error_message">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h2 class="modal-title">${ACCOUNT_MANAGEMENT_RB['account.actions.error.header']}</h2>
      </div>
      <div class="modal-body">
        <p>${ACCOUNT_MANAGEMENT_RB['account.actions.error']}</p>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- Account roster error message -->
<div class="modal fade"  id="lb_account_roster_error_message">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h2 class="modal-title">Account Roster Error Message</h2>
      </div>
      <div class="modal-body">
        <p id="roster_error">&nbps;</p>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
