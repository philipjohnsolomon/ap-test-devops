/** 
 * @fileoverview This file contains the functions used in the AgencyPort Installer
 */

//declare namespaces - setup objects.
var ap = ap || {};
ap.installerPage = {
	 
	/**
	 * Ensures that a file is selected when loading a template
	 * @return 
	 */
	uploadTemplate: function () {
		
		if 	($("#submitted").val() === "yes")  {
			return false;
		}
		
		if ($("#importFile").val() === "") {
			this.showMessage(ap.installer['installer.message.template.selecetion.err'], 5);
			return false;
		} else {
			$("#submitted").val("yes");
			$("#NEXT").prop('disabled',true);
			this.showMessage(ap.installer['installer.message.template.pleasewait'], 0);
			$('#add_templates').submit();
			return true;
		}
	 },
		
	/**
	 * Ensures that a database type is selected and submits the page
	 * @return 
	 */
	configureDatabase: function () {
		
		if 	($("#submitted").val() === "yes"){
			return false;
		}
	
		var option = $("#dbType").find(':selected').val();
	
		if (option === '') {
			this.showMessage(ap.installer['installer.message.database.selection.err'], 5);
			return false;
		} 
		else {
			$('#submitted').val('yes');		
			this.showMessage(ap.installer['installer.message.pleasewait'], 0);
			$('#configure_db').submit();
			return true;
		}
	},
	
	
	/**
	 * Shows a message to the user based on the action they just took
	 * @return 
	 */
	showMessage: function (message, delay) {
		
		$("#message_text").html(message);
		$("#message_delay").val(delay);
		
		if (delay > 0) {
			$("#message").fadeIn(delay);
		}
		else {
			$("#message").fadeIn();	
		}
		
	},
	/**
	 * Shows the final button if the user has restarted
	 */
	showFinalButton: function () {	
		if($('#restarted').is(':checked')) {
			$('#final_button').show();		
		}
		else {
			$('#final_button').hide();
		}
	},
	
	/**
	 * Highlights the menu for the current page and shows any messages if they exist
	 */
	initPage: function () {
	
		var $steps = $('#navigation').children('ul');
	
		$steps.each( function (){
			$(this).removeClass('selected');
		}); 
		
		$('#' + $('#pageId').val()).addClass('selected');
		
		if ($("#message_text").html().length > 0){ 
			this.showMessage($("#message_text").html(), 1500);
		}
	}
};