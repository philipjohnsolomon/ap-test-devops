/**
*	This class handles the display of multi-result data in a lightbox.
*/	
ap.multi_result = function() {
	
 	/**
	*	The <code>rawData</code> Holds the JSON data used to build the lightbox.
	*/		
	this.rawData;
	
 	/**
	*	The <code>lightboxId</code> Holds the id of element used to build the lightbox.
	*/		
	this.lightboxId = '#multi_result_lb';
	
	/**
	 * Initialize the class with a JSON object that determines the look and feel of the presentation.
	 * @param jsonData The JSON object
	 */		
	this.initialize = function(jsonData) {
		
		this.rawData = jsonData;
		this.setMessage();
		
		var table = this.buildTable();
		this.buildHeader(table);
		this.buildBody(table);
		this.buildButtons();
		
		$(this.lightboxId).on('hidden.bs.modal', function () {
			multi_result.cleanUp();
			$(this).removeData('bs.modal');
			$('.mr_modal').removeAttr('style');
		});
		
		this.setTitle();
		
		// Initialize table with tablesorter class
		this.initializeTable(table);	

		// Set the lightbox width
		this.determineLightboxWidth();
		
		// Hide or show the 'X' to close the dialog
		this.determineIfCloseXIsAvailable();
	
	};
	
	/**
	 * Remove all headers, data and buttons from source div.
	 */		
	this.cleanUp = function() {
		$('#mr_table').remove();
		$('#mr_buttons').empty();
		$('#mr_save_message').hide();
	};
	
	/**
	 * Set the custom message of the lightbox.
	 */			
	this.setMessage = function() {
		if (this.rawData.general.hasOwnProperty('message')) {
			$('#mr_message').text(this.rawData.general.message).removeClass('hidden');
		}
		else {
			$('#mr_message').addClass('hidden');
		}
	};
	
	/**
	 * Determine the lightbox width based on the individual column widths.
	 */		
	this.determineLightboxWidth = function() {
		width = 200;
		for (var i = 0; i < this.rawData.header.length; i++) {
			col = this.rawData.header[i];
			if (col.hidden == false)
				width += parseInt(col.width) + 30;
		}
		
		width = width.toString() + 'px';
		
		$('.mr_modal').css({
			width: width,
			'margin-left': function () {
				return -(width / 2);
			}
		});			
	};
	
	/**
	 * Determine the lightbox has an 'X' to close it.
	 */		
	this.determineIfCloseXIsAvailable = function() {
		if (this.rawData.general.hasOwnProperty('remove_x_close')) {
				$('#mr_close').addClass('hidden');
		}
		else {
			$('#mr_close').removeClass('hidden');
		}
	};
	
	/**
	 * Set the title text of the lightbox.
	 */		
	this.setTitle = function() {
		if (this.rawData.general.hasOwnProperty('title')) {
			$('#mr_title').text(this.rawData.general.title);
		}
	};
	
	/**
	 * Determine whether the results should be auto-saved.  If true the lightbox will not show.
	 * @return boolean
	 */		
	this.shouldAutoSaveResults = function() {
		if (this.rawData.general.auto_save && this.rawData.body.length == 1) {
			return true;
		}
		return false;
	};
	
	/**
	 * Initialize the table with the tablesorter information needed to sort and fitler.
	 * @param table The JQuery table element created in buildTable.
	 */		
	this.initializeTable = function(table) {
		
		var tableOptions = {};
		tableOptions.headers = this.buildHeaderInfo();
		tableOptions.widgets = this.buildWidgetArray();
		tableOptions.widgetOptions = this.buildWidgetOptions();
		if (this.hasDefaultSortOrder()) {
			tableOptions.sortList = this.getDefaultSortOrder();
		}	
		
		if (this.rawData.general.hasOwnProperty('emptyTo')) {
			tableOptions.emptyTo = this.rawData.general.emptyTo;
		}
		
		// Allow for debug messages in the console.
		//tableOptions.debug = true;		
		
		table.tablesorter(tableOptions).bind('filterEnd', function(e, filter) {
			multi_result.clearAllSelectedRows();
		});
		this.applyInitialStriping();
		
		$('#mr_body tr').click(
			function (event) { 
				multi_result.selectRow(event); 
			}
		);
		
		// Assign double click event to row if there is a 'save' button
		var saveBtnSelector = this.getSaveButtonIdSelector();
		if (saveBtnSelector != null) {
			$('#mr_body tr').dblclick(
				function (event) { 
					if (multi_result.selectRow(event)) {
						$(saveBtnSelector).trigger("click");
					}
				}
			);
		}
		
		// Hide filter element for hidden fields
		if (this.supportsFiltering()) {
			td = $('.tablesorter-filter').parent();
			for (var i = 0; i < td.length; i++) {
				if (this.isColumnHidden(i)) {
					$(td[i]).css('display', 'none');
				}
			}
		}	
	};
	
	/**
	 * Build the HTML table to hold the results.
	 * @return The JQuery object representing the HTML table element.
	 */		
	this.buildTable = function() {
		var table = $('<table id="mr_table" class="multi_results tablesorter"/>').appendTo('#mr_inner');
		$('<thead id="mr_header"/>').appendTo(table);
		$('<tbody id="mr_body"/>').appendTo(table);
		return table;
	};
	
	/**
	 * Build the columns and set the header text.
	 * @param table The JQuery table element created in buildTable.
	 */		
	this.buildHeader = function(table) {

		row = $('<tr/>').appendTo('#mr_header');
		for (var i = 0; i < this.rawData.header.length; i++) {
			col = this.rawData.header[i];
			th = $('<th/>').appendTo(row).html(col.label).width(col.width);
			
			if (!col.hasOwnProperty('uniqueId')) {
				col.uniqueId = 'field' + i;
			}
			th.attr('id', col.uniqueId);
			
			if (this.isColumnHidden(i)) {
				th.css('display', 'none');
			}
		}

	};
	
	/**
	 * Build the body of the table where the results will display.
	 * @param table The JQuery table element created in buildTable.
	 */		
	this.buildBody = function(table) {
		for (var i = 0; i < this.rawData.body.length; i++) {
			rowData = this.rawData.body[i];
			row = $('<tr/>').appendTo('#mr_body').attr('id', i);
			
			for (var j = 0; j < rowData.length; j++) {
				col = rowData[j];
				td = $('<td/>').appendTo(row);
				switch (col.type) {
					case 'TEXT':
						td.text(col.value);
						break;
					case 'RADIO':
						radio = $('<input type="radio" />').val(col.value).appendTo(td);
						if (col.hasOwnProperty('name')) {
							radio.attr('name', col.name);
						}
						break;
					case 'CHECKBOX':
						checkbox = $('<input type="checkbox" />').val(col.value).appendTo(td);
						if (col.hasOwnProperty('name')) {
							checkbox.attr('name', col.name);
						}						
						break;	
					case 'LINK':
						link = $('<a/>').html(col.value).appendTo(td);
						if (col.hasOwnProperty('href')) {
							link.attr('href', '#');
							link.attr('onclick', 'window.open("' + col.href + '", "_blank")');
						}
						break;
					case 'BUTTON':
						button = $('<input type="button" />').val(col.value).appendTo(td);
						if (col.hasOwnProperty('href')) {
							button.attr('onclick', col.href);
						}						
						break;	
					/*case 'SELECTLIST':
						selectList = $('<select />').appendTo(td);
						if (col.hasOwnProperty('options')) {
							$(col.options).each(function() {
								selectList.append($("<option>").attr('value', this.value).text(this.text));
							});
						}						
						break;*/						
				}
				
				if (col.titleRow == true) {
					row.addClass('mr_title_row');
				}
				
				if (this.isColumnHidden(j)) {
					td.css('display', 'none');
				}
				else {
					alignment = this.getDataAlignment(j);
					if (alignment) {
						td.css('text-align', alignment);
					}
				}
			}
		}
	};
	
	/**
	 * Apply the initial stripping to the table.
	 */		
	this.applyInitialStriping = function() {
		rows = $('#mr_body tr');
		for (var i = 0; i < rows.length; i++) {
			if (i%2 == 0)
				$(rows[i]).addClass('odd');
			else
				$(rows[i]).addClass('even');	
		}		
	};
	
	/**
	 * Add any buttons that are defined.
	 */		
	this.buildButtons = function() {
		
		if (this.rawData.header.length == 0 || this.rawData.body.length == 0)
			return;
		
		for (var i = 0; i < this.rawData.buttons.length; i++) {
			var btnInfo = this.rawData.buttons[i];
			
			button = $('<input type="button"/>').appendTo('#mr_buttons').attr('id', 'mr_button' + i);
			button.attr('value', btnInfo.value);
			button.addClass('btn');
			
			if (this.rawData.buttons[i].rank == 'primary') {
				button.addClass('btn-primary');
			}

			this.assignClickEvent('#mr_button' + i, btnInfo.onclick, btnInfo.type);
		}
	};
	
	/**
	 * Get the JQUERY id selector for a save type button if one exists.
	 * @return A JQUERY id selector or null.
	 */		
	this.getSaveButtonIdSelector = function() {
		var selector = null;
		
		for (var i = 0; i < this.rawData.buttons.length; i++) {
			var btnInfo = this.rawData.buttons[i];
			if (btnInfo.type == 'save') {
				selector = '#mr_button' + i;
				break;
			}
		}
		
		return selector;
	};
	
	/**
	 * Get the JSON defining the primary button.  There should only be one primary button.
	 * @return A JSON object that defines the button.
	 */		
	this.getPrimaryButtonInformation = function() {
		for (var i = 0; i < this.rawData.buttons.length; i++) {
			var btnInfo = this.rawData.buttons[i];
			if (this.rawData.buttons[i].rank == 'primary') {
				return btnInfo;
			}			
		}
		return null;
	};
	
	this.getDataAlignment = function(index) {
		col = this.rawData.header[index];
		if (col.hasOwnProperty('data_alignment')) {
			return col.data_alignment;
		}
		return null;
	};
	
	/**
	 * Determine if the column should be hidden based on the index.
	 * @param index The zero-based column index.
	 * @return boolean
	 */		
	this.isColumnHidden = function(index) {
		try {
			col = this.rawData.header[index];
			if (col.hasOwnProperty('hidden')) {
				return col.hidden;
			}		
		}
		catch (error) {
            if (console && console.log) {
                console.log('Cannot determine if column is hidden.');
            }				
		}	
	
		// Assume column shows unless specified
		return false;
	};
	
	/**
	 * Determine if the column supports sorting based on the index.
	 * @param index The zero-based column index.
	 * @return boolean
	 */		
	this.isColumnSortable = function(index) {

		try {
		
			if (!this.supportsSorting()) {
				return false;
			}
				
			// No reason to sort if only 1 row
			if (this.rawData.body.length < 2) {
				return false;
			}
			
			if (this.isColumnHidden(index)) {
				return false;
			}
			
			col = this.rawData.header[index];
			if (col.hasOwnProperty('sortable')) {
				return col.sortable;
			}			
		}
		catch (error) {
            if (console && console.log) {
                console.log('Cannot determine if column is sortable.');
            }				
		}
		
		// Assume a column is sortable unless specified
		return true;
	};
	
	/**
	 * Determine if the column supports filtering based on the index.
	 * @param index The zero-based column index.
	 * @return boolean
	 */		
	this.isColumnFilterable = function(index) {

		try {
		
			if (!this.supportsFiltering()) {
				return false;
			}
			
			// No reason to filter if only 1 row
			if (this.rawData.body.length < 2) {
				return false;
			}			
			
			if (this.isColumnHidden(index)) {
				return false;
			}
			
			if (col.hasOwnProperty('filterable')) {
				return col.filterable;
			}			
		}
		catch (error) {
            if (console && console.log) {
                console.log('Cannot determine if column is filterable.');
            }			
		}
		
		// Assumes filterable unless specified
		return true;
	};	
	
	/**
	 * Assign a click event handler for the button based on id.
	 * @param buttonId The HTML id of the button.
	 * @param fcnName The name of the function to call.
	 * @param buttonType The button type: 'save' or 'cancel'.
	 */		
	this.assignClickEvent = function(buttonId, fcnName, buttonType) {
		$(buttonId).click(
			function (event) { 
				multi_result.callFunction(buttonId, fcnName, buttonType);
			}
		);		
	};
	
	/**
	 * Build any widget options.  Currently this only sets whether or not filtering shows as a default.
	 * @return A JSON object with supported widget options.
	 */		
	this.buildWidgetOptions = function() {
		options = {};
		if (this.supportsFiltering()) {
			options.filter_hideFilters = !this.showFilters();
		}
		return options;
	};
	
	/**
	 * Build an array of widgets options that are supported.  Currently zebra stripping and filtering.
	 * @return An array of supported widgets.
	 */		
	
	this.buildWidgetArray = function() {
		widgets = [];
		widgets.push("zebra");
		
		if (this.supportsFiltering()) {
			widgets.push("filter");
		}
		return widgets;
	};
	
	/**
	 * Build sorting and filtering information about each header(column).
	 * @return A header info JSON object
	 */		
	this.buildHeaderInfo = function() {
		headerInfo = {};
		for (var i = 0; i < this.rawData.header.length; i++) {
			
			if (!this.isColumnSortable(i)) {
				headerInfo[i] = {sorter: false};
			}
			
			if (!this.isColumnFilterable(i)) {
				if (headerInfo[i] == null) {
					headerInfo[i] = {filter: false};
				}
				else {
					headerInfo[i].filter = false;
				}
			}				
		}
		return headerInfo;
	};
	
	/**
	 * Determine if the body of the lightbox is selectable by clicking the row.
	 * @return boolean
	 */		
	this.isSelectable = function() {
		if (this.rawData.general.hasOwnProperty('selectable')) {
			return this.rawData.general.selectable;
		}
		return true;
	};
	
	/**
	 * Determine if filtering is supported.
	 * @return boolean
	 */		
	this.supportsFiltering = function() {
		if (this.rawData.general.hasOwnProperty('supports_filtering')) {
			return this.rawData.general.supports_filtering;
		}
		return false;		
	};
	
	/**
	 * Determine if sorting is supported.
	 * @return boolean
	 */		
	this.supportsSorting = function() {
		if (this.rawData.general.hasOwnProperty('supports_sorting')) {
			return this.rawData.general.supports_sorting;
		}	
		return true;
	};
	
	/**
	 * Determine if there is a default sort order.
	 * @return boolean
	 */			
	this.hasDefaultSortOrder = function() {
		if (this.rawData.general.hasOwnProperty('sort_order')) {
			return true;
		}
		return false;	
	};
	
	/**
	 * Get the default sort order.  Should check 'hasDefaultSortOrder' before calling this.
	 * @return default sort order array
	 */		
	this.getDefaultSortOrder = function() {
		return this.rawData.general.sort_order;
	};
	
	/**
	 * Determine if filter row should show or is hidden on initial showing of the lightbox.
	 * @return boolean
	 */		
	this.showFilters = function() {
		if (this.rawData.general.hasOwnProperty('show_filters')) {
			return this.rawData.general.show_filters;
		}
		return true;		
	};
	
	/**
	 * Show the lightbox.  If auto save is set then lightbox does not show and the primary button click
	 * functionality is applied.
	 */		
	this.showDialog = function() {
		if (this.shouldAutoSaveResults()) {
			
			// package data
			var dataArray = this.packageData( $('#mr_table tbody tr td') );
			var btnInfo = this.getPrimaryButtonInformation();
			
			if (btnInfo != null) {
				functionName = btnInfo.onclick;
				if ($.isFunction(window[functionName])) {
					this.clearAllOverrides(dataArray);
					window[functionName](dataArray);
				}					
			}
			else {
				alert('No primary button information found.  Please check your configuration.');
			}
			
			this.cleanUp();
		}
		else {
			modalOptions = this.getModalOptions();
			$(this.lightboxId).modal(modalOptions);		
		}
	};
	
	/**
	 * Builds an options object to control how the modal dialog acts.
	 */		
	this.getModalOptions = function() {
		modalOptions = {};
		
		modalOptions.backdrop = this.rawData.general.allow_nonstandard_close;
		if (this.rawData.general.allow_nonstandard_close == false) {
			modalOptions.backdrop = 'static';
		}
		
		modalOptions.keyboard = this.rawData.general.allow_nonstandard_close;
		
		return modalOptions;
	};

	/**
	 * Hide the lightbox.
	 */		
	this.hideDialog = function() {
		$(this.lightboxId).modal('hide');
		$('.mr_modal').removeAttr('style');	
	};
	
	/**
	 * If the data is selectable, change the css class to indicate the row is selected.
	 * @param The event that was fired.
	 */		
	this.selectRow = function(event) {
		if (!this.isSelectable() || $(event.currentTarget).hasClass('mr_title_row')) {
			return false;
		}
			
		if ( !$(event.currentTarget).hasClass('tablesorter-filter-row') ) {			
			$('#mr_table tbody tr').removeClass('clicked');
			$(event.currentTarget).addClass('clicked');
		}
		
		return true;
	};
	
	/**
	 * Clears all selected rows that are now hidden.  
	 * Used in conjunction with filtering.
	 */		
	this.clearAllSelectedRows = function() {
		var clicked = $('#mr_table tbody tr.clicked');
		for (var index = 0; index < clicked.length; index++) {
			if (!$(clicked[0]).is(':visible')) {
				$(clicked[index]).removeClass('clicked');
			}
		}
	};	
	
	/**
	 * Call the function associated with the button clicked.  If the button is a save button an nothing
	 * has been selected do nothing.
	 * @param buttonId The HTML id of the button.
	 * @param fcnName The name of the function to call.
	 * @param buttonType The button type: 'save' or 'cancel'.
	 */		
	this.callFunction = function(buttonId, functionName, type) {
		
		if (type == 'save') {
			var clicked = $('#mr_table tbody tr.clicked');
			if (clicked.length == 0) {
				$(buttonId).blur();
				$('#mr_save_message').css('display', 'block');
				return;
			}
			
			if (!$(clicked[0]).is(':visible')) {
				$(clicked[0]).removeClass('clicked');
				return;
			}
			
		}
		
		$('#mr_save_message').hide();
	
		if ($.isFunction(window[functionName])) {
			if (type == 'save') {
				// package data and call save callback function
				var dataArray = this.packageData( $('#mr_table tbody tr.clicked td') );
				this.clearAllOverrides(dataArray);
				window[functionName](dataArray);
			}
			else {
				window[functionName]();
			}
		}
	};
	
	/**
	 * Package the selected data into a JSON object using the unique ids from the headers.
	 * @param dataElementArray An array of table data values from the selected row.
	 * @return An array of JSON objects with unique id and value pairs.
	 */		
	this.packageData = function(dataElementArray) {
		var dataArray = [];
		
		for (var i = 0; i < dataElementArray.length; i++) {

			dataObj = {};
			dataObj.value = $(dataElementArray[i]).text();
			if (dataObj.value.length == 0) {
				// check for child element (radio, checkbox)
				children = $(dataElementArray[i]).children();
				if (children.length > 0 && $(children[0]).is(':checked')) {
					dataObj.value = $(children[0]).val();
				}
			}
			
			tmpId = $('#mr_table thead tr th').get(i).id;
			dataObj.uniqueId = tmpId.replace('mr_', '');
			
			dataArray.push(dataObj);
		}		
		
		return dataArray;
	};
	
 	/*
	* This methods clears the override indicator for all overridable fields.
	*/		
	this.clearAllOverrides = function(dataArray) {
		jQuery.each(dataArray, function(key, val) {
			override.clearOverride(val.uniqueId);
		});			
	};	
};
var multi_result = new ap.multi_result();