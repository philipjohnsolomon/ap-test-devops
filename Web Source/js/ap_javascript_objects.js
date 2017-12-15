/**
 * @fileoverview This file contains the JavaScript objects for the
 *  AgencyPortal framework.
 * @requires ap_javascript_base.js Contains functions used by the objects specified within this script
 * @requires overlib.js Contains pop-up functionality used by the objects in this script
 * @requires ap_javascript_dtr.js Contains support when intrapage DTR is activated.
 * @author Michael Albert malbert@agencyport.com Norm Baker nbaker@agencyport.com
 * @version 0.2
 */

/**
 * Construct a new Transaction object.
 * 
 * @class This is the basic Tranaction class. It is intended to contain
 *        immutable transactional metadata for use within custom javascript
 *        code, although the object does not explicitly enforce the immutable
 *        nature of it's elements. The Transaction object holds no methods other
 *        than setters.
 * @constructor
 * @return A new transaction
 */

ap.Transaction = function() {
	/**
	 * The <code>id</code> field is the id of the transaction specified in the
	 * TDF. Initialized to an empty string. Example genlLiability
	 */
	this.id = ''; // id of the transaction per the TDF
	/**
	 * The <code>title</code> field is the title of the transaction specified
	 * in the TDF. Initialized to an empty string. Example: General Liability
	 */
	this.title = ''; // title of the transaction per TDF
	/**
	 * The <code>target</code> field is the ACORD XML target node of the
	 * transaction as specified in the TDF. Initialized to an empty string.
	 * Example: GeneralLiabilityPolicyQuoteInqRq
	 */
	this.target = ''; // root target node per the TDF
	/**
	 * The <code>lob</code> field is the line of business code specified in
	 * the TDF. Initialized to an empty string. Example: CGL
	 */
	this.lob = ''; // LOB Code per the TDF
	/**
	 * The <code>entityName</code> field is the name of the entity to which
	 * this transaction applies which is shown to the user on the WIP. Example:
	 * AgencyPort Insurance Services, Inc.
	 */
	this.entityName = '';
	/**
	 * The <code>type</code> field is the type of transaction per the TDF if
	 * specified. Initialized to an empty string. Example: NEW_BUSINESS
	 */
	this.type = ''; // transaction type per the TDF;
	/**
	 * The <code>summaryPageId</code> field is the id of the summary page of
	 * the transaction. Initialized to an empty string. Example: policySummary
	 */
	this.summaryPageId = ''; // id of summary page per the TDF
	/**
	 * The <code>workItemId</code> field is the unique workItemId for this
	 * instance. Initialized to 0.
	 */
	this.workItemId = 0;// system-wide id of the work item
	/**
	 * The <code>uploadSourceName</code> field is the name of the Agency
	 * Management System from which the data originated in an upload case.
	 */
	this.uploadSourceName = '';
	/**
	 * The <code>uploadSourceOrg</code> field is the name of the vendor for
	 * the Agency Management System from which the data originated in an upload
	 * case
	 */
	this.uploadSourceOrg = '';
	/**
	 * The <code>uploadSourceVersion</code> field is the version of the Agency
	 * Management System from which the data originated in an upload case
	 */
	this.uploadSourceVersion = '';
	/**
	 * The <code>uploadSourceSystem</code> field is a concatenation of the
	 * Organization and Name. For Example: AMS AFW
	 */
	this.uploadSourceSystem = '';

	/**
	 * The <code>tvrRanClean</code> field will be true if the transaction
	 * validation report for this transaction's work item has been run and it
	 * ran clean.
	 */
	this.tvrRanClean = false;

	/**
	 * The <code>firstTvrBadPage</code> field will contain the first bad page
	 * id from the transaction validation report assuming that the TVR has been
	 * run and one or more issues were found with the work item.
	 */
	this.firstTvrBadPage = '';

	/**
	 * The <code>firstTime</code> field is a boolean which is a mirror of the
	 * server side FIRST_TIME flag.
	 */
	this.firstTime = false;

	/**
	 * Sets the <code>firstTime</code> field.
	 */
	this.setFirstTime = function(firstTime) {
		this.firstTime = firstTime;
	};

	/**
	 * Sets the <code>id</code> field.
	 */
	this.setId = function(id) {
		this.id = id;
	};
	/**
	 * Sets the <code>title</code> field.
	 */
	this.setTitle = function(title) {
		this.title = title;
	};
	/**
	 * Sets the <code>target</code> field.
	 */
	this.setTarget = function(target) {
		this.target = target;
	};
	/**
	 * Sets the <code>lob</code> field.
	 */
	this.setLob = function(lob) {
		this.lob = lob;
	};
	/**
	 * Sets the <code>entityName</code> field.
	 */
	this.setEntityName = function(entityName) {
		this.entityName = entityName;
	};
	/**
	 * Sets the <code>type</code> field.
	 */
	this.setType = function(type) {
		this.type = type;
	};
	/**
	 * Sets the <code>summaryPageId</code> field.
	 */
	this.setSummaryPageId = function(summaryPageId) {
		this.summaryPageId = summaryPageId;
	};
	/**
	 * Sets the <code>workItemId</code> field.
	 */
	this.setWorkItemId = function(workItemId) {
		this.workItemId = workItemId;
	};
	/**
	 * Sets the <code>uploadSourceName</code> field.
	 */
	this.setUploadSourceName = function(uploadSourceName) {
		this.uploadSourceName = uploadSourceName;
	};
	/**
	 * Sets the <code>uploadSourceOrg</code> field.
	 */
	this.setUploadSourceOrg = function(uploadSourceOrg) {
		this.uploadSourceOrg = uploadSourceOrg;
	};
	/**
	 * Sets the <code>uploadSourceVersion</code> field.
	 */
	this.setUploadSourceVersion = function(uploadSourceVersion) {
		this.uploadSourceVersion = uploadSourceVersion;
	};
	/**
	 * Sets the <code>uploadSourceSystem</code> field.
	 */
	this.setUploadSourceSystem = function(uploadSourceSystem) {
		this.uploadSourceSystem = uploadSourceSystem;
	};
	/**
	 * Sets the <code>tvrRanClean</code> field.
	 */
	this.setTvrRanClean = function(tvrRanClean) {
		this.tvrRanClean = tvrRanClean;
	};
	/**
	 * Sets the <code>firstTvrBadPage</code> field.
	 */
	this.setFirstTvrBadPage = function(firstTvrBadPage) {
		this.firstTvrBadPage = firstTvrBadPage;
	};
};

/**
 * Declaration of the DTR in progress flag here so that applications need not
 * include ap_javascript_dtr.js on custom JSPs.
 */
/**
 * 
 */
/**
 * 
 */
ap.intrapageDTRRequestInProgress = false;
/**
 * Construct a new Page object.
 * 
 * @constructor
 * @class This is the basic Page class. The page object consists of numerous
 *        transaction definition file driven properties as well as a number of
 *        methods related to form management and user experience. A Page object
 *        with the variable name 'page' is instantiated on every framework
 *        generated page.
 * @return A new Page instance
 */
ap.Page = function() {
	/**
	 * The <code>id</code> field is the id of the page as specified in the
	 * transaction definition file. Initialized to an empty string.
	 */
	this.id = ''; // title of the page
	/**
	 * The <code>title</code> field is the title of the page given in the TDF.
	 * Initialized to an empty string.
	 */
	this.title = ''; // name of the page per TDF
	/**
	 * The <code>form</code> field is a pointer to the framework-significant
	 * Form instance on the page. Initialized to an empty string. As of build
	 * 3.7.0.00015 this is no longer an HTML form reference but a reference to
	 * our own Form instance.
	 */
	this.form = ''; // a standard way of accessing the primary HTMLFormElement
					// for this page
	/**
	 * The <code>forceView</code> field is taken from the TDF, indicates if
	 * the user should be forced to review all roster entries before being
	 * allowed to continue. Initialized to false.
	 */
	this.forceView = false; // should the user review roster entries before
							// being allowed to continue
	/**
	 * The <code>isTransactionStartPoint</code> field indicates if this is the
	 * first time view of the first page of the transaction
	 */
	this.isTransactionStartPoint = false; // is this the users first view of
											// the first screen?
	/**
	 * The <code>downFillPageId</code> field is the id of the page used to
	 * downfill the data.
	 */
	this.downFillPageId = ''; // title of the page
	/**
	 * The <code>requireAccountSetup</code> field indicates if this requires
	 * account setup
	 */
	this.requireAccountSetup = false;
	/**
	 * The <code>isFirstView</code> field indicates if this is a first time
	 * view by the user of a given page. Initialized to false.
	 */
	this.isFirstView = false; // boolean - is this the first time view of this
								// page?
	/**
	 * The <code>hasDataAvailable</code> field indicates whether or not there
	 * is data fields available for this page.
	 */
	this.hasDataAvailable = false;
	/**
	 * The <code>supportOriginalValues</code> field an indicates if the
	 * transaction supports original value management. Initialized to false.
	 */
	this.supportOriginalValues = false; // boolean - does this page support
										// original values?
	/**
	 * The <code>isUploaded</code> field indicates if the item was originally
	 * uploaded
	 */
	this.isUploaded = false;

	/**
	 * The <code>showUploadedMessage</code> field indicates if the uploaded
	 * message will be displayed when the workitem is opened at the first time
	 */
	this.showUploadedMessage = true;

	/**
	 * The <code>preValidationEnabled</code> field indicates if pre-validation
	 * (i.e. display side validation is enabled for the page)
	 */
	this.preValidationEnabled = true;
	/**
	 * The <code>type</code> field is describes the type of page, and can be
	 * populated with the values 'roster', 'rosterEdit', or 'dataEntry'.
	 * Initialized to an empty string.
	 */
	this.type = ''; // roster, rosterEdit, dataEntry
	/**
	 * The <code>maxEntries</code> field is used by roster pages, the maximum
	 * entry threshold
	 */
	this.maxEntries = 0;
	/**
	 * The <code>minEntries</code> field is used by roster pages, the minimum
	 * entry threshold
	 */
	this.minEntries = 0;
	/**
	 * The <code>messsageSeverity</code> field Contains a string describing
	 * the severity level of any messages presented to the user on the screen.
	 * Can be populated with the values 'critical', 'warning', or
	 * 'informational'. Initialized to an empty string.
	 */
	this.messsageSeverity = ''; // critical, warning, informational
	/**
	 * The <code>messageCount</code> field contains the number of messages
	 * being presented to the user on the page by the framework messaging
	 * system. Initialized to 0.
	 */
	this.messageCount = 0; // number of messages returned to this page.
	/**
	 * The <code>dataAccessType</code> field describes the data access type of
	 * the page, used to manage user experience around roster redisplay.
	 */
	this.dataAccessType = '';
	/**
	 * The <code>action</code> field initially null, contains the last action
	 * attempted by the user (ie, the name of the last button pressed)
	 */
	this.action = null; // contains the last action attempted by the user (ie,
						// the name of the last button pressed)

	/**
	 * The <code>mainButtonContainer</code> field is a pointer to the
	 * structural HTML container around the main page buttons.
	 */
	this.$mainButtonContainer = '';
	/**
	 * The <code>secondaryButtonContainer</code> field is a pointer to the
	 * structural HTML container around the secondary button container
	 */
	this.$secondaryButtonContainer = '';
	/**
	 * The <code>secondaryActionsControl</code> field is a pointer to the
	 * structural HTML container around the secondary actions control
	 */
	this.$secondaryActionsControl = '';
	/**
	 * The <code>body</code> field is a pointer to the structural container
	 * around the main body of the page. This is not simply a pointer to the
	 * HTML body tag.
	 */
	this.$body = '';
	/**
	 * The <code>rosterContainer</code> field is a pointer to the structural
	 * container around the roster if there is one on the page.
	 */
	this.$rosterContainer = '';
	/**
	 * The <code>rosterAddNewContainer</code> field is a pointer to the
	 * structural container around the 'add new' section belonging to a roster
	 */
	this.$rosterAddNewContainer = '';
	/**
	 * The <code>roster</code> field is a pointer to the roster itself
	 */
	this.$roster = '';
	/**
	 * The <code>tips</code> field is a pointer to the tips section at the top
	 * of the page
	 */
	this.tips = '';
	/**
	 * The <code>recoverEnabled</code> field indicates if it is possible to
	 * recover items from a roster list once they've been deleted on this page.
	 */
	this.recoverEnabled = true;
	/**
	 * The <code>readOnly</code> field indicates if the page is read only.
	 */
	this.readOnly = false;
	/**
	 * The <code>hasHotFields</code> field indicates whether or not this page
	 * contains one or more hot fields.
	 */
	this.hasHotFields = false;
	/**
	 * The <code>fieldsets</code> field contains a list of the Fieldset
	 * instances for this page.
	 */
	this.fieldsets = new Array();
	/**
	 * The <code>compoundKey</code> field is the compound key for this page.
	 */
	this.compoundKey = null;
	/**
	 * The <code>index</code> field contains the index state for this page.
	 * This typically only applies to roster pages.
	 */
	this.index = null;
	/**
	 * The <code>menu</code> property contains a reference to the menu object
	 * for this page. The menu is previously instantiated, outside of this
	 * script.
	 */
	this.menu = typeof (menu) == 'object' ? menu : null;
	/**
	 * The <code>confirmConversion</code> property is used to manage the modal
	 * dialog associated with conversion of an application from quote to full
	 */
	this.confirmConversion = false;
	/**
	 * The <code>onInitialize</code> is a hook to a custom function here in
	 * your custom code. Ex: "page.onInitalize = function myFunction() {...};"
	 */
	this.onInitialize;
	/**
	 * The <code>onSubmit</code> is a hook a custom function here in your
	 * custom code. Ex: "page.onSubmit = function myFunction() {...};" If the
	 * method returns false, the submission will be cancelled.
	 */
	this.onSubmit;
	/**
	 * The <code>onPaint</code> is a hook for a custom function. Ex:
	 * "page.onPaint = function myFunction() {...};" If defined, it will run as
	 * the last step of the page.paint() method.
	 */
	this.onPaint;
	/**
	 * The <code>onAddOpen</code> is a hook a custom function here in your
	 * custom code. Ex: "page.onAddOpen = function myFunction() {...};"
	 */
	this.onAddOpen;
	/**
	 * The <code>onAddClose</code> is a hook a custom function here in your
	 * custom code. Ex: "page.onAddClose = function myFunction() {...};"
	 */
	this.onAddClose;
	/**
	 * The <code>onRosterCopy</code> is a hook a custom function here in your
	 * custom code. Ex: "page.onRosterCopy = function myFunction() {...}; If the
	 * custom method returns false, the action will be cancelled. At time of
	 * execution a local variable <code>url</code> can be set to override the
	 * default processing URL."
	 */
	this.onRosterCopy;
	/**
	 * The <code>onRosteEdit</code> is a hook a custom function here in your
	 * custom code. Ex: "page.onRosterEdit = function myFunction() {...}; If the
	 * custom method returns false, the action will be cancelled. At time of
	 * execution a local variable <code>url</code> can be set to override the
	 * default processing URL."
	 */
	this.onRosterEdit;
	/**
	 * The <code>onRosteView</code> is a hook a custom function here in your
	 * custom code. Ex: "page.onRosterView = function myFunction() {...}; If the
	 * custom method returns false, the action will be cancelled. At time of
	 * execution a local variable <code>url</code> can be set to override the
	 * default processing URL."
	 */
	this.onRosterView;
	/**
	 * The <code>onRosterDelete</code> is a hook a custom function here in
	 * your custom code. Ex: "page.onRosterDelete = function myFunction() {...};
	 * If the custom method returns false, the action will be cancelled. At time
	 * of execution a local variable <code>url</code> can be set to override
	 * the default processing URL."
	 */
	this.onRosterDelete;
	/**
	 * The <code>onRosterRecover</code> is a hook a custom function here in
	 * your custom code. Ex: "page.onRosterRecover= function myFunction() {...};
	 * If the custom method returns false, the action will be cancelled. At time
	 * of execution a local variable <code>url</code> can be set to override
	 * the default processing URL."
	 */
	this.onRosterRecover;
	/**
	 * The <code>onRosterViewFile</code> is a hook a custom function here in
	 * your custom code. Ex: "page.onRosterViewFile= function myFunction()
	 * {...}; If the custom method returns false, the action will be cancelled.
	 * At time of execution a local variable <code>url</code> can be set to
	 * override the default processing URL."
	 */
	this.onRosterViewFile;

	/**
	 * The <code>onValidationTip</code> is a hook a custom function here in
	 * your custom code. Ex: "page.onValidationTip= function myFunction(field,
	 * validation) {...};"
	 * 
	 * @param field
	 *            is the Field object that caused the validation failure
	 * @param validation
	 *            is the Validation object that failed
	 * @returns true if the standard overlib call should proceed
	 */
	this.onValidationTip = function(field, validation) {
		return true;
	};

	/**
	 * The <code>isRedisplayWithErrors</code> indicates whether or not the
	 * current page display is a redisplay with errors situation.
	 */
	this.isRedisplayWithErrors = false;

	/**
	 * The <code>supportsFieldHelperTabbing</code> field is an indicates if
	 * tabbing to field helpers is supported.
	 */
	this.supportsFieldHelperTabbing = false;

	/**
	 * The <code>recordLockStatus</code> field contains the record lock status
	 * of the current work item. See
	 * com.agencyport.database.locking.RecordLockStatus for valid values.
	 */
	this.recordLockStatus = '';

	/**
	 * The <code>fastForwardPage</code> field has the fast forward to page.
	 */
	this.fastForwardPage = '';

	/**
	 * The <code>isAutoSaved</code> field marks when a transaction has been
	 * auto saved. This will be used in conjunction with "hasUnsavedChanges" to
	 * determine whether or not to auto save.
	 */
	this.isAutoSaved = '';

	/**
	 * The <code>autoSaveInterval</code> is the interval in seconds that a
	 * check for unsaved changes will occur. If there are changes and the
	 * interval time has passed the current data will be saved.
	 */
	this.autoSaveInterval = '';

	/**
	 * The <code>autoSaveData</code> is auto saved data that when present
	 * needs to be populated on the UI.
	 */
	this.autoSaveData;

	/**
	 * The <code>inAutoSave</code> is in auto save mode.
	 */
	this.inAutoSaveProcess = false;

	/**
	 * The <code>autoSaveOnSave</code> is a boolean to determine whether or
	 * not to call the same process for clicking the save button.
	 */
	this.autoSaveOnSave = false;

	/**
	 * The <code>isWorkItemAssistantSupported</code> is a boolean to determine
	 * if the WorkItemAssistant Assistant should be included within the
	 * transactions
	 */
	this.isWorkItemAssistantSupported = true;

	/**
	 * The <code>clientUpdateInterval</code> is the number of seconds between
	 * periodic updates to fetch new work item assistant entries or update work
	 * item locking
	 */
	this.clientUpdateInterval = 15;

	/**
	 * The <code>supportsIPDTRDynamicContent</code> governs whether or not
	 * dynamic content can be introduced during an IPDTR Ajax call.
	 */
	this.supportsIPDTRDynamicContent = false;

	/**
	 * The <code>clientUpdateMaxTimeOut</code> is the number of seconds last
	 * without change on the page before periodic updates are stopped.
	 */
	this.clientUpdateMaxTimeOut = 600;

	/**
	 * The <code>lastAutoSavedTime</code> is the time when data are auto
	 * saved.
	 */
	this.lastAutoSavedTime = 0;

	/**
	 * The <code>isWorkItemLockSupported</code> is a boolean to determine if
	 * the WorkItem locking is supported. within the transactions
	 */
	this.isWorkItemLockSupported = true;

	/**
	 * The <code>chooseAccountLocation</code> is a boolean to determine if
	 * locations can be imported from Account. within the Locations
	 */
	this.chooseAccountLocation = false;

	/**
	 * The <code>csrfToken</code> is for support CSRF thread protection.
	 */
	this.csrfToken;

	/**
	 * The <code>linkAccountInfo</code> is for linked account info
	 */
	this.linkAccountInfo = '';

	this.snippetHandlers = new Array();

	/**
	 * The <code>lowConfidenceThreshold</code> is used for OCR Turnstile
	 * uploads. Should be filled from framework.properties entry. Default 0.
	 */
	this.lowConfidenceThreshold = 0;

	this.accountDownFillData = new Object();

	/**
	 * The <code>downfillValidation</code> is the flag of indicating the need
	 * for pre-validation. Used when a work item is created witin an account for
	 * the very first time.
	 */
	this.downfillValidation = true;

	/**
	 * Sets the linkAccountInfo.
	 * 
	 * @param linkAccountId
	 *            is the linked account id to set.
	 */
	this.setLinkAccountInfo = function(linkAccount) {
		this.linkAccountInfo = linkAccount;
	};

	this.addAccountDownfillData = function(id, data) {
		this.accountDownFillData[id] = data;
	};

	/**
	 * Returns the CSRF token.
	 * 
	 * @return the CSRF token.
	 */
	this.getCSRFToken = function() {
		return this.csrfToken;
	};
	/**
	 * Sets the CSRF token.
	 * 
	 * @param csrfToken
	 *            is the CSRF token to set.
	 */
	this.setCSRFToken = function(csrfToken) {
		this.csrfToken = csrfToken;
	};

	/**
	 * Sets the downfill prevalidation
	 * 
	 * @param validation
	 *            is the prevalidation to set.
	 */
	this.setDownfillValidation = function(validation) {
		this.downfillValidation = validation;
	};

	/**
	 * Gets the flag that governs whether or not dynamic content can be
	 * introduced during an IPDTR Ajax call.
	 * 
	 * @return true if dynamic content might be rendered during an IPDTR call.
	 */
	this.getSupportsIPDTRDynamicContent = function() {
		return this.supportsIPDTRDynamicContent;
	};

	/**
	 * Set the flag that governs whether or not dynamic content can be
	 * introduced during an IPDTR Ajax call.
	 * 
	 * @param supportsIPDTRDynamicContent
	 *            indicates if dynamic content might be rendered during an IPDTR
	 *            call.
	 */
	this.setSupportsIPDTRDynamicContent = function(supportsIPDTRDynamicContent) {
		this.supportsIPDTRDynamicContent = supportsIPDTRDynamicContent;
	};

	/**
	 * Saves the record as an auto saved record. If the save button was pressed
	 * we want to mark this as saved and unset the hasUnsavedChanges flag since
	 * a specific save was performed.
	 * 
	 * @param isSave
	 *            indicates whether or not the save action was initiated by user
	 */
	this.autoSave = function() {
		if (this.shouldSendUpdate()) {
			var $self = this;
			setTimeout(function() {
				var date = new Date();
				if ($self.hasUnsavedChanges() && $self.shouldAutoSave()
						&& !$self.submitted) {
					ap.consoleInfo("AutoSave check for changes : "
							+ date.getTime());
					$self.sendAutoSaveRequest(1);
				} else {
					setTimeout(function() {
						$self.autoSave();
					}, $self.autoSaveInterval);
				}
			}, $self.autoSaveInterval);
		} else {
			ap.consoleInfo('Idle too long. Auto Save stops.');
		}
	};

	/**
	 * Makes the call to the server to auto save the current data
	 * 
	 * @param autoSaved
	 *            is the indicator for auto saved. this is used to differentiate
	 *            between save, save and exit and auto save. Auto save has a
	 *            value of 1 while save and save and exit have a value of 2. If
	 *            the value is 0 we are just tracking the last page visited for
	 *            sending the user back to the last updated page.
	 */
	this.sendAutoSaveRequest = function(autoSaved) {
		this.isAutoSaved = true;
		this.inAutoSaveProcess = true;
		// set next to save so we do auto save
		this.form.elements["NEXT"].value = 'AutoSave';

		var $form = $("#" + this.form.id);
		$form.find("input[name='NEXT']").val('AutoSave');
		var formData = $form.serializeArray();
		var $self = this;
		$.ajax({
			type : 'POST',
			url : 'FrontServlet?ISAUTOSAVE=' + autoSaved,
			data : formData,
			complete : function(xhr, textStatus) {
				ap.consoleInfo('Auto save ajax request complete with status: '
						+ textStatus);
			},
			success : $.proxy(function(response) {
				var autoSaveTime = response;
				ap.consoleInfo('auto save response = ' + autoSaveTime);
				if (autoSaved == 1 && autoSaveTime) {
					var autoSaveNode = $('#ap_autosave');
					autoSaveNode.html(autoSaveTime);
					$('#ap_autosave_list').show();
					this.updateAutoSaved(autoSaveNode);
				}
				this.isAutoSaved = true;
				this.inAutoSaveProcess = false;
				if (this.isSubmitting) {
					page.submit(this.isSubmitting);
				}
				var date = new Date();
				this.lastAutoSavedTime = date.getTime();
				$self.autoSave();
			}, this),
			error : $.proxy(function(data) {
				this.isAutoSaved = false;
				this.inAutoSaveProcess = false;
				if (this.isSubmitting) {
					page.submit(this.isSubmitting);
				}
				$self.autoSave();
			}, this)
		});
	};

	/**
	 * Updates the UI auto saved time and puts an effect on it
	 * 
	 * @param dateTime
	 *            is the date time of the last auto save.
	 * @param startColor
	 *            is the color used to highlight the changing auto saved time
	 */
	this.updateAutoSaved = function(node) {
		ap.Effects.highlight(node);
	};

	/**
	 * Checks to see if any fields on the page have changed since the last auto
	 * save
	 */
	this.shouldAutoSave = function() {

		var needAutoSave = false;
		// there must be a save point for us to check for changes otherwise just
		// auto save
		if (this.isAutoSaved) {
			for (var i = 0; i < page.form.fields.length; i++) {
				if (page.form.fields[i].getValue() != page.form.fields[i]
						.getLastCheckedValue()) {
					needAutoSave = true;
					// set the value that will be auto saved into the auto saved
					// field
					page.form.fields[i].setLastCheckedValue(page.form.fields[i]
							.getValue());
				}
			}
		} else {
			// if no autosaved form then we are good to save again
			needAutoSave = true;
		}

		ap.consoleInfo("Should call AutoSave: " + needAutoSave);
		return needAutoSave;
	};

	/**
	 * Checks to see if any fields on the page have changed since the last check
	 * by WorkItem Assistant If auto save is on, this routine will not do
	 * anything This routine will not be called if AutoSave is on
	 */
	this.checkedLastChange = function() {

		if (this.autoSaveInterval > 0)
			return false;

		var changed = false;
		for (var i = 0; i < page.form.fields.length; i++) {
			if (page.form.fields[i].getValue() != page.form.fields[i]
					.getLastCheckedValue()) {
				changed = true;
				page.form.fields[i].setLastCheckedValue(page.form.fields[i]
						.getValue());
			}
		}
		return changed;
	};
	/**
	 * Sets the auto save data to populate on the current screen.
	 * 
	 * @param autoSaveData
	 *            is the auto saved json data for the current work item.
	 */
	this.setAutoSaveData = function() {
		var autoSaveFieldData = this.autoSaveData.apAutoSave;
		var length = autoSaveFieldData.length;
		var firstDefaultIPDTRHotField = null;
		var ipdtrCallTriggered = false;

		for (var i = 0; i < length; i++) {
			var autoSaveObject = autoSaveFieldData[i];
			var id = autoSaveObject.uniqueId;
			var field = this.getField(id);
			if (!field) {
				continue;
			}

			if (field.isAutoSaveApplied) {
				// only want to apply the auto-save value once
				continue;
			}

			if (!firstDefaultIPDTRHotField && field.isHot
					&& field.autoInvokeAJAX && field.defaultValue
					&& field.defaultValue.length > 0) {
				firstDefaultIPDTRHotField = field;
			}

			if (field.getValue() == autoSaveObject.value) {
				// consider it applied if it's already the value
				field.isAutoSaveApplied = true;
			}
			if (field.getValue() != autoSaveObject.value) {
				if (field.isHot && field.autoInvokeAJAX) {
					ipdtrCallTriggered = true;
				}

				if (!field.autoSaveAttemptCount) {
					field.autoSaveAttemptCount = 0;
				}

				field.setValue(autoSaveObject.value);

				// autoSaveObject.value is always the displayValue (with format
				// mask applied)
				// so send true into getValue so any format mask will be applied
				// to the return
				if (field.getValue(true) == autoSaveObject.value) {
					// If we called setValue, but it didn't take, then this is
					// an input field with a finite set of options and the
					// auto-saved
					// option isn't on the page yet. Further IPDTR calls from
					// other
					// auto-saved fields should cause the option list to refresh
					// so we'll
					// try to apply the value again when the page repaints after
					// that.
					// 
					// If the values do match, we set isAutoSaveApplied to true
					// so we
					// won't try to set it again on subsequent page paints.
					field.isAutoSaveApplied = true;
				} else {
					field.autoSaveAttemptCount++;
					if (field.autoSaveAttemptCount > 10) {
						// we tried 10 times without success...avoid infinity
						field.isAutoSaveApplied = true;
					}
				}
			}
		}

		if (firstDefaultIPDTRHotField && !ipdtrCallTriggered) {
			// None of the auto-saved hotfields had a value that didn't match
			// its default.
			// Need to trigger the default value IPDTR call in this case.
			firstDefaultIPDTRHotField.makeIntraPageDTRRequest(true);
		}

		// if roster open the add since data will be available
		if ($('#rosterAddNewBtn').length) {
			this.rosterAddAction();
		}

	};
	/**
	 * Populates auto save data on the given field.
	 * 
	 * @param field
	 *            is the field whose auto-save data needs to be set.
	 */
	this.setAutoSaveFieldData = function(field) {
		var autoSaveFieldData = this.autoSaveData.apAutoSave;
		var length = autoSaveFieldData.length;
		for (var i = 0; i < length; i++) {
			var autoSaveObject = autoSaveFieldData[i];
			var id = autoSaveObject.uniqueId;
			if (field && field.uniqueId == id
					&& field.getValue() != autoSaveObject.value) {
				field.setValue(autoSaveObject.value);
			}
		}
	};

	/**
	 * Sets the interval for auto saving that has been set in the properties
	 * file.
	 * 
	 * @param interval
	 *            number of seconds before page is auto saved
	 */
	this.setAutoSaveInterval = function(interval) {
		this.autoSaveInterval = interval * 1000;
	};

	/**
	 * Sets the flag to determine whether or not to use auto save process when
	 * save button is clicked.
	 * 
	 * @param supportsAutoSaveOnSave
	 *            is a boolean to determine whether or not to use auto save when
	 *            clicking save.
	 */
	this.setAutoSaveOnSave = function(supportsAutoSaveOnSave) {
		this.autoSaveOnSave = supportsAutoSaveOnSave;
	};

	/**
	 * Sets the flag to determine whether or not to show upload message
	 * 
	 * @param showUploadedMessage
	 *            is a boolean to determine whether or not to show upload
	 *            message
	 */
	this.setShowUploadedMessage = function(showUploadedMessage) {
		this.showUploadedMessage = showUploadedMessage;
	};
	/**
	 * Get the flag that determines whether or not to call the auto save process
	 * when clicking save.
	 * 
	 * @return true if auto save should be engaged when clicking save.
	 */
	this.getAutoSaveOnSave = function() {
		return this.autoSaveOnSave;
	};

	/**
	 * Sets the fastForwardPage current work item.
	 * 
	 * @param fastForwardPage
	 *            for current work item.
	 */
	this.setFastForwardPage = function(fastForwardPage) {
		this.fastForwardPage = fastForwardPage;
	};

	/**
	 * Sets the record lock status of the current work item.
	 * 
	 * @param recordLockStatus
	 *            is the record lock status of the work item.
	 */
	this.setRecordLockStatus = function(recordLockStatus) {
		this.recordLockStatus = recordLockStatus;
	};

	/**
	 * Returns if the current work item is currently locked by another user.
	 * 
	 * @return if the current work item is currently locked by another user.
	 * @type Boolean
	 */

	this.lockedByOtherUser = function() {
		return this.recordLockStatus == "LOCKED_BY_OTHER_USER";
	};

	/**
	 * Determines whether or not this field supports original values or not.
	 * 
	 * @return true if this field supports field helper tabbing.
	 * @type Boolean
	 */
	this.getSupportsFieldHelperTabbing = function() {
		return this.supportsFieldHelperTabbing;
	};

	/**
	 * Sets the flag for supporting tabbing to field helpers.
	 * 
	 * @param supportsFieldHelperTabbing
	 *            True if supports field helper tabbing else false.
	 */
	this.setSupportsFieldHelperTabbing = function(supportsFieldHelperTabbing) {
		this.supportsFieldHelperTabbing = supportsFieldHelperTabbing;
	};

	/**
	 * Sets the is redisplay with errors flag.
	 * 
	 * @param isRedisplayWithErrors
	 *            is a boolean flag.
	 */
	this.setIsRedisplayWithErrors = function(isRedisplayWithErrors) {
		this.isRedisplayWithErrors = isRedisplayWithErrors;
	};
	/**
	 * Sets the has data available flag.
	 * 
	 * @param hasDataAvailable
	 *            is a boolean flag.
	 */
	this.setHasDataAvailable = function(hasDataAvailable) {
		this.hasDataAvailable = hasDataAvailable;
	};
	/**
	 * Sets the current index which applies to the ultimate XML positioning.
	 * This is in the form A[n].B[n] etc.
	 * 
	 * @param index
	 *            is a string based XPath as in A[n].B[n] where n is a numeric
	 *            sequence.
	 */
	this.setIndex = function(index) {
		this.index = index;
	};

	/**
	 * Retrieves the current index for this roster entry as it to its ultimate
	 * XML positioning. This is in the form A[n].B[n] etc.
	 * 
	 * @return the current index for this roster entry as it to its ultimate XML
	 *         positioning.
	 * @type String
	 */
	this.getIndex = function() {
		return this.index;
	};

	/**
	 * Sets the <code>compoundKey</code> field.
	 * 
	 * @param compound
	 *            is the value of the page's compound key
	 */
	this.setCompoundKey = function(compoundKey) {
		this.compoundKey = compoundKey;
	};
	/**
	 * Sets the <code>downFillPageId</code> field.
	 * 
	 * @param downfill
	 *            page id
	 */
	this.setDownFillPageId = function(downFillPageId) {
		this.downFillPageId = downFillPageId;
	};
	/**
	 * Returns the <code>compoundKey</code> field.
	 * 
	 * @return the <code>compoundKey</code> field.
	 * @type String
	 */
	this.getCompoundKey = function() {
		return this.compoundKey;
	};

	/**
	 * Appends a fieldset instance to the fieldsets array maintained by this
	 * instance
	 * 
	 * @param fieldset
	 *            is a reference to the Fieldset instance to add
	 * @return the position in the array where this field set was added.
	 * @type Number
	 */
	this.addFieldset = function(fieldset) {
		return this.fieldsets.push(fieldset) - 1; // return relative position
	};

	/**
	 * This will return the first field set beyond the position passed which is
	 * not currently excluded
	 * 
	 * @param relativePosition
	 *            establishes the position to begin looking at in the fieldsets
	 *            array maintained by this page instance for a match.
	 * @return the fieldset closest beyond the relative position
	 * @type Fieldset
	 */
	this.getNextClosestIncludedFieldset = function(relativePosition) {
		for (var ix = relativePosition + 1; ix < this.fieldsets.length; ix++) {
			var fieldset = this.fieldsets[ix];
			if (!fieldset.isExcluded())
				return fieldset;
		}
		return null;
	};

	/**
	 * This will find Fieldset instances given a fieldset id.
	 * 
	 * @param fieldsetId
	 *            is the field set's id
	 * @return the fieldset matching that id if found else null
	 * @type Fieldset
	 */
	this.getFieldset = function(fieldsetId) {
		for (var ix = 0; ix < this.fieldsets.length; ix++) {
			if (this.fieldsets[ix].getId() == fieldsetId)
				return this.fieldsets[ix];
		}
		return null;
	};
	/**
	 * This will find the Field instance given a field unique identifier
	 * 
	 * @param fieldId
	 *            is field unique id
	 * @return the field matching that unique id if found else null
	 * @type Field
	 */
	this.getField = function(fieldId) {
		for (var ix = 0; ix < this.fieldsets.length; ix++) {
			var fieldset = this.fieldsets[ix];
			var field = fieldset.getField(fieldId);
			if (field != null)
				return field;
		}
		return null;
	};
	/**
	 * This will round up all of the Field instances which should be delivered
	 * to the IntrapageDTRBehaviorManager listening on the server.
	 * 
	 * @return an array of Field instances
	 * @type Array
	 */
	this.getFieldsForSendToIntrapageDTR = function() {
		var fieldsToSend = new Array();
		for (var ix = 0; ix < this.fieldsets.length; ix++) {
			var fields = this.fieldsets[ix].getFields();
			for (var ij = 0; ij < fields.length; ij++) {
				var field = fields[ij];
				if (this.supportsIPDTRDynamicContent) {
					fieldsToSend.push(field);
				} else {
					// backward compatibility
					if (field.getIsHot())
						fieldsToSend.push(field);
					else if (!field.isExcluded())
						fieldsToSend.push(field);
				}
			}
		}
		return fieldsToSend;
	};

	/**
	 * This will round up all of the FieldSet instances which should be
	 * delivered to the IntrapageDTRBehaviorManager listening on the server.
	 * 
	 * @return an array of FieldSet instances
	 * @type Array
	 */
	this.getFieldSetsForSendToIntrapageDTR = function() {
		return this.fieldsets;
	};
	/**
	 * Sets the 'has hot fields' property only.
	 * 
	 * @param hasHotFields
	 *            is a boolean value where true turns a field to hot.
	 */
	this.setHasHotFields = function(hasHotFields) {
		this.hasHotFields = hasHotFields;
	};
	/**
	 * Gets the hot field property.
	 * 
	 * @return a boolean value where true means a field is hot
	 * @type Boolean
	 */
	this.getHasHotFields = function() {
		return this.hasHotFields;
	};
	/**
	 * Sets the <code>id</code> field of this instance.
	 * 
	 * @param id
	 *            is the page id (originating from the id attribute from a TDF
	 *            page
	 */
	this.setId = function(id) {
		this.id = id;
	};
	/**
	 * Sets the <code>title</code> field of this instance.
	 * 
	 * @param title
	 *            is the page title (originating from the title attribute from a
	 *            TDF page
	 */
	this.setTitle = function(title) {
		this.title = title;
	};
	/**
	 * Sets the <code>forceView</code> field of this instance.
	 * 
	 * @param forceView
	 *            indicates whether the roster entry needs to be visited before
	 *            continuing on.
	 */
	this.setForceView = function(forceView) {
		this.forceView = forceView;
	};
	/**
	 * Sets the <code>isTransactionStartPoint</code> field of this instance.
	 * 
	 * @param isTransactionStartPoint
	 *            indicates whether or not this is the first time view of the
	 *            first page of the transaction
	 */
	this.setIsTransactionStartPoint = function(isTransactionStartPoint) {
		this.isTransactionStartPoint = isTransactionStartPoint;
	};

	/**
	 * Sets the <code>requireAccountSetup</code> field of this instance.
	 * 
	 * @param requireAccountSetup
	 *            indicates whether or not this requires account setup
	 */
	this.setRequireAccountSetup = function(requireAccountSetup) {
		this.requireAccountSetup = requireAccountSetup;
	};

	/**
	 * Sets the <code>isFirstView</code> field of this instance.
	 * 
	 * @param isFirstView
	 *            indicates if this is a first time view by the user of a given
	 *            page.
	 */
	this.setIsFirstView = function(isFirstView) {
		this.isFirstView = isFirstView;
	};
	/**
	 * Sets the <code>readOnly</code> field of this instance.
	 * 
	 * @param readOnly
	 *            indicates if this is page is read only or not.
	 */
	this.setReadOnly = function(readOnly) {
		this.readOnly = readOnly;
	};

	/**
	 * Sets the <code>supportOriginalValues</code> field of this instance.
	 * 
	 * @param supportOriginalValues
	 *            indicates if this is page supports original values or not.
	 */
	this.setSupportOriginalValues = function(supportOriginalValues) {
		this.supportOriginalValues = supportOriginalValues;
	};
	/**
	 * Sets the <code>isUploaded</code> field of this instance.
	 * 
	 * @param isUploaded
	 *            indicates the current work item is an uploaded work item or
	 *            not.
	 */
	this.setIsUploaded = function(isUploaded) {
		this.isUploaded = isUploaded;
	};
	/**
	 * Sets the <code>preValidationEnabled</code> field of this instance.
	 * 
	 * @param preValidationEnabled
	 *            establishes whether or not validation is run on the display
	 *            side or not.
	 */
	this.setPreValidatationEnabled = function(preValidationEnabled) {
		this.preValidationEnabled = preValidationEnabled;
	};
	/**
	 * Sets the <code>type</code> field of this instance.
	 * 
	 * @param type
	 *            is the type of this page.
	 */
	this.setType = function(type) {
		this.type = type;
	};
	/**
	 * Sets the <code>maxEntries</code> field of this instance.
	 * 
	 * @param maxEntries
	 *            is maximum entries this roster can hold.
	 */
	this.setMaxEntries = function(maxEntries) {
		this.maxEntries = maxEntries;
	};

	/**
	 * Sets the <code>suppressAddAction</code> field of this instance.
	 * 
	 * @param suppressAddAction
	 *            is a boolean flag which governs whether or not add action
	 *            should be suppressed.
	 * @since 5.0
	 */
	this.setSuppressAddAction = function(suppressAddAction) {
		this.suppressAddAction = suppressAddAction;
	};
	/**
	 * Sets the <code>minEntries</code> field of this instance.
	 * 
	 * @param minEntries
	 *            is the minimum entries this roster can hold.
	 */
	this.setMinEntries = function(minEntries) {
		this.minEntries = minEntries;
	};
	/**
	 * Sets the <code>messageSeverity</code> field of this instance.
	 * 
	 * @param messageSeverity
	 *            describes the severity of the messages.
	 */
	this.setMessageSeverity = function(messageSeverity) {
		this.messageSeverity = messageSeverity;
	};
	/**
	 * Sets the <code>messageCount</code> field of this instance.
	 * 
	 * @param messageCount
	 *            reflects how many messages are currently displayed.
	 */
	this.setMessageCount = function(messageCount) {
		this.messageCount = messageCount;
	};
	/**
	 * Sets the <code>dataAccessType</code> field of this instance.
	 * 
	 * @param dataAccessType
	 *            is the update intent of this page (add, etc.)
	 */
	this.setDataAccessType = function(dataAccessType) {
		this.dataAccessType = dataAccessType;
	};

	/**
	 * Sets the <code>isWorkItemAssistantSupported</code> field of this
	 * instance.
	 * 
	 * @param supportedFlag
	 *            is a boolean denoting of WorkItemAssistant Assistant is
	 *            supported.
	 */
	this.setWorkItemAssistantEnabled = function(supportedFlag) {
		this.isWorkItemAssistantSupported = supportedFlag;
	};

	/**
	 * Sets the <code>clientUpdateInterval</code> field of this instance.
	 * 
	 * @param updateInterval
	 *            is the duration of time in seconds between periodic updates.
	 */
	this.setClientUpdateInterval = function(updateInterval) {
		this.clientUpdateInterval = updateInterval;
	};

	/**
	 * Sets the <code>clientUpdateMaxTimeOut</code> field of this instance.
	 * 
	 * @param maxUpdateTimeOut
	 *            is the duration of time in seconds without data change on the
	 *            page before the periodic updates are stopped.
	 */
	this.setClientUpdateMaxTimeOut = function(maxUpdateTimeOut) {
		this.clientUpdateMaxTimeOut = maxUpdateTimeOut;
	};

	/**
	 * Sets the <code>setWorkItemLockSupported</code> field of this instance.
	 * 
	 * @param supportedFlag
	 *            is a boolean denoting of WorkItem locking is supported.
	 */
	this.setWorkItemLockSupported = function(supportedFlag) {
		this.isWorkItemLockSupported = supportedFlag;
	};

	/**
	 * Sets the <code>setChooseAccountLocation</code> field of this instance.
	 * 
	 * @param supportedFlag
	 *            is a boolean denoting if locations can be imported from
	 *            account
	 */
	this.setChooseAccountLocation = function(supportedFlag) {
		this.chooseAccountLocation = supportedFlag;
	};
	/**
	 * Sets the <code>mainButtonContainer</code> field of this instance.
	 */
	this.setMainButtonContainer = function() {
		this.$mainButtonContainer = $('#continueButton').parents('.buttons');
		if (!this.$mainButtonContainer.length) {
			this.$mainButtonContainer = false;
		}
	};
	/**
	 * Sets the <code>secondaryButtonContainer</code> field of this instance.
	 */
	this.setSecondaryButtonContainer = function() {
		this.$secondaryButtonContainer = $('#addButton').parents('.buttons');
		if (!this.$secondaryButtonContainer.length) {
			this.$secondaryButtonContainer = false;
		}
	};
	/**
	 * Sets the <code>secondaryActionsControl</code> field of this instance.
	 */
	this.setSecondaryActionsControl = function() {
		this.$secondaryActionsControl = $('#secondaryActions');
		if (!this.$secondaryActionsControl.length) {
			this.$secondaryActionsControl = false;
		}
	};
	/**
	 * Sets the <code>body</code> field of this instance.
	 */
	this.setBody = function() {
		this.$body = $('#pageBody');
		if (!this.$body.length) {
			this.$body = false;
		}
	};
	/**
	 * Sets the <code>rosterContainer</code> field of this instance.
	 */
	this.setRosterContainer = function() {
		this.$rosterContainer = false;
		$.each($('div'), $.proxy(function(key, node) {
			if ($(node).hasClass('rosterContainer')) {
				this.$rosterContainer = $(node);
			}
		}, this));
	};
	/**
	 * Sets the <code>roster</code> field of this instance.
	 */
	this.setRoster = function() {
		this.$roster = this.$rosterContainer.find('table').first();
		if (!this.$roster.length) {
			this.$roster = false;
		}
	};
	/**
	 * Sets the <code>rosterAddNewContainer</code> field of this instance.
	 */
	this.setRosterAddNewContainer = function() {
		this.$rosterAddNewContainer = false;
		$.each($('div'), $.proxy(function(key, node) {
			if ($(node).hasClass('rosterAddNew')) {
				this.$rosterAddNewContainer = $(node);
			}
		}, this));
	};
	/**
	 * Sets the <code>tips</code> field of this instance.
	 */
	this.setTips = function() {
		this.tips = $('#tip').first();
		if (!this.tips.length) {
			this.tips = false;
		}
	};
	/**
	 * Sets the <code>recoverEnabled</code> field of this instance.
	 * 
	 * @param recoverEnabled
	 *            is a Boolean value.
	 */
	this.setEnableRecover = function(recoverEnabled) {
		this.recoverEnabled = recoverEnabled;
	};

	var submitted = false;

	this.lastTabIndex;

	/**
	 * sets the tab index for all fields and buttons on the page
	 * 
	 */
	this.manageTabIndex = function() {
		this.lastTabIndex = 0;
		var nonTabFieldIndex = 1000;

		this.setRosterActionTabIndex();

		for (var i = 0; i < this.fieldsets.length; i++) {
			var fieldSetObject = this.fieldsets[i];
			for (var j = 0; j < fieldSetObject.fields.length
					&& !fieldSetObject.isExcluded(); j++) {
				var field = fieldSetObject.fields[j];
				// only set tabindex for fields that are shown
				if (field.isFocusable()) {
					this.lastTabIndex = this.lastTabIndex + 1;
					if (field.isRadio()) {
						if (field.elements[0].checked === true) {
							field.elements[0].tabIndex = this.lastTabIndex;
							if (field.elements.length > 1) {
								this.lastTabIndex = this.lastTabIndex + 1;
								field.elements[1].tabIndex = this.lastTabIndex;
							}
						} else {
							if (field.elements.length > 1) {
								field.elements[1].tabIndex = this.lastTabIndex;
								this.lastTabIndex = this.lastTabIndex + 1;
							}
							field.elements[0].tabIndex = this.lastTabIndex;
						}
					} else if (field.isFilterListType()) {
						// for filter lists we need to set the tabIndex for
						// both the list and the find text box
						var filterList = field.getFilterList();
						filterList.setTabIndex(field, this.lastTabIndex);
					} else {
						field.elements[0].tabIndex = this.lastTabIndex;
					}
					// supports tabbing to field helpers
					if (this.supportsFieldHelperTabbing) {
						this.setFieldHelperTabIndex(field);
					}
				} else {
					if (field.elements && !field.isMessageType()) {
						nonTabFieldIndex = nonTabFieldIndex + 1;
						field.elements[0].tabIndex = nonTabFieldIndex;
					}
				}
			}
		}

		this.setButtonTabIndex();

		this.manageHeaderMenuTabIndex();
		this.manageNavigationMenuTabIndex();
	};

	/**
	 * sets roster actions tab index (edit, delete and copy)
	 */
	this.setRosterActionTabIndex = function() {
		// set tabindex on the edit and delete buttons for roster pages
		if (this.$roster) {
			$.each($('td.actionCell a'), $.proxy(function(idx, item) {
				var $link = $(item);
				this.lastTabIndex = this.lastTabIndex + 1;
				$link.attr("tabIndex", this.lastTabIndex);
			}, this));
		}
	};

	/**
	 * sets tabindex for field helpers
	 */
	this.setFieldHelperTabIndex = function(field) {
		var fieldHelperContainer = field.fieldHelperContainer;
		if (fieldHelperContainer.length) {
			var $childElements = fieldHelperContainer.children();
			$.each($childElements, $.proxy(function(idx, item) {
				this.lastTabIndex = this.lastTabIndex + 1;
				$(item).attr("tabIndex", this.lastTabIndex);
			}, this));
		}
	};

	/**
	 * sets button tab index
	 */
	this.setButtonTabIndex = function() {
		// set all the button indexes
		if ($('#continueButton').length) {
			this.lastTabIndex = this.lastTabIndex + 1;
			$('#continueButton').attr("tabIndex", this.lastTabIndex);
		}
		if ($('#addButton').length) {
			this.lastTabIndex = this.lastTabIndex + 1;
			$('#addButton').attr("tabIndex", this.lastTabIndex);
		}
		if ($('#saveButton').length) {
			this.lastTabIndex = this.lastTabIndex + 1;
			$('#saveButton').attr("tabIndex", this.lastTabIndex);
		}
		if ($('#secondaryActions').length) {
			this.lastTabIndex = this.lastTabIndex + 2;
			$('#secondaryActions').attr("tabIndex", this.lastTabIndex);
		}
		if ($('#cancelButton').length) {
			this.lastTabIndex = this.lastTabIndex + 2;
			$('#cancelButton').attr("tabIndex", this.lastTabIndex);
		}
	};

	/**
	 * sets the tabIndex for the header menu items
	 */
	this.manageHeaderMenuTabIndex = function() {
		$.each($('#mainMenu a'), $.proxy(function(idx, item) {
			this.lastTabIndex = this.lastTabIndex + 1;
			$(item).attr("tabIndex", this.lastTabIndex);
		}, this));
	};

	/**
	 * sets tabIndex for the navigation menu items
	 */
	this.manageNavigationMenuTabIndex = function() {
		$.each($('#submissionNavigationMenu a'), $.proxy(function(idx, item) {
			var entry = $(item);
			if (!entry.hasClass('not_available')) {
				this.lastTabIndex = this.lastTabIndex + 1;
				entry.tabIndex = this.lastTabIndex;
			}
		}, this));
	};

	/**
	 * Validates the elements within the primary form. If a field is invalid,
	 * this method returns false and sets the focus on the offending field. If
	 * valid, method returns true.
	 * 
	 * @return true or false
	 * @type Boolean
	 */
	this.validate = function() {

		var invalid = this.form.fields.filter(function(item) {
			if (!item.validate(false)) {
				return true;
			} else {
				return false;
			}
		});

		if (invalid.length) {
			invalid[0].validate();
			invalid[0].setFocus();
			return false;
		} else {
			return true;
		}

	};

	/**
	 * Designed to validtate the primary form on the 'display-side' of the page -
	 * Unlike validate(), this method does not stop on an invalid field, it runs
	 * through all elements in the form everytime
	 */
	this.preValidate = function() {
		// skip prevalidation of the 'add new' form on a roster page.
		if (this.preValidationEnabled && this.type != 'roster') {

			this.form.fields.map(function(item) {
				item.validate(false, true);
				item.setFocusValidationTrigger();
			});
		}
	};

	/**
	 * Sets focus on the first non-hidden form element
	 * 
	 * @param isAdd
	 *            True if add link has been opened
	 */
	this.focusOnFirstField = function(isAdd) {
		// set focus on the edit or delete buttons on roster pages
		if (this.$roster && !isAdd) {
			var actions = $('td.actionCell a');
			if (actions.length) {
				actions[0].focus();
			}
		} else {
			for (var i = 0; i < this.form.fields.length; i++) {
				if (this.form.fields[i].type != "hidden"
						&& !this.form.fields[i].isHidden && this.form.fields[i]
						&& !this.form.fields[i].readOnly) {
					if (this.form.fields[i].fieldElementType != "question") {
						this.form.fields[i].setFocus();
						try {
							this.form.fields[i].elements[0].select();
							var handler = page.snippetHandlers[this.form.fields[i].snippetFileName
									+ "_"
									+ this.form.fields[i].snippetPageNumber]
							if (handler) {
								handler
										.showSnippet(this.form.fields[i].snippetId)
							}
						} catch (e) {
						}

					} else {
						window.scrollTo(0, 0);
					}
					break;
				}
			}
		}
	};
	/**
	 * Determines if this page has a menu or not.
	 * 
	 * @return the whether a page has a menu or not
	 * @type Boolean
	 */
	this.hasMenu = function() {
		if (this.menu === undefined || this.menu == null)
			return false;
		else
			return true;
	};

	/**
	 * The submit method is called by the primary and secondary actions for form
	 * submission
	 * 
	 * @return false if POST submit should not be engaged else true if
	 *         everything is okay to submit.
	 * @type Boolean
	 */
	this.submit = function(action) {
		var runValidation = true;
		if (!action)
			return false;

		// If there is an IntraPage AJAX call in flight then get out.
		if (ap.intrapageDTRRequestInProgress) {
			this.deselectCurrentSecondaryAction();
			return false;
		}
		// if we are in auto save ajax call do not submit
		// we should be completely done with auto save before submitting.
		if (this.inAutoSaveProcess) {
			this.isSubmitting = action;
			return false;
		}

		this.action = action;
		// prevent page resubmission due to redundant clicking
		if (submitted)
			return false;
		/**
		 * Prevent the user from continuing past a roster if the minimum hasn't
		 * been reached or the maximum has been exceeded or if some of the items
		 * needed to be visited.
		 */
		if (this.type == "roster" && action == "Continue"
				&& this.readOnly == false) {
			var tooMany = this.activeRosterEntries - this.maxEntries;
			if (tooMany > 0) {
				var errMsg = ap.applyPositionalVariableSubstitutions(
						ap.core_prompts["message.roster.TooMany"],
						this.maxEntries, tooMany);
				alert(errMsg);
				return false;
			} else if (this.forceView) {
				alert(ap.core_prompts["message.roster.ForceView"]);
				return false;
			} else if (this.activeRosterEntries < this.minEntries) {
				var errMsg = ap.applyPositionalVariableSubstitutions(
						ap.core_prompts["message.roster.TooFew"],
						this.minEntries);
				alert(errMsg);
				return false;
			}
		}

		var nextAction = action;
		if (nextAction == 'AccountAdd') {
			nextAction = 'Add';
		}

		this.form.elements["NEXT"].value = nextAction;

		// disable validation on a roster click of anything but add
		if (this.type == "roster" && action != "Add")
			runValidation = false;

		// disable validation on the cancel click
		if (action == "Cancel" || action == 'CancelCreate')
			runValidation = false;

		// don't run this on first page since no data exists
		// they must validate and save otherwise there will be no WIP
		if (ap.transaction && !ap.transaction.firstTime && this.autoSaveOnSave) {
			ap.consoleInfo('Not first time of submit.');
			// disable validation when clicking save from secondary actions.
			// when clicking save from roster edit we allow framework to do
			// regular processing
			if (this.type != 'rosterEdit' && this.type != 'rosterCopy'
					&& action == "Save" && this.autoSaveInterval > 0) {
				runValidation = false;
				this.deselectCurrentSecondaryAction();
				this.form.elements["NEXT"].value = "AutoSaveSave";
			}

			if (action == "Save and Exit" && this.autoSaveInterval > 0) {
				runValidation = false;
				this.deselectCurrentSecondaryAction();
				this.form.elements["NEXT"].value = "AutoSaveExit";
			}
		}

		// disable validation of read only pages
		if (this.readOnly)
			runValidation = false;

		// validate the page
		if (runValidation) {
			if (!this.validate()) {
				this.deselectCurrentSecondaryAction();
				return false;
			}
		}

		if (typeof this.setAddressValidationState == 'function')
			this.setAddressValidationState();

		if (action == 'SaveToDefaults') {
			this.deselectCurrentSecondaryAction();

			if (page.hasUnsavedChanges()) {
				$("#lb_confirm_default_save").modal();
			} else {
				$("#lb_save_to_default").modal();
			}

			return false; // Lightbox is now in control on a different thread
							// so we circumvent the normal submit process
		}

		if (action == 'ConvertToApplication' && !this.confirmConversion) {
			this.deselectCurrentSecondaryAction();

			if (page.hasUnsavedChanges()) {
				$("#lb_confirm_convert_exit").modal();
			} else {
				$('#lb_confirm_convert').modal();
			}
			return false;
		}

		// hook point for custom code
		if (typeof this.onSubmit == 'function') {
			if (!this.onSubmit()) {
				this.deselectCurrentSecondaryAction();
				return false;
			}
		}

		if ((this.hasMenu() && this.menu.getNextEntry()
				&& this.menu.getNextEntry().slowLoader && action == 'Continue')
				|| action == 'ConvertToApplication') {
			ap.pleaseWaitLB(true);
		} else {
			this.pleaseWait(true);
		}

		if (action == 'FastForward' && this.isTransactionStartPoint
				&& this.fastForwardPage != '') {
			this.form.elements["PAGE_NAME"].value = this.fastForwardPage;
			this.form.elements["METHOD"].value = "Display";
		}

		if (page.hasUnsavedChanges()) {
			this.form.elements["DATA_CHANGED"].value = "true";
		}
		this.unmaskFields();

		this.decodeFilterListFields();

		this.form.submit();

		submitted = true;

		return true;
	};

	this.pleaseWait = function(show) {
		if (show) {
			$('#pleaseWait div').removeClass('invisible');
		} else {
			$('#pleaseWait div').addClass('invisible');
		}
	};
	/**
	 * Walk thru' all the fields and unmask it. Called before page submission.
	 */
	this.unmaskFields = function() {

		this.fieldsets.map(function(fieldset) {
			fieldset.fields.map(function(field) {
				if (field.fieldFormatMask) {
					field.fieldFormatMask.unmask();
				}
			});
		});

	};

	/**
	 * Walk thru' all the fields and unmask it. Called before page submission.
	 */
	this.decodeFilterListFields = function() {

		this.fieldsets.map(function(fieldset) {
			fieldset.fields.map(function(field) {
				if (field.isFilterListType()) {
					var htmlEl = $('#' + field.uniqueId);
					var val = htmlEl.val();
					var decodedVal = $("<div/>").html(val).text();
					htmlEl.val(decodedVal);
				}
			});
		});

	};
	/**
	 * Reselects the More Actions..... selection in the secondary action control
	 */
	this.deselectCurrentSecondaryAction = function() {
		if (this.$secondaryActionsControl) {
			// Revert any secondary action back to 'More Actions....' so that
			// the user
			// can select the same secondary action again thereby triggering the
			// onchange event which will be correctly
			// trigger the page.submit() method to be called again.
			this.$secondaryActionsControl.get(0).selectedIndex = 0;
		}
	};

	/**
	 * Checks to see if any fields on the page have changed since it was
	 * initially loaded
	 */
	this.hasUnsavedChanges = function() {
		if (page.type == "roster")
			if (page.$rosterAddNewContainer.css("display") == "none")
				return false;
		if (this.isRedisplayWithErrors)
			return true;
		for (var i = 0; i < page.form.fields.length; i++)
			if (page.form.fields[i].getValue() != page.form.fields[i].initalValue)
				return true;

		return false;
	};

	/**
	 * Removes a specific entry from the secondary action select list.
	 * 
	 * @param actionValue
	 *            is the value of the entry to remove.
	 * @return true if removed else false.
	 * @type Boolean
	 */
	this.removeSecondaryAction = function(actionValue) {
		if (this.$secondaryActionsControl.length) {
			var findString = "option[value=\"" + actionValue + "\"]";
			this.$secondaryActionsControl.find(findString).remove();
		}
		return false;
	};

	/**
	 * Invokes the roster experience implementation.
	 */
	this.rosterExperience = function() {

		this.totalRosterEntries = this.$roster.find('tbody tr').length || 0;
		this.activeRosterEntries = $('table.roster tbody tr:not(.was-deleted,.emptyRosterRow)').length || 0;

		if (!this.recoverEnabled && this.supportOriginalValues) {
			var message = document.createElement('p');
			message.className = "rosterHelp";
			message
					.appendChild(document
							.createTextNode(ap.core_prompts["message.roster.CannotRecover"]));
			$(message).insertBefore(this.$rosterContainer.children().get(1));
		}
		// remove "save this page" option on rosters where it exists.
		this.removeSecondaryAction('Save');
		// create a copy for later callback
		var me = this;
		// creates the cancel button, opens up the add section, focuses on first
		// field.
		function openRosterAdd() {
			var btnGrp = me.$rosterAddNewContainer.find('.btn-group');
			if ($('#cancelButton').length == 0) {
				var cancelButton = $("<input/>", {
					"class" : "cancel btn btn-default",
					"type" : "button",
					"id" : "cancelButton",
					"click" : me.rosterCancelAction,
					"value" : ap.core_prompts["action.Cancel"]
				});

				btnGrp.append(cancelButton);
				me.$rosterAddNewContainer.css("display", 'block');
				me.$mainButtonContainer.css("display", 'none');
				;

				$('#rosterAddNewBtn').remove();
				$('#rosterDownFillEntitiesBtn').remove();
				me.focusOnFirstField(true);
				page.manageTabIndex();

				forceIEtoRepaintFooter();
			}
			if (me.activeRosterEntries < me.minEntries) {
				btnGrp.addClass('single-button');
			} else {
				btnGrp.removeClass('single-button');
			}
		}

		// creates the cancel button, opens up the account entities section
		function openAccountEntityAdd() {

			if ($('#cancelEntityButton').length == 0) {
				var cancelEntityButton = $("<input/>", {
					"class" : "cancel btn btn-default",
					"type" : "button",
					"id" : "cancelEntityButton",
					"click" : me.rosterCancelAction,
					"value" : ap.core_prompts["action.Cancel"]
				});

				var accountEntitiesContainer = $('#accountEntitiesContainer');
				accountEntitiesContainer.find('.btn-group').append(
						cancelEntityButton);

				$('#accountEntitiesContainer').css("display", 'block');
				me.$mainButtonContainer.css("display", 'none');

				$('#rosterDownFillEntitiesBtn').remove();
				$('#rosterAddNewBtn').remove();
				me.focusOnFirstField(true);
				page.manageTabIndex();

				forceIEtoRepaintFooter();
			}
			;

		}

		// IE8 Bug: force redraw of footer
		// https://www.squishlist.com/agencyport/productdev/53417/
		function forceIEtoRepaintFooter() {
			if ($('#footer').length && Prototype.Browser.IE) {
				var randomNumer = Math.floor(Math.random() * 110);
				$('#footer')[0].addClass("__IE8_REPAINT_FIX." + randomNumer);
				$('#footer')[0].removeClass("__IE8_REPAINT_FIX." + randomNumer);
			}
		}
		// END IE8 rendering bug code

		// creates the add link, closes the add section
		function closeRosterAdd() {
			me.$rosterAddNewContainer.css("display", "none");

			// create AddNew Button next to ContinueButton
			var addBtn = $("<input/>", {
				"class" : "add-new btn btn-default",
				"type" : "button",
				"id" : "rosterAddNewBtn",
				"click" : page.rosterAddAction,
				"value" : ap.core_prompts["action.AddNew"]
			});

			addBtn.insertAfter($('#continueButton'));

			// account entities container
			var accountContainer = $('#accountEntitiesContainer');
			if (accountContainer.length && !me.readOnly) {
				var downFillEntitiesBtn = $("<input/>", {
					"class" : "add-new btn btn-default",
					"type" : "button",
					"id" : "rosterDownFillEntitiesBtn",
					"click" : me.accountEntityAddAction,
					"value" : ap.core_prompts["action.AddFromAccount"]
				});

				downFillEntitiesBtn.insertAfter($('#continueButton'));

				var entities = $('.account_entity_checkbox');
				for (var c = 0; c < entities.length; c++) {
					entities[c].checked = false;
				}

				accountContainer.css("display", 'none');
				if ($('#cancelEntityButton').length) {
					$('#cancelEntityButton').remove();
				}
			}

			me.$mainButtonContainer.css("display", 'block');
			if ($('#cancelButton').length) {
				$('#cancelButton').remove();
			}
			page.manageTabIndex();

			forceIEtoRepaintFooter();
		}

		this.rosterAddAction = function() {
			openRosterAdd();
			if (typeof me.onAddOpen == 'function')
				me.onAddOpen();
		};
		this.accountEntityAddAction = function() {
			openAccountEntityAdd();
		};
		this.rosterCancelAction = function() {
			closeRosterAdd();
			if (typeof me.onAddClose == 'function')
				me.onAddClose();
		};
		this.executeRosterAction = function(actionType, anchor) {
			me.activeRosterActionAnchor = anchor;

			if (actionType == "edit"){
				if (typeof me.onRosterEdit == 'function'
						&& me.onRosterEdit() == false){
					return false;
				}
			}

			if (actionType == "delete"){
				if (typeof me.onRosterDelete == 'function'
						&& me.onRosterDelete() == false){
					return false;
				}
			}

			if (actionType == "copy"){
				if (typeof me.onRosterCopy == 'function'
						&& me.onRosterCopy() == false){
					return false;
				}
			}

			if (actionType == "recover"){
				if (typeof me.onRosterRecover == 'function'
						&& me.onRosterRecover() == false){
					return false;
				}
			}

			if (actionType == "viewFile"){
				if (typeof me.onRosterViewFile == 'function'
						&& me.onRosterViewFile() == false){
					return false;
				}
			}
			if (actionType == "view"){
				if (typeof me.onRosterView == 'function'
						&& me.onRosterView() == false){
					return false;
				}
			}

			me.activeRosterActionAnchor = null;
			return true;
		};
		function initializeRoster() {
			// TODO: change purejs code to Jquery
			if (me.activeRosterEntries >= me.maxEntries) {
				// remove the add new container
				me.$rosterAddNewContainer.remove();
				// me.$rosterAddNewContainer.parent().removeChild(me.rosterAddNewContainer);
				// invalidate the recover button on any deleted items

				// Find the actionCell column and then proceed to match
				// copyAction or recoverAction. An alert message is generated if
				// max Entries is exceeded.
				var rosterRows = me.$roster.find('tbody td.actionCell').find(
						'.copyAction , .recoverAction');

				rosterRows
						.map(function(index, actionItem) {

							actionItem.href = 'javascript:void(0);';
							var actionPrompt = ap
									.applyPositionalVariableSubstitutions(
											ap.core_prompts["action.MaxNumberOfItemsReached"],
											ap.core_prompts["action.MaxNumberOfItemsReached.1"]);

							ap.registerEvent(actionItem, 'click', function() {
								alert(actionPrompt);
							});
						});

			} else {
				closeRosterAdd();
				if (me.activeRosterEntries < me.minEntries) {
					openRosterAdd();
					// don't show roster display when none exist
					if (me.totalRosterEntries === 0) {
						me.$roster.css("display", 'none');
					}
					$('#cancelButton').css("display", 'none');
				}
			}
		}

		if (this.$rosterAddNewContainer.length)
			initializeRoster();

		function rosterHelp() {
			var header = ap.applyPositionalVariableSubstitutions(
					ap.core_prompts["helpText.roster.HelpWithThisList.Header"],
					me.title, "<span class='key'>", "</span>",
					"<span class='key'>", "</span>");
			var message = header;
			message += "<p>";
			message += "<h4 class='rosterHelp'>";
			message += ap.core_prompts["helpText.roster.HelpWithThisList.Key"];
			message += "</h4>";
			message += "<div class='rosterHelpContainer roster-help-container'>";
			message += "<p>"
					+ ap.core_prompts["helpText.roster.HelpWithThisList.Normal"]
					+ "</p>";
			message += "<p><i class='fa fa-plus'></i> <span class='was-added'>"
					+ ap.core_prompts["helpText.roster.HelpWithThisList.WasAdded"]
					+ "</span></p>";
			message += "<p><i class='fa fa-edit'></i> <span class='was-edited'>"
					+ ap.core_prompts["helpText.roster.HelpWithThisList.HasChanged"]
					+ "</span></p>";
			message += "<p><i class='fa fa-eye-open'> </i><span class='needs-visiting'>"
					+ ap.core_prompts["helpText.roster.HelpWithThisList.NeedsVisiting"]
					+ "</span></p>";
			message += "<p><i class='fa fa-trash-o'></i> <span class='was-deleted'>";
			message += ap
					.applyPositionalVariableSubstitutions(
							ap.core_prompts["helpText.roster.HelpWithThisList.WasDeleted"],
							"</span><span>", "</span>");
			message += "</p></div>";
			return message;
			// overlib(message, WIDTH, 400);
		}

		if (this.supportOriginalValues || this.isUploaded) {
			var helpDiv = document.createElement("div");
			helpDiv.setAttribute("class", "roster-popover");

			var helpA = document.createElement("a");
			helpA.setAttribute("data-content", rosterHelp());
			helpA.setAttribute("rel", "popover");
			helpA.setAttribute("class", "rosterHelp pull-right");
			helpA.setAttribute("data-original-title", "About This List");

			var i = document.createElement('i');
			i.setAttribute('class', 'fa fa-question-sign fa-2');
			helpA.appendChild(i);

			helpA.appendChild(document.createTextNode(" "
					+ ap.core_prompts["helpText.roster.HelpWithThisList"]));
			helpA.href = "#";
			ap.registerEvent(helpA, 'click', rosterHelp);

			helpDiv.appendChild(helpA);
			$(helpDiv).insertBefore(this.$rosterContainer.children().get(0));
			// TODO: change purejs code to Jquery

			var $rosterRows = this.$roster.find('tr.needs-visiting');

			$.each($rosterRows, function(idx, item) {
				var warningIcon = document.createElement('div');
				var title = ap.core_prompts["action.CorrectError"];
				warningIcon.title = title;
				$(warningIcon).addClass('needs-visiting');
				var $cell = $(item).find('td').first();
				$cell.prepend($(warningIcon));
				$cell.title = title;
			});
		}

		// reopen the "add" form on the redisplay of a roster page with critical
		// errors related to the add action
		if (this.messageSeverity == 'critical' && this.dataAccessType == 1) {
			if ($('#rosterAddNewBtn').length) {
				openRosterAdd();
			}
		}
	};

	/**
	 * Invokes the upload experience implementation.
	 */
	this.uploadExperience = function uploadExperience() {
		// If this is the first view of an uploaded work item, fabricate a
		// message for the user.
		if (this.isTransactionStartPoint) {
			if (this.showUploadedMessage) {
				ap.addLoadEvent(function() {
					$("#lb_upload_welcome").modal();
				});
			}
		}
	};

	/**
	 * Invokes the move work item experience implementation.
	 */
	this.linkAccountExperience = function linkAccountExperience() {
		var message = ap.account_management["account.actions.link.workitem.success1"]
				+ ' <b>' + ap.htmlDecode(this.linkAccountInfo) + '</b>.';
		$('#link-account-success #move-account-success-message1').html(message);
		$("#link-account-success").modal('show');
	};

	/**
	 * Invokes the read only experience implementation.
	 */
	this.readOnlyExperience = function() {
		var message = document.createElement("div");
		message.id = "readOnlyMessage";
		message.className = "read-only-message";
		var p = document.createElement("p");
		var msgText = ap.core_prompts["message.ReadOnly"];
		msgText += " ";
		if (this.lockedByOtherUser())
			msgText += ap.core_prompts["message.WorkItemLockedByOtherUser"];
		p.appendChild(document.createTextNode(msgText));
		message.appendChild(p);
		var $form = $("#" + this.form.id);
		if ($form.parent()) {
			$(message).insertBefore($form);
		}

		this.readOnlyMessage = message;

		$('#denotesRequired').first().css("display", "none");
		var $tips = $("div.tip_container");
		$tips.css("display", "none");

		try {
			this.$secondaryActionsControl.css("display", "none");
		} catch (e) {
		} // secondaryActions controls do not exist on roster edit pages.

		if (this.type == 'roster') {
			var $rosterHelp = this.$body.find(".rosterHelp");
			$rosterHelp.css("display", "none");

			$('#rosterAddNewBtn').css("display", "none");

			var $actionCells = this.$roster.find("td.actionCell a");

			$
					.each(
							$actionCells,
							function(idx, item) {
								var $achorItem = $(item);
								if (!$achorItem.hasClass("editAction")) {
									$achorItem.css("display", "none");
								} else {
									$achorItem
											.html(ap.core_prompts["action.View"]);
									$achorItem
											.attr(
													"title",
													ap.core_prompts["action.ClickToViewThisItemTitle"]);
								}
							});

		} else if (this.type == 'rosterEdit') {
			$('#saveButton').css("display", "none");
			$('#cancelButton').val(ap.core_prompts["action.Back"]);
		}
		for (var i = 0; i < this.form.fields.length; i++)
			this.form.fields[i].setReadOnly(true);
	};

	/**
	 * add an account entity
	 */
	this.addAccountEntity = function() {
		var $entities = $("input[name='CHECKBOX_ACCOUNT_ENTITY']:checked");
		if ($entities.length > 0) {
			var data = this.accountDownFillData[$entities.val()];
			for ( var key in data) {
				$('#' + key).val(data[key]);
			}
			this.rosterCancelAction();
			this.rosterAddAction();
		}
	};

	/**
	 * Construct a new Form object.
	 * 
	 * @constructor
	 * @class This is the basic Form class. The Form instance manages the Field
	 *        instances which are relate directly to fields which are either
	 *        hidden or visible but NOT excluded via DTR.
	 * @param htmlFormObject
	 *            is the actual DOM form element
	 * @param id
	 *            is the id of the enclosing page.
	 * @return A new Form instance
	 */
	function Form(htmlFormObject, id) {
		this.id = id;
		this.fields = new Array();
		this.fieldPositionsByUniqueId = {};
		this.elements = htmlFormObject.elements;

		this.submit = function() {
			var form = document.forms[this.id];
			form.submit();
		};

		this.getFieldByName = function(name) {
			$.each(this.fields, function(idx, field) {
				if (field.name === name) {
					return field;
				}
			});
			return false;
		};

		// add getFieldByUniqueId method to the page form
		this.getFieldByUniqueId = function(uniqueId) {
			var position = this.fieldPositionsByUniqueId[uniqueId];
			if (position != -1)
				return this.fields[position];
			else
				return null; // currently not in DOM
		};

		// add removeField method to the page form
		this.removeField = function(field) {
			var position = this.fieldPositionsByUniqueId[field.uniqueId];
			if (position != -1) {
				// Remove the Field reference from the forms array
				this.fields.splice(position, 1);
				// Replace the position for this field in our field positions
				// map with a -1
				this.fieldPositionsByUniqueId[field.uniqueId] = -1;
				// Decrement all field positions "after" the one that has been
				// removed
				// to reflect the removal
				for ( var uniqueId in this.fieldPositionsByUniqueId) {
					if (this.fieldPositionsByUniqueId[uniqueId] > position) {
						this.fieldPositionsByUniqueId[uniqueId] = this.fieldPositionsByUniqueId[uniqueId] - 1;
					}
				}
			}
		};
		// add addField method to the page form
		this.addField = function(field, checkForExistingMatch) {
			if (checkForExistingMatch) {
				var oldPosition = this.fieldPositionsByUniqueId[field.uniqueId];
				if (oldPosition !== undefined && oldPosition != -1) {
					this.fields[oldPosition] = field;
					return; // already there
				}
			}
			this.fieldPositionsByUniqueId[field.uniqueId] = this.fields.length;
			this.fields.push(field);
		};

		// add insertField method to the page form
		this.insertField = function(field, beforeField) {
			var oldPosition = this.fieldPositionsByUniqueId[field.uniqueId];
			if (oldPosition !== undefined && oldPosition != -1) {
				this.fields[oldPosition] = field;
				return; // already there
			}
			// Search for the insertion point
			var position = this.fieldPositionsByUniqueId[beforeField.uniqueId];
			if (position != -1) {
				// Rejigger the field positions for those form fields occupying
				// this position or beyond
				for ( var uniqueId in this.fieldPositionsByUniqueId) {
					if (this.fieldPositionsByUniqueId[uniqueId] >= position) {
						this.fieldPositionsByUniqueId[uniqueId] = this.fieldPositionsByUniqueId[uniqueId] + 1;
					}
				}
				// Now insert this field into the form fields array
				this.fields.splice(position, 0, field);
				this.fieldPositionsByUniqueId[field.uniqueId] = position;
			}
		};

		this.setupHotFields = function() {
			ap.consoleInfo("running this.setupHotFields");
			for (var ix = 0; ix < this.fields.length; ix++) {
				this.fields[ix].setupHotField();
			}
		};

		this.setupOverrideFields = function() {
			ap.consoleInfo("running this.setupOverrideFields");
			for (var ix = 0; ix < this.fields.length; ix++) {
				this.fields[ix].setupOverrideField();
			}
		};

		/**
		 * This method removes any fields which are in an excluded state from
		 * the this.fields array.
		 */
		this.removeExcludedFields = function() {
			var entriesRemoved = 0;
			for (var ix = 0; ix < this.fields.length;) {
				var field = this.fields[ix];
				if (field.isExcluded()) {
					this.fields.splice(ix, 1);
					entriesRemoved++;
				} else
					ix++;
			}
			if (entriesRemoved > 0) {
				for ( var uniqueId in this.fieldPositionsByUniqueId) {
					this.fieldPositionsByUniqueId[uniqueId] = -1;
				}
				for (var ix = 0; ix < this.fields.length; ix++) {
					var field = this.fields[ix];
					this.fieldPositionsByUniqueId[field.uniqueId] = ix;
				}
			}
		};

		this.clearFields = function() {
			this.fields = null;
			this.fields = new Array();
		};
	}

	/**
	 * Creates a Form instance and attaches it to the current Page instance.
	 * 
	 * @param htmlFormObject
	 *            is a reference to the HTML Form object for this web page.
	 */
	this.initializeForm = function(htmlFormObject) {
		this.form = new Form(htmlFormObject, this.id);
		return true;
	};

	/**
	 * This method walks through all of the field sets on this page and calls
	 * the paint method on each field set.
	 * 
	 * @param initialPaint
	 *            indicates whether this paint event is the initial paint
	 *            invocation which occurs during page.initialize() - as opposed
	 *            to subsequent page events which occur as a result of IPDTR
	 *            evaluations
	 */
	this.paint = function(initialPaint) {
		var paintPerf = new ap.PerfObject("page.paint");
		// set the global date format
		$.fn.datepicker.defaults.format = ap.format_info["default_display.datepicker.date_format"];
		$.fn.datepicker.defaults.forceParse = false;
		$.fn.datepicker.defaults.autoclose = true;
		$.fn.datepicker.defaults.showOnFocus = false;
		$.fn.datepicker.defaults.language = ap_locale;
		$.fn.datepicker.defaults.todayHighlight = true;

		ap.perfCollector.add(paintPerf);
		for (var ix = this.fieldsets.length - 1; ix >= 0; ix--) {
			this.fieldsets[ix].paint(initialPaint);
		}

		// original value experience management
		if (this.supportOriginalValues && !this.isUploaded) {
			for (var i = 0; i < this.form.fields.length; i++) {
				this.form.fields[i].supportOriginalValues('policyAdmin');
			}
		} else if (this.supportOriginalValues && this.isUploaded) {
			for (var i = 0; i < this.form.fields.length; i++) {
				this.form.fields[i].supportOriginalValues('upload');
			}
		}

		this.form.removeExcludedFields();

		this.manageTabIndex();

		if (!this.readOnly) {
			if (this.autoSaveData && initialPaint) {
				// Set auto-save data onPaint because some of the auto-saved
				// fields
				// may not be present on the page when initialized.
				this.setAutoSaveData();
			}
		}

		this.initializePopovers();

		if (typeof this.onPaint == 'function') {
			this.onPaint();
		}

		// textarea maxlength
		$("textarea[maxsize]").each(function(i) {
			ap.registerEvent(this, 'keyup', function(e) {
				var limit = parseInt($(this).attr('maxsize'));
				var text = $(this).val();
				if (text.length > limit) {
					$(this).val(text.substr(0, limit));
				}
			});
		});

		paintPerf.stop();
	};

	/*
	 * Post adding fields, we need to initialize bootstrap3 pop overs.
	 */
	this.initializePopovers = function() {

		if ($('.tooltip-balloon').length) {
			$('.tooltip-balloon').popover();
		}

		if ($('.deleteAction').length) {
			$('.deleteAction').popover();
		}

		if ($('.tooltip-validation').length) {
			$('.tooltip-validation').tooltip({
				delay : {
					show : 500,
					hide : 100
				}
			});
		}

		if ($('.rosterHelp').length) {
			$(".rosterHelp").popover({
				placement : 'bottom',
				html : 'true',
				trigger : 'focus'
			});
		}
		if ($('.fieldHelper').length) {
			$(".fieldHelper").popover({
				placement : 'right',
				html : 'true',
				trigger : 'focus'
			});
		}

		if ($('.account-link').length) {
			$(".account-link").popover({
				placement : 'bottom',
				html : 'true',
				trigger : 'hover'
			});
		}
	};

	/*
	 * set the focus to the next field, previous field or back to the current
	 * field based on the key down event.
	 */
	this.setIPDTRFieldFocus = function() {
		if (!this.originHotField) {
			return;
		}
		this.setFocusFields();
		var nextField = this.nextFocusField;
		var previousField = this.previousFocusField;
		var field = this.originHotField;

		// reset this to previous in case focus is lost to window
		this.fieldThatReceivedFocus = null;

		// if field helpers are part of tabbing order then just let the browser
		// set focus
		if (field.hotfieldLastKey == 'tab'
				&& (field.getFieldHelperCount() === 0 || !this.supportsFieldHelperTabbing)) {
			ap.consoleInfo("Tab key down setting focus to next field.");
			if (nextField != null) {
				if (nextField.isRadio()) {
					this.fieldThatReceivedFocus = nextField.elements[0];
					this.setRadioFieldFocus(nextField);
				} else {
					$("#" + nextField.getUniqueId()).focus().select();
					this.fieldThatReceivedFocus = nextField.elements[0];
				}
			} else {
				$("#" + field.getUniqueId()).focus().select();
				this.fieldThatReceivedFocus = field.elements[0];
			}
		} else if (field.hotfieldLastKey == 'arrow') {
			ap
					.consoleInfo("Arrow or alphanumeric key down setting focus to origin hot field.");
			if (field.isRadio()) {
				this.fieldThatReceivedFocus = field.elements[0];
				this.setRadioFieldFocus(field);
			} else {
				$(previousField.elements[0]).focus();
				$("#" + field.getUniqueId()).focus().select();
				this.fieldThatReceivedFocus = field.elements[0];
			}
		} else if (field.hotfieldLastKey == 'shifttab'
				&& (previousField.getFieldHelperCount() === 0 || !this.supportsFieldHelperTabbing)) {
			ap
					.consoleInfo("Shift tab key down setting focus to previous field.");
			$("#" + previousField.getUniqueId()).focus().select();
			this.fieldThatReceivedFocus = previousField.elements[0];
		}

		field.hotfieldLastKey = null;
		this.originHotField = null;
		this.nextFocusField = null;
		this.previousFocusField = null;
	};

	this.setRadioFieldFocus = function(field) {
		var elementToFocus = field.elements[0];
		if (field.elements[0].checked === true) {
			elementToFocus = field.elements[0];
		} else {
			elementToFocus = field.elements[1];
		}
		this.fieldThatReceivedFocus = elementToFocus;
		// Scroll to the field accounting for menu bar size
		var $el = $("#" + elementToFocus.id);
		if (!$el.visible()) {
			if ($('#main-menu').length) {
				var elOff = $el.offset().top;
				elOff = elOff - $('#main-menu')[0].scrollHeight - 10; // 10 is
																		// buffer
				$('body,html').animate({
					scrollTop : elOff
				}, 100);
			}
		}
		elementToFocus.focus();
	};

	/*
	 * Set pointer to the fields that are next and previous to the
	 * originHotField
	 */
	this.setFocusFields = function() {
		ap.consoleInfo("Setting previous and next fields that could get focus");
		var focusField = null;
		for (var i = 0; i < this.fieldsets.length; i++) {
			var fieldSetObject = this.fieldsets[i];
			for (var j = 0; j < fieldSetObject.fields.length; j++) {
				var field = fieldSetObject.fields[j];

				if (!fieldSetObject.isExcluded()) {
					if (field == this.originHotField) {
						focusField = field;
					} else if (focusField == null) {
						if (field.isFocusable()) {
							this.previousFocusField = field;
						}
					} else if (focusField != null
							&& this.nextFocusField == null) {
						if (field.isFocusable()) {
							this.nextFocusField = field;
						}
					}
				}
			}
		}

		if (this.nextFocusField == null) {
			this.nextFocusField = focusField;
		}
		if (this.previousFocusField == null) {
			this.previousFocusField = focusField;
		}
	};

	/**
	 * Nulls out any references to any existing DOM objects,invokes every
	 * Fieldset instance's shutDown() method, and unregisters all existing
	 * registered events. This breeks circular relationships between DOM and
	 * JavaScript thereby preventing browser memory leaks.
	 */
	this.shutDown = function() {
		if (ap.debugShutdown)
			alert('in page shutdown');
		for (var ix = 0; ix < page.fieldsets.length; ix++) {
			page.fieldsets[ix].shutDown();
		}
		page.fieldsets.splice(0, page.fieldsets.length);
		page.fieldsets = null;
		page.$mainButtonContainer = null;
		page.$secondaryButtonContainer = null;
		page.$rosterContainer = null;
		page.$roster = null;
		page.$secondaryActionsControl = null;
		page.tips = null;

		// unhook helper methods attached to the DOM form to prevent memory
		// leaks in Internet Explorer
		page.form.elements = null;
		page.form.getFieldByName = null;
		page.form.getFieldByUniqueId = null;
		page.form.removeField = null;
		page.form.addField = null;
		page.form.insertField = null;
		page.form.setupHotFields = null;
		page.form.removeExcludedFields = null;
		page.form.fieldPositionsByUniqueId = null;
		page.form.fields.splice(0, page.form.fields.length);
		page.form.fields = null;
		page.form = null;
		page.body = null;
		page.fieldThatRecievedFocus = null;
	};

	/**
	 * do not send up after idling for a while to avoid keeping session alive
	 */
	this.shouldSendUpdate = function shouldSendUpdate() {

		if (this.autoSaveInterval == 0) {
			return false;
		}
		var currentTime = new Date();
		if (this.lastAutoSavedTime == 0) {
			this.lastAutoSavedTime = currentTime.getTime();
		}
		return true;
	};

	this.setLastAutoSavedTime = function setLastAutoSavedTime() {
		var currentTime = new Date();
		this.lastAutoSavedTime = currentTime.getTime();
	};

	/**
	 * This method is invoked automatically by dynamicpage.jsp after the page
	 * has been rendered.
	 */
	this.initialize = function initialize() {

		this.setLastAutoSavedTime();

		var pageInitPerfObject = new ap.PerfObject("Total Page.initialize");
		ap.perfCollector.add(pageInitPerfObject);

		if (!this.form)
			return false;
		var beginInitializePerf = new ap.PerfObject("beginning Page.initialize");
		ap.perfCollector.add(beginInitializePerf);

		// create pointers to the key HTML elements on the page
		this.setMainButtonContainer();
		this.setSecondaryButtonContainer();
		this.setSecondaryActionsControl();
		// Remove the following secondary actions if this is a brand new work
		// item.
		if (transaction.firstTime) {
			this.removeSecondaryAction('SaveToDefaults');
			this.removeSecondaryAction('ConvertToApplication');
		}
		this.setBody();
		this.setTips();

		if (this.type == "roster") {
			this.setRosterContainer();
			this.setRosterAddNewContainer();
			this.setRoster();

			// trigger roster experience management
			// initializes activeRosterEntries, required below
			this.rosterExperience();

			// Remove add button and add section if suppression of add action is
			// true.
			if (this.suppressAddAction) {
				$('#rosterAddNewBtn').remove();
				$('#rosterAddNew').remove();
			}
		}

		beginInitializePerf.stop();
		var setUpHotFieldsAndOriginalValuesPerf = new ap.PerfObject(
				"setup Hot fields and original value experience Page.initialize");
		ap.perfCollector.add(setUpHotFieldsAndOriginalValuesPerf);

		// Set up hot fields
		ap
				.consoleInfo("About to setup hotfields from the page object by calling form.setupHotFields()");
		this.form.setupHotFields();

		this.form.setupOverrideFields();

		setUpHotFieldsAndOriginalValuesPerf.stop();

		// Invoke the painting intrapage DTR
		this.paint(true);

		// trigger ipdtr call when first time and a hotfield has a default value
		var isDefaultIPDTRRequired = false;
		if (this.isFirstView) {
			isDefaultIPDTRRequired = true;
		}

		if (this.type == "roster") {
			// only call IPDTR by default if under maxEntries
			isDefaultIPDTRRequired = (this.activeRosterEntries < this.maxEntries);
		}

		// make the call for the first hotfield with a default value that is not
		// empty
		// if there is auto-save data available, we defer to that to trigger any
		// needed IPDTR calls
		if (isDefaultIPDTRRequired && this.getHasHotFields()
				&& !this.autoSaveData) {
			var fieldsLength = this.form.fields.length;
			var makeRequest = true;
			for (var ix = 0; ix < fieldsLength && makeRequest; ix++) {
				if (this.form.fields[ix].isHot
						&& this.form.fields[ix].autoInvokeAJAX
						&& this.form.fields[ix].defaultValue
						&& this.form.fields[ix].defaultValue.length > 0) {
					this.form.fields[ix].makeIntraPageDTRRequest(true);
					makeRequest = false;

				}
			}
		}
		// Trigger prevalidation if first view and data available.
		if (this.downfillValidation
				&& (this.isUploaded || (this.isFirstView && this.hasDataAvailable))) {
			this.preValidate();
		}

		// trigger upload experience management
		if (this.isUploaded)
			this.uploadExperience();
		// trigger read only experience management
		if (this.readOnly)
			this.readOnlyExperience();

		// create a flag to manage user exit on unsaved change
		this.checkSaveStatus = true;
		// keep track of the target menu item when a menu click is intercepted
		// during a page unload due to navigation
		this.navigatingToPage = null;
		// check to see that 1) there are no unsaved changes on the page 2) the
		// user has not said they don't care and want to move on anyway.
		var $self = this;
		var pageUnloadSaveCheck = function(MenuEntry) {
			if (page.hasUnsavedChanges() && page.checkSaveStatus) {
				page.navigatingToPage = MenuEntry;
				page.action = 'left_nav_menu';
				$("#lb_confirm_exit").modal();
				return false;
			}

			$self.pleaseWait(true);
			return true;
		};
		if (this.hasMenu()) {
			// register the unload check as a 'clickEvent' to each menu entry on
			// this pages left hand side
			for (var i = 0; i < this.menu.entries.length; i++)
				this.menu.entries[i].addClickEvent(pageUnloadSaveCheck);
		}

		// Initialize snippets for this page.
		$(document)
				.ready(
						$
								.proxy(
										function() {
											var snipImages = $('.snippet-image');
											ap
													.consoleInfo("Starting snippet init.");
											for (var i = 0; i < snipImages.length; i++) {
												var pageImg = $(snipImages[i]);
												if (this.snippetHandlers[pageImg
														.attr('id')]) {
													ap
															.consoleInfo("snippets page already initialized + "
																	+ pageImg
																			.attr('id'));
													return;
												}
												if (pageImg.attr('complete')) {
													ap
															.consoleInfo("initializing snippets for already loaded image");
													var snippetHandler = new ap.Snippet(
															pageImg);
													this.snippetHandlers[pageImg
															.attr('id')] = snippetHandler;
												} else {
													ap
															.consoleInfo("Snippet initialization scheduled");
													setTimeout(
															(function(handlers) {
																ap
																		.consoleInfo("initializing snippets"
																				+ pageImg
																						.attr('id'));
																var snippetHandler = new ap.Snippet(
																		pageImg);
																handlers[pageImg
																		.attr('id')] = snippetHandler;
																page
																		.focusOnFirstField(false);
															})
																	(this.snippetHandlers),
															1000);
												}
											}
											var allPages = $(".snippet-body");
											for (var i = 0; i < allPages.length; i++) {
												if (i == 0) {
													$(allPages[i]).show();
												} else {
													$(allPages[i]).hide();
												}
											}
										}, this));

		// execute the onInitialize method
		if (typeof this.onInitialize == 'function')
			this.onInitialize();

		// open the debug console if there is one
		try {
			debugConsole.open();
		}
		// there must not be a debug console
		catch (e) {
		}

		// Register my shutdown method
		ap.registerEvent(window, 'unload', this.shutDown);

		// hide the body until the last moment to prevent change flashing
		try {
			this.$body.css("display", '');
		} catch (e) {
		}

		this.pleaseWait(false);
		// set focus on the first non-hidden form element
		this.focusOnFirstField();

		if (!this.readOnly) {
			if (this.autoSaveInterval > 0) {
				// don't run auto save when the work item is in first time
				// no record will show up on wip and we end up with record in
				// auto save store that will never be accessed.
				if (!ap.transaction.firstTime) {
					this.autoSave();
				}

				if (!this.autoSaveData && ap.transaction
						&& !ap.transaction.firstTime) {
					// this is for tracking the last visited page
					// don't want to track this if they have not saved
					// in that case this would never show up on the WIP
					this.sendAutoSaveRequest(0);
				}
			}
		}

		var workItemLock = new ap.WorkItemLockWidget(ap.transaction.workItemId,
				ap.transaction.id, this.id, this.clientUpdateInterval,
				this.csrfToken, this);

		workItemLock.acquireLock();

		pageInitPerfObject.stop();
		ap.consoleInfo(ap.perfCollector.print());
		ap.perfCollector.clear();

		// close popover while clicking outside
		$('body')
				.on(
						'click',
						function(e) {
							$('[data-toggle="popover"]')
									.each(
											function() {
												if (!$(this).is(e.target)
														&& $(this)
																.has(e.target).length === 0
														&& $('.popover').has(
																e.target).length === 0) {
													$(this).popover('hide');
												}
											});
						});

		if (this.linkAccountInfo != '') {
			this.linkAccountExperience();
		}

		return true;
	};

	/**
	 * The <code>supportsMaskForField</code> defines whether the page supports
	 * format masking for the given field. The base page implementation will
	 * always return true, custom code can replace this function to add
	 * conditional logic of their own.
	 */
	this.supportsMaskForField = function(field, supportsMaskIndicator,
			formatSettings, formatMask) {
		// this is a hookpoint which programmers can override
		return true;
	}

	/**
	 * The <code>lowConfidenceThreshold</code> is used for OCR Turnstile
	 * uploads. Should be filled from framework.properties entry. Default 0.
	 */
	this.setLowConfidenceThreshold = function(threshold) {
		this.lowConfidenceThreshold = threshold;
	}
};

// Establish interest level constants
if (ap.constants.InterestLevel === undefined) {
	ap.constants.InterestLevel = {};
	/**
	 * The <code>INTEREST_LEVEL_ALTER</code> constant is the value which
	 * indicates the related page entity was altered.
	 * 
	 * @type Number
	 * @final
	 */
	ap.constants.InterestLevel.INTEREST_LEVEL_ALTER = 4;
	/**
	 * The <code>INTEREST_LEVEL_EXCLUDE</code> constant is the value which
	 * indicates the related page entity should be excluded.
	 * 
	 * @type Number
	 * @final
	 */
	ap.constants.InterestLevel.INTEREST_LEVEL_EXCLUDE = 1;
	/**
	 * The <code>INTEREST_LEVEL_INCLUDE</code> constant is the value which
	 * indicates the related page entity should be included.
	 * 
	 * @type Number
	 * @final
	 */
	ap.constants.InterestLevel.INTEREST_LEVEL_INCLUDE = 2;
}

/**
 * Construct a new InterestLevel object.
 * 
 * @constructor
 * @class This is the basic InterestLevel class. It encapsulates the
 *        functionality around the DTR interest level.
 * @param interestLevel
 *            is the numeric interest level to initially set this instance to.
 * @param initialDirtyFlagSetting
 *            is the initial dirty flag to be set.
 * @return A new InterestLevel
 */
ap.InterestLevel = function(interestLevel, initialDirtyFlagSetting) {
	// if we are just initializing interest level the dirty flag will
	// always be false so we do the check here.
	if (interestLevel == ap.constants.InterestLevel.INTEREST_LEVEL_EXCLUDE) {
		initialDirtyFlagSetting = true;
	}
	/**
	 * The <code>interestLevel</code> field indicates the current interest
	 * level for the related page entity.
	 * 
	 * @type Number
	 */
	this.interestLevel = interestLevel;
	/**
	 * Returns whether the interest level field stored carries an exclusion
	 * interest level state
	 * 
	 * @return a boolean value indicating whether or not the related domain
	 *         instance (Fieldset or Field) has been excluded.
	 * @type Boolean
	 */
	this.isExcluded = function() {
		return this.interestLevel == ap.constants.InterestLevel.INTEREST_LEVEL_EXCLUDE;
	};
	/**
	 * The <code>dirty</code> field carries the dirty flag. This is true in
	 * the case when a page entity's interest level has changed during an
	 * IntraPage DTR AJAX call.
	 * 
	 * @type Boolean
	 */
	this.dirty = initialDirtyFlagSetting;

	/**
	 * Sets the interest level if the incoming interest level is different than
	 * the one currently being maintained.
	 * 
	 * @param interestLevel
	 *            is the interest level value to set on this interest
	 */
	this.setInterestLevel = function(interestLevel) {
		var previousExclusion = this.isExcluded();
		this.interestLevel = interestLevel;
		var currentExclusion = this.isExcluded();
		this.dirty = previousExclusion != currentExclusion;
	};

	/**
	 * Returns the interest level numeric value.
	 * 
	 * @return the interest level associated with the related page entity.
	 * @type Number
	 * @see InterestLevel#INTEREST_LEVEL_EXCLUDE
	 * @see InterestLevel#INTEREST_LEVEL_INCLUDE
	 * @see InterestLevel#INTEREST_LEVEL_ALTER
	 */
	this.getInterestLevelValue = function() {
		return this.interestLevel;
	};

	/**
	 * Returns whether or not this interest level instance has been dirtied.
	 * 
	 * @return the interest level value
	 * @type Boolean
	 */
	this.isDirty = function() {
		return this.dirty;
	};

	/**
	 * Clears the dirty flag.
	 */
	this.clearDirtyFlag = function() {
		this.dirty = false;
	};
};

/**
 * Construct a new Fieldset object.
 * 
 * @constructor
 * @class This is the basic Fieldset class. It relates loosely to the server
 *        side BasePageElement class.
 * @param parentPage
 *            is a reference to the singleton page instance
 * @param id
 *            is the field set identifier
 * @param interestLevel
 *            is the initial numeric interest level value to take on
 * @return A new Fieldset
 */
ap.Fieldset = function(parentPage, id, interestLevel) {
	var me = this; // used to create a copy of this object for later callbacks
					// from page events
	/**
	 * The <code>id</code> field carries the TDF unique identifier for this
	 * field set instance.
	 * 
	 * @type String
	 */
	this.id = id;
	/**
	 * The <code>parentPage</code> field is a reference back to the Page
	 * instance to which this field set belongs.
	 * 
	 * @type Page
	 */
	this.parentPage = parentPage;
	/**
	 * The <code>fields</code> field is an array of the Field instances
	 * contained within this field set instance regardless of their respective
	 * interest levels.
	 * 
	 * @type Array
	 */
	this.fields = new Array();
	/**
	 * The <code>interestLevel</code> property is an InterestLevel instance
	 * which maintains the interest level for this field set.
	 * 
	 * @type InterestLevel
	 */
	this.interestLevel = new ap.InterestLevel(interestLevel,
			interestLevel == ap.constants.InterestLevel.INTEREST_LEVEL_EXCLUDE);
	/**
	 * The <code>relativePosition</code> property tracks the position this
	 * field set resides relative to other field sets.
	 * 
	 * @type Number
	 */
	this.relativePosition = this.parentPage.addFieldset(this); // add to parent
	/**
	 * The <code>domElement</code> is the Jquey Obj for DOM HTML element
	 * related to this instance.
	 */
	this.$domElement = $("#" + id);
	/**
	 * The <code>domElementParentNode</code> is the jquery object for the
	 * parent of the DOM HTML element related to this instance. This is needed
	 * when the interest level of field set is toggled from 'excluded' to
	 * 'included'.
	 */
	this.$domElementParentNode = this.$domElement.parent();

	this.getDOMElement = function() {
		return this.$domElement;
	};

	this.getDOMElementParent = function() {
		return this.$domElementParentNode;
	};

	/**
	 * Returns the id for this field set.
	 * 
	 * @return the id for this field set.
	 * @type String
	 */
	this.getId = function() {
		return this.id;
	};

	/**
	 * Returns the parent page of this field set.
	 * 
	 * @return the parent page of this field set.
	 * @type Page
	 */
	this.getParent = function() {
		return this.parentPage;
	};
	/**
	 * Returns the array of Field instances containing within this field set.
	 * 
	 * @return the array of Field instances containing within this field set.
	 * @type Array
	 */
	this.getFields = function() {
		return this.fields;
	};
	/**
	 * Adds a Field instance to the array of fields maintained by this instance.
	 * 
	 * @param field
	 *            is the Field instance to add
	 * @return the index position of where this Field instance was added.
	 * @type Number
	 */
	this.addField = function(field) {
		return this.fields.push(field) - 1;
	};

	/**
	 * Inserts a Field instance into the array of fields at a particular
	 * position.
	 * 
	 * @param field
	 *            is the Field instance to insert.
	 * @parm position is the position where to insert.
	 * @return the index position of where this Field instance was added.
	 * @type Number
	 */
	this.insertField = function(field, position) {
		if (position >= this.fields.length)
			return this.addField(field);
		else {
			var testField;
			for (var ix = position; ix < this.fields.length; ix++) {
				testField = this.fields[ix];
				if (testField.relativePosition >= position) {
					position = ix;
					break;
				}
			}
			this.fields.splice(position, 0, field);
			for (var ix = position; ix < this.fields.length; ix++) {
				testField = this.fields[ix];
				testField.relativePosition = ix;
			}

			return position;
		}
	};

	/**
	 * Sets the legend on this field set which is visible to the user.
	 * 
	 * @param legend
	 *            is the legend of the field set to set
	 */
	this.setLegend = function(legend) {
		var children = this.getDOMElement().children();
		if (children.length > 0 ){
			children.first().html(ap.htmlDecode(legend));
		}
	};

	/**
	 * Removes this field set from the DOM.
	 */
	this.exclude = function() {
		this.$domElement.remove();
	};

	/**
	 * This will return the first field beyond the position passed which is not
	 * currently excluded.
	 * 
	 * @param relativePosition
	 *            establishes the position to begin looking at in the fields
	 *            array maintained by this fieldset instance for a match.
	 * @return the field closest beyond the relative position
	 * @type Field
	 */
	this.getNextClosestIncludedField = function(relativePosition) {
		for (var ix = relativePosition + 1; ix < this.fields.length; ix++) {
			var field = this.fields[ix];
			if (!field.isExcluded())
				return field;
		}
		return null;
	};

	/**
	 * Adds this field set back into the DOM at it's initial relative position.
	 */
	this.include = function() {
		var nextIncludedFieldset = this.parentPage
				.getNextClosestIncludedFieldset(this.relativePosition);
		var $insertBefore = null;
		if (nextIncludedFieldset != null) {
			$insertBefore = nextIncludedFieldset.getDOMElement();
		} else {
			// Place before last set of buttons
			var $divButtons = this.getDOMElementParent().find("div.buttons");
			$insertBefore = $divButtons.last();
		}
		this.getDOMElement().insertBefore($insertBefore);
	};

	/**
	 * Applies inclusion or exclusion which ever the case may be.
	 * 
	 * @param initialPaint
	 *            indicates whether this paint event is the initial paint
	 *            invocation which occurs during page.initialize() - as opposed
	 *            to subsequent page events which occur as a result of IPDTR
	 *            evaluations
	 */
	this.paint = function(initialPaint) {
		var isDirty = this.interestLevel.isDirty();
		if (isDirty) {
			if (this.interestLevel.isExcluded()) {
				this.exclude();
			} else {
				this.include();
			}
		}
		for (var ix = this.fields.length - 1; ix >= 0; ix--) {
			this.fields[ix].paint(isDirty, initialPaint);
		}
		this.interestLevel.clearDirtyFlag();
	};

	/**
	 * Finds the Field instance for the given field unique id.
	 * 
	 * @param fieldid
	 *            is the field's unique id
	 * @return the Field instance containing that unique id else null if not
	 *         found.
	 * @type Field
	 */
	this.getField = function(fieldId) {
		for (var ix = 0; ix < this.fields.length; ix++) {
			if (this.fields[ix].getUniqueId() == fieldId
					|| fieldId == this.fields[ix].getTdfId()) {
				return this.fields[ix];
			}
		}
		return null;
	};

	/**
	 * Returns the InterestLevel instance (not the value) for this field set.
	 * 
	 * @return the InterestLevel instance associated with this field set.
	 * @type InterestLevel
	 */
	this.getInterestLevel = function() {
		return this.interestLevel;
	};

	/**
	 * Returns whether or not this field set is excluded
	 * 
	 * @return true if the interest level on this field set is exclude
	 * @type Boolean
	 */
	this.isExcluded = function() {
		return this.interestLevel.isExcluded();
	};

	/**
	 * Nulls out any references to any existing DOM objects and invokes every
	 * Field instance's shutDown() method.
	 */
	this.shutDown = function() {
		this.parentPage = null;
		for (var ix = 0; ix < this.fields.length; ix++)
			this.fields[ix].shutDown();
		// potential gc
		this.fields.splice(0, this.fields.length);
		this.fields = null;
		this.$domElement = null;
		this.$domElementParentNode = null;

	};
};

/**
 * Construct a new Field object.
 * 
 * @constructor
 * @class This is the basic Field class. It relates loosely to the server side
 *        BaseElement class. The field Object creates a layer of abstraction
 *        over its member elements and gives a developer common ways to do
 *        things like getting and setting values. The AgencyPortal framework
 *        creates a Field object for every user facing control rendered.
 * @param form
 *            is the HTML form element for this document
 * @param uniqueId
 *            is the unique id for this field (currently same as name)
 * @param parentFieldset
 *            is field set to which this field belongs
 * @param interestLevel
 *            is the initial numeric interest level to apply to this field
 * @param fieldElementType
 *            is the TDF field type as in filterlist, message, radio, etc.
 * @param isHot
 *            is a boolean which designates whether a field is hot or not
 * @param autoInvokeAJAX
 *            is a boolean which designates whether a hot field should
 *            automatically invoke the Intrapage DTR AJAX server side method or
 *            not.
 * @param blockDataEntry
 *            is a boolean flag used to prevent changing of data by the user
 *            while an IPDTR call is in progress, cover the page with a please
 *            wait 1:11 PM 12/9/20071:11 PM 12/9/2007.
 * @param newFormRowSnippet
 *            contains the HTML snippet for a brand new field introduced by
 *            IPDTR. This in only used when a new field is introduced via an
 *            IPDTR call.
 * @param positionInFieldSet
 *            contains the relative position the field sits in the field set in
 *            relation to its siblings. This in only used when a new field is
 *            introduced via an IPDTR call.
 * @return A new Field
 */
ap.Field = function(form, htmlSafeId, uniqueId, parentFieldset, interestLevel,
		fieldElementType, isHot, autoInvokeAJAX, blockDataEntry,
		newFormRowSnippet, positionInFieldSet) {

	var me = this; // used to create a copy of this object for later callbacks
					// from page events

	/**
	 * The <code>newIPDTRContent</code> reflects whether this is a brand new
	 * field introduced by an IPDTR call. This flag will only be true for a
	 * quick moment while an IPDTR call is being processed.
	 * 
	 * @type Boolean
	 */
	this.newIPDTRContent = newFormRowSnippet != null;
	var newFormRow = null;
	if (this.newIPDTRContent) {
		// Create an element on the fly from the HTML snippet sent in by IPDTR
		// if this is a question we need to create a table to insert row into
		// otherwise it won't work
		if (fieldElementType == "question") {
			// newFormRow = new Element('table', {'class':
			// 'foo'}).update(newFormRowSnippet);
			newFormRow = $(newFormRowSnippet);
			// newFormRow = newFormRow.down('tr');
		} else {
			newFormRow = $(newFormRowSnippet);
			newFormRow = newFormRow.get(0);
		}
	}

	/**
	 * The <code>fieldElementType</code> property carries the field element
	 * type as in 'radio', etc. The AP 'type' of Field (i.e. text, textarea,
	 * filterlist, question, etc).
	 * 
	 * @type String
	 */
	this.fieldElementType = fieldElementType; // the type of TDF field element
												// from which this object was
												// generated

	/**
	 * The <code>name</code> field is here for backward compatibility and is
	 * an alias for <code>uniqueId</code>. The two are currently equivalent.
	 * 
	 * @type String
	 */
	this.name = htmlSafeId; // the name attribute on the field's member elements
	/**
	 * The <code>uniqueId</code> field is the TDF unique identifier for this
	 * field. It is no longer necessarily the ACORD Path.
	 * 
	 * @type String
	 */
	this.uniqueId = htmlSafeId;
	/**
	 * The <code>htmlSafeId</code> field is the TDF unique identifier for this
	 * field. It is no longer necessarily the ACORD Path.
	 * 
	 * @type String
	 */
	this.tdfId = uniqueId;
	/**
	 * The <code>parentFieldset</code> field is the field set instance to
	 * which this field belongs.
	 * 
	 * @type Fieldset
	 */
	this.parentFieldset = parentFieldset;
	/**
	 * The <code>autoInvokeAJAX</code> when set to <b>true</b> (which is the
	 * SDK default) will cause the AJAX Intrapage DTR server method to be
	 * invoked. When set to <b>false</b> the SDK does not register a change
	 * event with the browser with the assumption that the application has
	 * custom code which has registered its own event to manage the invocation
	 * of the AJAX Intrapage DTR server method. To programmatically launch the
	 * AJAX method for application's wishing to manage this experience
	 * themselves should call the method on this class
	 * <code>makeIntraPageDTRRequest</code>.
	 * 
	 * @type Boolean #see #makeIntraPageDTRRequest
	 */
	this.autoInvokeAJAX = autoInvokeAJAX;

	/**
	 * The <code>blockDataEntry</code> when set to <b>true</b> (which is NOT
	 * the SDK default) will cause a please wait lightbox to cover the page
	 * during an IPDTR call is in progress instead of just the Loading graphic.
	 * 
	 * @type Boolean
	 */
	this.blockDataEntry = blockDataEntry;

	// Calculate initial interest level dirty flag. For new dynamic IPDTR
	// content it
	// should always be set to true
	var initialInterestLevelDirtyFlag = interestLevel == ap.constants.InterestLevel.INTEREST_LEVEL_EXCLUDE;
	if (this.newIPDTRContent)
		initialInterestLevelDirtyFlag = true;
	/**
	 * The <code>interestLevel</code> field is the interest level instance
	 * which applies to this field.
	 * 
	 * @type InterestLevel
	 */
	this.interestLevel = new ap.InterestLevel(interestLevel,
			initialInterestLevelDirtyFlag);
	/**
	 * The <code>defaultValue</code> field is the default value configured in
	 * the TDF for this field.
	 * 
	 * @type String
	 */
	this.defaultValue = null;
	/**
	 * The <code>formRowParent</code> field is Jquery object for the HTML
	 * element parent of the form row HTML element. This comes into play when
	 * the interest level of a field is toggled from 'excluded' to 'included'.
	 */
	this.$formRowParent = null;
	/**
	 * The <code>relativePosition</code> property is the field position where
	 * this field resides in relation to the other fields in this field set.
	 * 
	 * @type Number
	 */
	this.relativePosition = -1;
	if (this.newIPDTRContent)
		this.relativePosition = this.parentFieldset.insertField(this,
				positionInFieldSet);
	else
		this.relativePosition = this.parentFieldset.addField(this);

	/**
	 * The <code>listRefreshed</code> flag is used for tracking when a filter
	 * list field is refreshed upon an intrapage DTR return.
	 * 
	 * @type Boolean
	 */
	this.listRefreshed = false;

	/**
	 * The <code>listEntrySelected</code> flag is used for tracking when a
	 * list is refreshed to see if an entry has been selected or not. If not
	 * then the first item is selected.
	 * 
	 * @type Boolean
	 */
	this.listEntrySelected = true;

	/**
	 * The <code>isHot</code> flag is set to true if this is a hot field.
	 * 
	 * @type Boolean
	 */
	this.isHot = isHot;

	/**
	 * The <code>ghostField</code> is used when a field is read only.
	 */
	this.$ghostField = null;

	/**
	 * The <code>optionList</code> is a temporary holding place for the select
	 * list inner html content when a list is rebuilt via IPDTR.
	 */
	this.optionListContent = null;

	this.filterListContent = null;
	/**
	 * The <code>selectListParent</code> holds onto the original select list
	 * element parent since when the innerHTML is overwritten the parent node of
	 * the resultant select list HTML element is nullified.
	 */
	this.$selectListParent = null;

	/**
	 * The <code>fieldFormatMask</code> holds the reference to object that
	 * performs to field format mask.
	 */
	this.fieldFormatMask = null;

	/**
	 * The <code>hasFormatMask</code> indicates if the field has format mask.
	 */
	this.hasFormatMask = false;

	/**
	 * The <code>supportsmask</code> indicates if the field supports a fixed
	 * length mask. This will be true for fields like phone number and false for
	 * fields like Limit
	 */
	this.supportsmask = false;

	/**
	 * The <code>formatSettings</code> are the setting used by the format mask
	 */
	this.formatSettings = null;

	/**
	 * The <code>formatMask</code> is the format mask for this field
	 */
	this.formatMask = null;

	/**
	 * The <code>fieldSecurityHandler</code> is the field security handler for
	 * this field (if any). This object handles secure data entry for fields
	 * designated as such in the TDF.
	 */
	this.fieldSecurityHandler = null;

	/**
	 * The <code>uncheckedValue</code> is the unchecked value for this field
	 * if it is a checkbox.
	 */
	this.uncheckedValue = null;

	/**
	 * The <code>uncheckedDisplayValue</code> is the unchecked display value
	 * used for read-only and upload widgets.
	 */
	this.uncheckedDisplayValue = null;

	/**
	 * The <code>checkedDisplayValue</code> is the checked display value for
	 * this field if it is a checkbox.
	 */
	this.checkedDisplayValue = null;

	/**
	 * The <code>lastCheckedValue</code> is the value when the item was last
	 * auto saved or checked by WorkItem Assistant.
	 */
	this.lastCheckedValue = null;

	/*
	 * The <code>snippetId</code> is the id attribute refering to the snippte
	 */
	this.snippetId = null;

	/*
	 * The <code>snippetData</code> is the json object representing the
	 * snippet data
	 */
	this.snippetData;

	this.snippetFileName;

	this.snippetPageNumber;

	this.snippetConfidence = null;

	this.supportsOverride = false;

	/**
	 * The <code>canReadSecureData</code> field indicates if the page is read only.
	 */
	this.canReadSecureData = false;


	/**
	 * Initializes the field with the format mask information. The
	 * fieldFormatMask object is created by the Field.paint() function.
	 * 
	 * @param supportsmask
	 *            boolean to denote whether this field supports format
	 *            mask/input mask.
	 * @param formatSettings
	 *            is a JSON obhect with setting information.
	 * @param formatMask
	 *            is the format mask literal.
	 */
	this.initFormatmask = function(supportsmask, formatSettings, formatMask) {
		if (page.supportsMaskForField(this, supportsmask, formatSettings,
				formatMask)) {
			this.hasFormatMask = true;
			this.supportsmask = supportsmask;
			this.formatSettings = formatSettings;
			this.formatMask = formatMask;
		}
	};
	
	/**
	 * Sets the <code>canReadSecureData</code> field of this instance.
	 * 
	 * @param readOnly
	 *            indicates if this user has canReadSecureData permission or not.
	 */
	this.setCanReadSecureData = function(canReadSecureData) {
		this.canReadSecureData = canReadSecureData;
	};

	/**
	 * Resets data members associated with format mask.
	 */
	this.resetFormatmask = function() {
		this.hasFormatMask = false;
		this.supportsmask = false;
		this.formatSettings = null;
		this.formatMask = null;
		this.fieldFormatMask = null;
	};
	/**
	 * Initializes the format mask object and bind the event to the fields
	 */
	this.applyFormatmask = function() {
		if (!$("#" + this.elements[0].id).length) {
			this.resetFormatmask();
			return;
		}

		if (this.fieldFormatMask) {
			if (this.fieldFormatMask.options.supportsMask === this.supportsmask
					&& this.fieldFormatMask.options.mask === this.formatMask) {
				return;
			} else {
				this.fieldFormatMask.unbind();
				this.fieldFormatMask = null;
			}
		}

		if (this.supportsmask) {
			this.fieldFormatMask = new ap.FieldMask({
				elementId : this.elements[0].id,
				supportsMask : this.supportsmask,
				mask : this.formatMask,
				settings : this.formatSettings
			});
		} else {
			this.fieldFormatMask = new ap.NumericFieldFormat({
				elementId : this.elements[0].id,
				supportsMask : this.supportsmask,
				mask : this.formatMask,
				settings : this.formatSettings
			});
		}
	};

	this.initFieldSecurity = function(secDateEntryMode, numRevealChars,
			initialValue) {
		this.fieldSecurityHandler = new ap.FieldSecurityHandler(
				secDateEntryMode, numRevealChars, initialValue, this);
	};

	/**
	 * Sets value of the field when it was last auto saved or last checked by
	 * WorkItem Assistant.
	 * 
	 * @param value
	 *            is the value of the field when it was auto saved or checked by
	 *            WorkItem Assistant.
	 */
	this.setLastCheckedValue = function(value) {
		this.lastCheckedValue = value;
	};

	/**
	 * Gets the last value for the field that is auto saved or checked by
	 * WorkItem Assistant.
	 * 
	 * @return the value of the field when it was last auto saved or checked by
	 *         WorkItem Assistant.
	 */
	this.getLastCheckedValue = function() {
		return this.lastCheckedValue;
	};

	/**
	 * Sets the maximum length of the field. Used during IPDTR to reset the
	 * maximum length on the field.
	 * 
	 * @param maxLength
	 *            maximum length of field as integer
	 */
	this.setMaxLength = function(maxLength) {
		this.elements[0].maxLength = Number(maxLength);
	};

	/**
	 * Tests whether the current field is a filter list element
	 * 
	 * @return a boolean value to signify whether or not the current field is a
	 *         filter list
	 * @type Boolean
	 */
	this.isFilterListType = function() {
		return this.fieldElementType == "filterlist";
	};

	/**
	 * Tests whether the current field is a select list element
	 * 
	 * @return a boolean value to signify whether or not the current field is a
	 *         select list or a filter list
	 * @type Boolean
	 */
	this.isListType = function() {
		return this.type == "select-one";
	};

	/**
	 * Tests whether the current field is a select list or filter list element
	 * 
	 * @return a boolean value to signify whether or not the current field is a
	 *         select list or a filter list
	 * @type Boolean
	 */
	this.isList = function() {
		return (this.isFilterListType() || this.isListType());
	};

	/**
	 * Tests whether this field is a message type field.
	 * 
	 * @return a boolean value to signify whether or not the current field is a
	 *         message field element or not
	 * @type Boolean
	 */
	this.isMessageType = function() {
		return this.fieldElementType == "message";
	};

	/**
	 * Tests whether this field is hidden or not.
	 * 
	 * @return a boolean value to signify whether or not the current field is
	 *         hidden
	 * @type Boolean
	 */
	this.isHiddenField = function() {
		return this.fieldElementType == "hidden";
	};

	/**
	 * Tests whether the current field is a radio button group
	 * 
	 * @return a boolean value to signify whether or not the current field is a
	 *         radio button or not
	 * @type Boolean
	 */
	this.isRadio = function() {
		return this.type == "radio";
	};

	/**
	 * Tests whether the current field is a checkbox
	 * 
	 * @return a boolean value to signify whether or not the current field is a
	 *         box input type
	 * @type Boolean
	 */
	this.isCheckbox = function() {
		return this.type == "checkbox";
	};

	this.isDateField = function() {
		return this.fieldElementType == "date";
	};

	this.isTimeField = function() {
		return this.fieldElementType == "time";
	};

	/**
	 * Tests whether or not the field should receive focus.<b>
	 * 
	 * @return a boolean value to signify whether or not the current field can
	 *         receive focus
	 * @type Boolean
	 */
	this.isFocusable = function() {
		return !this.isMessageType() && !(this.fieldElementType == "hidden")
				&& !this.readOnly && !this.isExcluded();
	};

	// Add self to form field container, defer if field is being introduced by
	// an IPDTR call since that will be
	// done later when we invoke the Field.include() method.
	if (!this.newIPDTRContent)
		form.addField(this, false);

	/**
	 * Nulls out any references to any existing DOM objects.
	 */
	this.shutDown = function() {
		this.$formRowParent = null;
		this.$formRow = null;
		for (var ix = 0; ix < this.elements.length; ix++)
			this.elements[ix].label = null;
		this.elements = null;
		this.label = null;
		this.labelText = null;
		this.$requiredIndicator = null;
		this.$fieldHelperContainer = null;
		this.$selectListParent = null;
		this.$ghostField = null;
	};

	/**
	 * Removes the DOM node associated with this field from the document,
	 * removing it from view. Also removes the reference to this field from the
	 * Page.form.fields array. This is distinct from 'hiding' the field which
	 * retains the HTML element in the form and only changes its type to
	 * 'hidden'.
	 */
	this.exclude = function() {
		if (this.isFilterListType()) {
			this.getFilterList().destroy();
		}
		this.$formRow.remove();
		page.form.removeField(this);
	};

	/**
	 * Optionally re-inserts the DOM node associated with this field back into
	 * the document making it visible and re-inserts the reference to this field
	 * back into the Page.form.fields array. This is distinct from 'showing' the
	 * field.
	 * 
	 * @param updateDOM
	 *            is a boolean flag which instructs this routine whether or not
	 *            to update the DOM or only update the form array
	 */
	this.include = function(updateDOM) {
		var closestField = this.parentFieldset
				.getNextClosestIncludedField(this.relativePosition);
		if (closestField != null) {
			if (updateDOM) {
				this.$formRow.insertBefore(closestField.$formRow);
			}
			page.form.insertField(this, closestField);
		} else {
			if (updateDOM) {
				this.$formRowParent.append(this.$formRow);
			}
			page.form.addField(this, true);
		}

		ap.Effects.highlight(this.$formRow);
	};

	/**
	 * Applies the inclusion/exclusion state for the field and does additional
	 * housekeeping if this is a filter list.
	 * 
	 * @param parentFieldSetIsDirty
	 *            indicates whether or not the field set which this field lives
	 *            in was dirtied.
	 * @param initialPaint
	 *            indicates whether this paint event is the initial paint
	 *            invocation which occurs during page.initialize() - as opposed
	 *            to subsequent page events which occur as a result of IPDTR
	 *            evaluations
	 */
	this.paint = function(parentFieldSetIsDirty, initialPaint) {

		ap.consoleInfo("painting........................ " + this.uniqueId);
		if (this.interestLevel.isDirty()) {
			if (this.interestLevel.isExcluded()) {
				ap.consoleInfo("Excluding " + this.uniqueId);
				this.exclude();
			} else if (!this.newIPDTRContent) {
				ap.consoleInfo("Including " + this.uniqueId);
				this.include(true);
			}
			ap.consoleInfo("Interest level for " + this.uniqueId
					+ " is changed to "
					+ this.interestLevel.getInterestLevelValue());
		} else if (this.parentFieldset.isExcluded()) {
			page.form.removeField(this);
		} else if (parentFieldSetIsDirty) {
			this.include(false);
		}
		this.interestLevel.clearDirtyFlag();
		// If this is a filter list and is to show we resynch the filter list
		// copy of the options with the new list contents
		if (!this.interestLevel.isExcluded()
				&& !this.parentFieldset.isExcluded()) {
			if (this.isFilterListType()) {
				var filterList = this.getFilterList();
				if (filterList != null) {
					filterList.init(parentFieldSetIsDirty);
					if (this.listRefreshed) {
						filterList.resetFilterListData(this.filterListContent,
								true);
					}
				}
			}

			if (this.listRefreshed && this.getIsHot()) {
				this.makeIntraPageDTRRequest(false);
				ap.consoleInfo("List " + this.uniqueId
						+ " refreshed and This is hot, making IPTDR.... ");
			}
			this.listRefreshed = false;
		}

		// apply the formatMask to the field.
		if (this.hasFormatMask === true) {
			if (!this.interestLevel.isExcluded()
					&& !this.parentFieldset.isExcluded()) {
				this.applyFormatmask();
			} else {
				this.resetFormatmask();
			}
		}

		if (this.fieldSecurityHandler && !this.interestLevel.isExcluded()) {
			this.fieldSecurityHandler.paint();
		}
		// The first time around, we setup the auto-save initial value tracker
		if (initialPaint) {
			this.initalValue = this.getValue();
			this.setAnalyticsFieldData('analyticsFieldValue', this.initalValue);
		}

		if (this.isDateField() && !this.interestLevel.isExcluded()
				&& !this.parentFieldset.isExcluded()) {
			$(this.elements[0].parentElement)
					.datepicker(
							{
								format : ap.format_info["default_display.datepicker.date_format"],
								forceParse : false,
								autoclose : true,
								showOnFocus : false,
								language : ap_locale,
								todayHighlight : true
							})
					.on('show', function(e) {
						if (e.date) {
							$(this).data('stickyDate', e.date);
						} else {
							$(this).data('stickyDate', null);
						}
					})
					.on('hide', function(e) {
						var stickyDate = $(this).data('stickyDate');
						if (!e.date && stickyDate) {
							$(this).datepicker('setDate', stickyDate);
							$(this).data('stickyDate', null);
						}
					})
					.on(
							'changeDate',
							function(e) {
								// when the date-picker changes we can get two
								// dateChange events with the same date... what
								// a pain!
								if (e.date
										&& e.date !== $(this)
												.data('stickyDate')) {
									$(this).data('stickyDate', e.date);
									// changeDate fires for date-picker clicks
									// and for character entry keystrokes and we
									// do not want to
									// validate for keystrokes so we can ignore
									// that scenario by ensuring the text input
									// is not focused
									if (document.activeElement !== me.elements[0]) {
										me.validate();
										if (me.fieldSecurityHandler) {
											me.fieldSecurityHandler
													.dateChangeCallback();
										}
									}
								}
							});
			$(this.elements[0]).keydown(function(e) {
				if (e.keyCode === 40) {
					$(me.elements[0].parentElement).datepicker("show");
					return false;
				}
			});
		}

		if (this.isTimeField() && !this.interestLevel.isExcluded()
				&& !this.parentFieldset.isExcluded()) {
			var timeDisplayFormat = ap.format_info["default_display.time_format"];
			var showperiod = false;
			if (timeDisplayFormat != null && timeDisplayFormat.indexOf('a') > 0) {
				showperiod = true;
			}
			var periodText = [ ap.core_prompts["timepicker.am"],
					ap.core_prompts["timepicker.pm"] ];
			$('#' + this.getUniqueId()).timepicker({
				showPeriod : showperiod,
				hourText : ap.core_prompts["timepicker.hour"],
				minuteText : ap.core_prompts["timepicker.minute"],
				amPmText : periodText,
				language : ap_locale,
				showOn : 'button',
				button : '.' + this.getUniqueId() + '_picker_trigger'
			});
		}

		var focusHandler = function(snippetField) {
			return function(event) {
				var handler = page.snippetHandlers[snippetField.snippetFileName
						+ "_" + snippetField.snippetPageNumber]
				if (handler) {
					handler.showSnippet(snippetField.snippetId)
				}
			}
		}(this);

		if (this.snippetId != null && this.snippetId.length > 0) {
			if (this.isFilterListType()) {
				var filterList = this.getFilterList();
				filterList.setupFocusEvent(this, focusHandler);
			} else if (this.fieldElementType == "question" || this.fieldElementType == "radio") {
				ap.registerEvent(this.elements[0], 'focus', focusHandler);
				ap.registerEvent(this.elements[1], 'focus', focusHandler);
				
				// Assign handler to click event too since focus only works if
				// changing value
				ap.registerEvent(this.elements[0], 'click', focusHandler);
				ap.registerEvent(this.elements[1], 'click', focusHandler);
			} else {
				ap.registerEvent(this.elements[0], 'focus', focusHandler);
			}

			this.setLowConfidenceIndicator();
		}
		// Turn off the fact that this field was newly introduced during IPDTR.
		this.newIPDTRContent = false;
	};

	/**
	 * If the current field is a filter list then this will return a reference
	 * to the FilterList instance associated with this field. This is the
	 * preferred mechanism for attaining access to the filter list.
	 * 
	 * @return a reference to the FilterList instance on Field instances that
	 *         contain a filter list otherwise null is returned.
	 * @type FilterList
	 */
	this.getFilterList = function() {
		if (!this.isFilterListType()) {
			return null;
		}
		var filterListObj = ap.getFilterList(this.uniqueId);
		if (filterListObj == null) {
			filterListObj = new ap.FilterList(this.uniqueId, "", []);
		}
		return filterListObj;
	};

	/**
	 * Registers this field to signal an IntraPage DTR event in the event the
	 * field changes.
	 */
	this.setupHotField = function() {
		if (this.isHot) {
			ap.consoleInfo(this.name + " is sizzling hot.");
			// Check to see if we should defer the automatic invocation of the
			// AJAX Intrapage DTR
			// server side method
			if (!this.autoInvokeAJAX) {
				ap
						.consoleInfo("Hot field with id of: '"
								+ uniqueId
								+ "' is hot but auto invocation of the SDK AJAX method is off. Assuming application custom code manages intrapage DTR experience on this field.");
				return;
			}

			var me = this;
			var eventType = "change";
			var keyDownEvent = "keydown";
			var element = me.elements[0];

			if (this.isRadio() || this.isCheckbox()) {
				eventType = "click";
				for (var ix = 0; ix < me.elements.length; ix++) {
					element = me.elements[ix];
					if (element) {
						ap.consoleInfo("creating hot field trigger event for "
								+ this.name);
						if (!this.readOnly) {
							ap.registerEvent(element, eventType,
									onHotFieldChanged);
							ap.registerEvent(element, keyDownEvent,
									onHotFieldKeyDown);
						} else {
							$(element).off(eventType, onHotFieldChanged);
							$(element).off(keyDownEvent, onHotFieldKeyDown);
						}
					}
				}
			} else {
				if (this.isFilterListType()) {
					// If this field is a filter list then we need to make the
					// filter list input field 'hot'
					var relatedFilterList = this.getFilterList();
					if (relatedFilterList != null)
						relatedFilterList.setupHotField(this);
				} else if (element) {
					ap.consoleInfo("creating hot field trigger event for "
							+ this.name);
					if (!this.readOnly) {
						ap.registerEvent(element, eventType, onHotFieldChanged);
						ap.registerEvent(element, keyDownEvent,
								onHotFieldKeyDown);
					} else {
						$(element).off(eventType, onHotFieldChanged);
						$(element).off(keyDownEvent, onHotFieldKeyDown);
					}
				}
			}
		}
	};
	
	this.setupOverrideField = function() {
		if (this.supportsOverride) {
			ap.consoleInfo(this.name + " supports override.");
			var me = this;
			var element = me.elements[0];
			override.showHideOverrideMessage(me.uniqueId);
			ap.registerEvent(element, "blur", onOverrideFieldChanged);		
		}
	}

	/**
	 * Event callback invoked when the user changes a hot field. This is the
	 * origin point of the AJAX DTR request.
	 */
	function onHotFieldChanged() {
		if (me.getIsHot()) {
			me.makeIntraPageDTRRequest(false);
		}
	}

	/**
	 * Event callback invoked when the user changes an override field.
	 */	
	function onOverrideFieldChanged(event) {
		ap.consoleInfo("Override field " + this.name + " changed.");
		override.showHideOverrideMessage($(event.currentTarget).attr('id'));
	}

	/**
	 * Method for making a request to the AJAX Intrapage DTR back end.
	 * 
	 * @param messageRetainingHint
	 *            if true, send a hint to retain existing messages
	 * @return true if the DTR request was made or false if there is already an
	 *         intrapage DTR method currently in flight.
	 * @type Boolean
	 */
	this.makeIntraPageDTRRequest = function(messageRetainingHints) {

		// don't make request if the field validation fails
		// this is useful when invalid data is passed to behaviors that could
		// cause runtime exception to be thrown.
		if (!me.isListType() && !me.validate(false, false)) {
			return false;
		} 
		var intraPageDTRRequest = ap.createDTRRequest(transaction, page, this,
				messageRetainingHints);
		if (intraPageDTRRequest == null) {
			return false;
		}
		if (page.originHotField == null) {
			page.originHotField = this;
		}
		ap.consoleInfo("Executing makeIntraPageDTRRequest for " + me.name);
		intraPageDTRRequest.send();
		return true;
	};

	/**
	 * Event on keydown for each hotfield. This will be used to track when the
	 * user clicks tab or shift tab so we can put the focus on the correct
	 * field.
	 */
	function onHotFieldKeyDown(event) {
		var theKey = event.which || event.keyCode;

		// we need to catch the tab key 9, shift tab 9 plus shiftkey properties
		// on event
		// we also need to catch any key that gets pressed to pick a select list
		// entry
		// if we don't catch these events we could get the cursor going to the
		// window
		if (event.shiftKey && theKey == 9 && !me.isRadio()) {
			ap.consoleInfo("Shift key held down and tab key down event fired "
					+ me.uniqueId);
			me.hotfieldLastKey = 'shifttab';
		} else if (!event.shiftKey && theKey == 9 && !me.isRadio()) {
			ap.consoleInfo("Tab key down event fired " + me.uniqueId);
			me.hotfieldLastKey = 'tab';
		} else if ((me.isListType() || me.isRadio())
				&& ((theKey >= 37 && theKey <= 40)
						|| (theKey >= 48 && theKey <= 91) || (theKey >= 96 && theKey <= 105))) {
			// we should only be here if this is a select list
			ap.consoleInfo("Alphanumeric key or arrow key down event fired "
					+ me.uniqueId);
			me.hotfieldLastKey = 'arrow';
		}
	}

	/**
	 * This flag will engage the default list refresh logic which optimizes to
	 * large list refresh under IE.
	 */
	if (ap.constants.Field === undefined) {
		ap.constants.Field = {};
		ap.constants.Field.supportLargeLists = true;
	}

	/**
	 * Marks the begin of the select list update from IPDTR.
	 */
	this.beginIntraPageDTRListUpdate = function() {

		if (this.isFilterListType()) {
			var filterList = this.getFilterList();
			this.filterListContent = new Array();
			filterList.emptyList();
		}
		this.listRefreshed = true;
		ap.consoleInfo("beginIntraPageDTRListUpdate....listRefreshed="
				+ this.listRefreshed + "..." + this.uniqueId);
		if (!this.isListType()) {
			return;
		}
		this.listEntrySelected = false;
		if (ap.constants.Field.supportLargeLists) {
			this.optionListContent = null;
		}

		var selectListElement = this.elements[0];
		// Setting the length to zero zaps all of the list entries
		selectListElement.length = 0;
		selectListElement = null;
	};

	/**
	 * Appends a list entry option to a list type field.
	 * 
	 * @param displayLabel
	 *            is the text label for user view
	 * @param dataValue
	 *            is the data value to associated with the entry
	 * @param isSelected
	 *            is a boolean value where true selects this entry into view.
	 *            (Multi-select is not supported).
	 */
	this.addListOption = function(displayLabel, dataValue, isSelected) {

		if (this.isFilterListType()) {
			var filterList = this.getFilterList();
			var optionEntry = filterList.addOption(displayLabel, dataValue,
					isSelected);
			if (this.filterListContent != null) {
				this.filterListContent.push(optionEntry);
			}
			return;
		}

		if (!this.isListType())
			return;
		if (ap.constants.Field.supportLargeLists) {
			if (this.optionListContent == null)
				this.optionListContent = new ap.StringBuffer();
			this.optionListContent.append("<option");
			this.optionListContent.append(" value=\"");
			this.optionListContent.append(dataValue);
			this.optionListContent.append("\"");
			if (isSelected) {
				this.listEntrySelected = true;
				this.optionListContent.append(" selected=\"selected\"");
			}
			this.optionListContent.append(">");
			this.optionListContent.append(displayLabel);
			this.optionListContent.append("</option>");
		} else {
			if (isSelected)
				this.listEntrySelected = true;
			var selectListElement = this.elements[0];
			var option = new Option(displayLabel, dataValue, isSelected);
			selectListElement.options[selectListElement.options.length] = option;
			// below is for IE 6
			selectListElement.options[length].selected = isSelected;
			option = null;
			selectListElement = null;
		}
	};

	/**
	 * Writes the current option list contents to the select list html elements
	 * inner html. This is optimized to handle very large lists.
	 * 
	 * @param resetFocus
	 *            controls whether or not focus should be programmtically reset
	 *            if the current Field has input focus.
	 */
	this.commitListOptions = function(resetFocus) {
		// Tell the filter list that we have a new HTML select list DOM element
		// now
		if (this.isFilterListType()) {
			var filterList = this.getFilterList();
			if (filterList != null) {
				filterList.resetFilterListData(this.filterListContent, true);
			}
		}

		if (!this.isListType())
			return;

		if (!ap.constants.Field.supportLargeLists) {
			// if the field has caused a change in the value, update the ghost
			// field accordingly.
			if (this.$ghostField)
				this.updateGhostFieldValue();
			return;
		}

		if (this.optionListContent == null) {
			this.elements[0].length = 0;
			return;
		}

		$(this.elements[0]).append($(this.optionListContent.toString()));

		// release reference to temporary option list content string buffer
		this.optionListContent = null;

		// if the field has caused a change in the value, update the ghost field
		// accordingly.
		if (this.$ghostField)
			this.updateGhostFieldValue();
	};

	/**
	 * The <code>fieldHelperContainer</code> field holds onto the field
	 * helpers. A DOM SPAN element around the fields helpers.
	 */
	this.$fieldHelperContainer = null;

	this.getFieldHelperContainter = function(forceCreateIfNull) {
		if (this.$fieldHelperContainer != null)
			return this.$fieldHelperContainer;
		else if (forceCreateIfNull) {
			var container = $("#" + this.name + "_fieldHelpers");
			if (!container.length) {
				container = document.createElement('span');
				container.id = this.name + "_fieldHelpers";
			}
			this.$fieldHelperContainer = $(container);
		}
		return this.$fieldHelperContainer;
	};

	/**
	 * Counts number of field helpers for field
	 * 
	 * @return number of field helpers attached to field
	 */
	this.getFieldHelperCount = function() {
		return this.$fieldHelperContainer.children().length;
	};

	/**
	 * The <code>readOnly</code> field is a flag indicating whether or not
	 * this field is read only.
	 */
	this.readOnly = false;
	function setFieldHelperContainer() {
		me.$fieldHelperContainer = $("#" + me.name + "_fieldHelpers");
	}
	/**
	 * Returns the default value for this field. This is related to the
	 * defaultValue attribute on the related fieldElement in the TDF.
	 * 
	 * @return the default value for this field.
	 * @type String
	 */
	this.getDefaultValue = function() {
		return this.defaultValue;
	};

	/**
	 * Sets the <code>defaultValue</code> field.
	 * 
	 * @param defaultValue
	 *            is the default value.
	 */
	this.setDefaultValue = function(defaultValue) {
		this.defaultValue = defaultValue;
	};

	/**
	 * Sets the <code>uncheckedValue</code> for this checkbox field. Will be
	 * used for IPDTR calls when a checkbox is unchecked.
	 * 
	 * @param uncheckedValue
	 *            is the unchecked value for this field
	 */
	this.setUncheckedValue = function(uncheckedValue) {
		this.uncheckedValue = uncheckedValue;
	};

	/**
	 * Sets the <code>uncheckedDisplayValue</code> for this checkbox field.
	 * Will
	 * 
	 * @param uncheckedDisplayValue
	 *            is the unchecked display value for this field.
	 */
	this.setUncheckedDisplayValue = function(uncheckedDisplayValue) {
		this.uncheckedDisplayValue = uncheckedDisplayValue;
	};

	/**
	 * Sets the <code>checkedDisplayValue</code> for this checkbox field.
	 * 
	 * @param checkedDisplayValue
	 *            is the display value for this checkbox when the field is
	 *            read-only or used in the upload widget.
	 */
	this.setCheckedDisplayValue = function(checkedDisplayValue) {
		this.checkedDisplayValue = checkedDisplayValue;
	};

	/**
	 * Returns whether or not this field is hot.
	 * 
	 * @return true if this field instance is hot.
	 * @type Boolean
	 */
	this.getIsHot = function() {
		return this.isHot;
	};

	/**
	 * Returns the <code>autoInvokeAJAX</code> field
	 * 
	 * @return true if this field instance is hot.
	 * @type Boolean
	 */
	this.getAutoInvoke = function() {
		return this.autoInvokeAJAX;
	};

	/**
	 * Sets the <code>interestLevel</code> field.
	 * 
	 * @param interestLevel
	 *            is the interest level interest instance (not the numeric
	 *            value).
	 */
	this.setInterestLevel = function(interestLevel) {
		this.interestLevel = interestLevel;
	};

	/**
	 * Returns interest level instance associated with this field.
	 * 
	 * @return interest level associated with this field.
	 * @type InterestLevel
	 * @see #getNormalizedInterestLevelValue
	 */
	this.getInterestLevel = function() {
		return this.interestLevel;
	};

	/**
	 * Returns the normalized interest level value for this field. This is
	 * typically the same as what the interest level object contains except in
	 * situations when the parent field set is excluded. In the latter case, if
	 * the parent field set in which this is contained is excluded, the
	 * normalized interest level for this field will be excluded as well.
	 * 
	 * @return the normalized interest level value associated with this field.
	 * @type Number
	 */
	this.getNormalizedInterestLevelValue = function() {
		if (this.parentFieldset.isExcluded())
			return ap.constants.InterestLevel.INTEREST_LEVEL_EXCLUDE;
		else
			return this.interestLevel.getInterestLevelValue();
	};

	/**
	 * Returns whether or not this field is excluded
	 * 
	 * @return true if either the interest level on this field is exclude <b>or
	 *         if the field set in which it is contained is exclude
	 * @type Boolean
	 */
	this.isExcluded = function() {
		return this.getNormalizedInterestLevelValue() == ap.constants.InterestLevel.INTEREST_LEVEL_EXCLUDE;
	};

	/**
	 * Returns unique id for this field.
	 * 
	 * @return unique id for this field.
	 * @type String
	 */
	this.getUniqueId = function() {
		return this.uniqueId;
	};

	/**
	 * Returns unique id for this field.
	 * 
	 * @return unique id for this field.
	 * @type String
	 */
	this.getTdfId = function() {
		return this.tdfId;
	};

	/**
	 * Sets the <code>uniqueId</code> field.
	 * 
	 * @param uniqueId
	 *            is the field's unique identifier
	 */
	this.setUniqueId = function(uniqueId) {
		this.uniqueId = uniqueId;
	};

	function removeChild(parentNode, child) {
		if (child == null)
			return;
		parentNode.removeChild(child);
	}

	/**
	 * Sets the <code>readOnly</code> field. Used to make fields read only
	 * dynamically. Sets property readOnly property on the Field object and
	 * deals with user experience related to read only status change. Most field
	 * types are fully supported, the 'message' field type is the only one that
	 * is not. When fields are made read only, a 'ghostField' is created as a
	 * visible substitute of the original field for the user. The actual
	 * elements of the field are hidden from view. In addition to ghostField
	 * management, When a field is made read only, it's field helpers and
	 * required indicator are concealed if they exist.
	 * 
	 * @param readOnly
	 *            is the read only flag.
	 * @see #createGhostField
	 * @see #updateGhostFieldValue
	 * @see #revealGhostField
	 * @see #concealGhostField
	 * @see #concealFieldHelpers
	 * @see #revealFieldHelpers
	 * @see #concealRequiredIndicator
	 * @see #revealRequiredIndicator
	 * @see #concealElements
	 * @see #revealElements
	 */
	this.setReadOnly = function(readOnly) {
		// support is available for all but "message" elements, which are read
		// only anyway
		if (this.fieldElementType == "message")
			return false;

		if (this.isFilterListType()) {
			this.getFilterList().setReadOnly(readOnly);
		}

		if (readOnly) {
			this.createGhostField();
			this.concealFieldHelpers();
			this.concealRequiredIndicator();
			this.concealElements();
			if(this.fieldSecurityHandler
					&& !this.fieldSecurityHandler.concealedValueExperience ){
				if (this.fieldSecurityHandler.$hiddenRawValueInput.val() !== "") {
						this.fieldSecurityHandler.$textInput.val(this.fieldSecurityHandler.$hiddenRawValueInput.val());
						if(!this.fieldSecurityHandler.isFocus){
							this.fieldSecurityHandler.suppressFormatMask();
							this.fieldSecurityHandler.maskValue();
						}
					}
				}
			this.updateGhostFieldValue();
			this.revealGhostField();
		} else {
			this.concealGhostField();
			this.revealElements();
			this.revealRequiredIndicator();
			this.revealFieldHelpers();
		}
		this.readOnly = readOnly;
	};
	/**
	 * Creates a <code>ghostField</code> if one does not already exist for
	 * this Field object. The ghostField is used as a surrogate visual element
	 * in place of the actual input elements belonging to a field, for example
	 * in the case that it is read only. Use of a ghost field allows for
	 * consistent user experience across fieldElement types supported by the
	 * AgencyPortal Framework. Select Lists, Radio Buttons, Question Elements,
	 * Text Inputs and Textareas all have a consistent user experience in the
	 * case that they are read only thanks to the ghost field. For all all
	 * controls, the DOM node type of the ghost field is a SPAN.
	 */
	this.createGhostField = function() {
		// do not create a ghost field if one exists or if this is a message
		if (this.$ghostField || this.fieldElementType == "message") {
			return false;
		}
		// in most cases the ghost field is an HTML input element. The exception
		// is in the case of a text area which may contain a larger amount of
		// content including new line characters. In this case a paragraph
		// element is created to hold this content.
		var ghostField = document.createElement("span");
		ghostField.className = "read-only";
		// assign the newly created dom element to the ghost field property of
		// the field object
		this.$ghostField = $(ghostField);

		var ghostFieldText = document.createElement("span");
		ghostFieldText.className = "read-only-text";

		this.$ghostField.append(ghostFieldText);

		// if this is a secure field, we add a create "view-raw-value" control
		// to the ghostField
		if (this.fieldSecurityHandler
				&& !this.fieldSecurityHandler.concealedValueExperience && this.canReadSecureData) {
			var $viewControl = $(document.createElement('a'));
			$viewControl.attr("href", "javascript:void(0);");
			$viewControl.addClass("view-raw-value");
			$viewControl.text("Show");

			$viewControl.click(function() {

				$(ghostFieldText).text(me.fieldSecurityHandler.getValue());

				$viewControl.hide();
			});
			$viewControl.hide();

			this.$ghostField.append($viewControl);
		}

		// update the ghost field value to the current display value of the
		// field
		this.updateGhostFieldValue();
		// the ghost field concealed when first created,
		this.concealGhostField();
		// insert ghost field into the DOM, insertion point varies by field
		// element type
		switch (this.fieldElementType) {
		case "radio":
			$(this.options.parentNode).before(this.$ghostField);
			break;
		case "question":
			for (var i = 0; i < this.elements.length; i++) {
				var $td = $(this.elements[i]).parents('td');
				if (this.getValue() == this.elements[i].value)
					$td.append(this.$ghostField);
			}
			break;
		case "hidden":
			// ghost field not inserted into the DOM when the field element type
			// is hidden
			break;
		default:
			$(this.elements[0].parentNode).before(this.$ghostField);
		}
	};
	/**
	 * Updates the value of the surrogate <code>ghostField</code> with the
	 * value returned by the Field Object's getDisplayValue method.
	 * 
	 * @param value
	 *            is an optional parameter that will explicitly set the value of
	 *            the ghost field rather than using the return of
	 *            getDisplayValue. In the case that this value is passed, the
	 *            ACTUAL value of the elements associated with this field are
	 *            not updated.
	 */
	this.updateGhostFieldValue = function() {
		try {
			var value = "";
			// if a value was passed this method, it will be assigned to the
			// ghost field
			if (arguments[0]) {
				value = arguments[0];
				// if a value was not passed to this method, the current display
				// value will be assigned to the ghost field
			} else {
				value = this.getDisplayValue();
			}

			if (value === undefined)
				value = "";

			// value assignment logic:
			if (this.fieldElementType == "question")
				value = "X";

			var $textContainer = this.$ghostField.children(".read-only-text");

			$textContainer.text(value);

			// if this is a secure field, we add a create "view-raw-value"
			// control to the ghostField
			if (this.fieldSecurityHandler) {
				if (this.fieldSecurityHandler.getValue() !== '') {
					var $viewControl = this.$ghostField
							.children(".view-raw-value");
					$viewControl.show();
				}
			}
		}
		// if the assignment fails...
		catch (e) {
			ap.consoleWarn("Exception raised updating the ghost field for "
					+ this.uniqueId);
		}
	};
	/**
	 * If a <code>ghostField</code> exists for this Field object which needs
	 * to be removed, removeGhostField will remove the ghostField from the DOM
	 * and break it's reference to the field object.
	 */
	this.removeGhostField = function() {
		try {
			this.$ghostField.parent().remove(this.$ghostField);
			this.$ghostField = null;
		} catch (e) {
			ap.consoleWarn("Exception raised removing ghost field for "
					+ this.uniqueId);
		}
	};
	/**
	 * Reveals the <code>ghostField</code> if one exists for this Field.
	 * revealGhostField does not create a ghostField if one does not already
	 * exist.
	 */
	this.revealGhostField = function() {
		try {
			this.$ghostField.css("display", "");
		} catch (e) {
		}
	};
	/**
	 * Conceals the <code>ghostField</code> if one exists for this Field.
	 * concealGhostField does not create a ghostField if one does not already
	 * exist.
	 */
	this.concealGhostField = function() {
		try {
			this.$ghostField.css("display", "none");
		} catch (e) {
		}
	};
	/**
	 * Reveals the DOM <code>elements</code> associated with this field
	 * object.
	 */
	this.revealElements = function() {
		switch (this.fieldElementType) {
		case "radio":
			this.options.style.display = "";
			break;
		case "filterlist":
			this.getFilterList().show(this);
			break;
		case "date":
			this.elements[0].style.display = "";
			$(this.elements[0]).siblings().show();
			break;
		case "question":
			for (var i = 0; i < this.elements.length; i++)
				this.elements[i].style.display = "";
			break;
		default:
			if (this.fieldSecurityHandler) {
				this.fieldSecurityHandler.show();
			}
			this.elements[0].style.display = "";
		}
	};
	/**
	 * Conceals the DOM <code>elements</code> associated with this field
	 */
	this.concealElements = function() {
		switch (this.fieldElementType) {
		case "radio":
			this.options.style.display = "none";
			break;
		case "filterlist":
			this.getFilterList().hide(this);
			break;
		case "date":
			this.elements[0].style.display = "none";
			$(this.elements[0]).siblings().hide();
			break;
		case "question":
			for (var i = 0; i < this.elements.length; i++)
				this.elements[i].style.display = "none";
			break;
		default:
			if (this.fieldSecurityHandler) {
				this.fieldSecurityHandler.hide();
			}
			this.elements[0].style.display = "none";
		}
	};
	/**
	 * Reveals the <code>fieldHelpers</code> associated with this field if
	 * they exist. Does not create fieldHelpers if they are not already present
	 * for this field.
	 */
	this.revealFieldHelpers = function() {
		try {
			if (this.$fieldHelperContainer.length)
				this.$fieldHelperContainer.css("display", "");
		} catch (e) {
		}
		;
	};
	/**
	 * Conceals the <code>fieldHelpers</code> associated with this field if
	 * they exist. Does not create fieldHelpers if they are not already present
	 * for this field.
	 */
	this.concealFieldHelpers = function() {
		try {
			if (this.$fieldHelperContainer.length)
				this.$fieldHelperContainer.css("display", "none");
		} catch (e) {
		}
		;
	};
	/**
	 * Reveals the <code>requiredIndicator</code> associated with this field
	 * if it exists. Does not create a requiredIndicator if one was not already
	 * present for this Field object
	 */
	this.revealRequiredIndicator = function() {
		try {
			if (this.$requiredIndicator.length)
				this.$requiredIndicator.css("display", "");
		} catch (e) {
		}
		;
	};
	/**
	 * Conceals the <code>requiredIndicator</code> associated with this field
	 * if it exists. Does not create a requiredIndicator if one was not already
	 * present for this Field object
	 */
	this.concealRequiredIndicator = function() {
		try {
			if (this.$requiredIndicator)
				this.$requiredIndicator.css("display", "none");
		} catch (e) {
		}
		;
	};
	/**
	 * Returns current value of the field.
	 * 
	 * @param displayValue
	 *            is the boolean to indicate whether to return the display
	 *            value.
	 * @return current value of the field.
	 * @type String
	 */
	this.getValue = function(displayValue) {
		displayValue = displayValue ? displayValue : false;
		var value = "";
		switch (this.type) {
		case "select-one":
			try {
				value = this.elements[0].options[this.elements[0].selectedIndex].value;
			} catch (e) {
			}
			break;
		case "radio":
			for (var i = 0; i < this.elements.length; i++) {
				if (this.elements[i].checked) {
					value = this.elements[i].value;
					break;
				}
			}
			break;
		case "checkbox":
			if (displayValue) {
				if (this.elements[0].checked) {
					value = this.checkedDisplayValue;
				} else {
					// this is for the initial display when the unchecked value
					// is not registered
					value = this.uncheckedDisplayValue ? this.uncheckedDisplayValue
							: "";
				}
			} else {
				if (this.elements[0].checked) {
					value = this.elements[0].value;
				} else {
					// this is for the initial display when the unchecked value
					// is not registered
					value = this.uncheckedValue ? this.uncheckedValue : "";
				}
			}
			break;
		default:
			if (this.isMessageType()) {
				value = this.elements[0].innerHTML;
			} else if (this.isFilterListType()) {
				var filterlist = this.getFilterList();
				value = filterlist.getValue();
			} else {
				if (this.fieldSecurityHandler) {

					value = this.fieldSecurityHandler.getValue(displayValue);
				} else {
					// If there is formatMask definition and if displayValue =
					// true, return displayValue
					value = this.fieldFormatMask && !displayValue ? this.fieldFormatMask
							.getValue()
							: this.elements[0].value;
				}
			}
		}
		// trim whitespace before returning:
		return value.replace(/^\s+|\s+$/g, "");
	};

	/*
	 * Returns whether or not this field is the origin hot field. @return true
	 * if this field instance it the origin hot field @type Boolean
	 */
	this.isOriginHotField = function() {
		return page.originHotField === this;
	};
	/**
	 * Sets the value of the control using the argument(s) passed to it. To set
	 * most controls, pass a single value as a parameter. To set a multi-select
	 * or checkbox control, more than one argument can be passed. If a field is
	 * read-only then this will also synchronize the ghost field value and size
	 * with the passed value.
	 * 
	 * @param value
	 *            is the value to set.
	 */
	this.setValue = function setValue(value) {

		switch (this.type) {
		case "select-one":
			for (var i = 0; i < this.elements[0].options.length; i++)
				if (this.elements[0].options[i].value.toLowerCase() == value
						.toLowerCase())
					this.elements[0].options[i].selected = true;
			break;
		case "radio":
			for (var i = 0; i < this.elements.length; i++)
				if (this.elements[i].value.toLowerCase() == value.toLowerCase()) {
					this.elements[i].defaultChecked = true;
					this.elements[i].checked = true;
				}
			break;
		case "checkbox":
			if (this.elements[0].value.toLowerCase() != value.toLowerCase()) {
				this.elements[0].checked = false;
			} else {
				this.elements[0].checked = true;
			}
			break;
		default:
			if (this.isMessageType()) {
				this.elements[0].innerHTML = value;
			} else if (this.isFilterListType())
				this.getFilterList().setValue(value);
			else {
				value = ap.htmlDecode(value);
				var newValue = this.fieldFormatMask ? this.fieldFormatMask.decorate(value) : value;
				this.elements[0].value = newValue;
				if (this.fieldFormatMask){
					// fix to deal with jQuery bug that leaves characters when clearing a field with a mask.
					this.fieldFormatMask.enable();
				} 
				//need to check if this field has field security
				if(this.fieldSecurityHandler && this.interestLevel != 'undefined' && !this.interestLevel.isExcluded()){  
					this.fieldSecurityHandler.reLoadTextInput();  
					//if the field is readonly and there's show link, only show the show link when value is not empty. 
					if (this.fieldSecurityHandler && this.$ghostField!= null && this.readOnly) {
						var $viewControl = this.$ghostField
								.children(".view-raw-value");
						if(this.fieldSecurityHandler.getValue() === '' ){
							$viewControl.hide();
						}
						else{
							$viewControl.show();
							if (this.fieldSecurityHandler.$hiddenRawValueInput.val() !== "") {
								this.fieldSecurityHandler.$textInput.val(this.fieldSecurityHandler.$hiddenRawValueInput.val());
								if(!this.fieldSecurityHandler.isFocus){
									this.fieldSecurityHandler.suppressFormatMask();
									this.fieldSecurityHandler.maskValue();
								}
							}
							this.concealGhostField();
						}
					}  
					
				}  
				if (this.isDateField()) {
					$(this.elements[0].parentElement).datepicker('update', newValue);
				}
					
			}
		}

		if (this.readOnly && this.$ghostField != null) {
			this.updateGhostFieldValue();
		}

		// Trigger an intrapage DTR call if this is a hot field
		if (this.isHot && this.autoInvokeAJAX && !this.isOriginHotField())
			this.makeIntraPageDTRRequest(true);

		if (typeof this.onSetValue == 'function')
			this.onSetValue();

		// Setvalue could be called before the intrapage DTR request
		// has finished and before a field is visible so we repress
		// showing the validation tip then.
		var showTip = true;
		if (ap.intrapageDTRRequestInProgress) {
			// If we are switching from excluded an included state we DON'T
			// want to show the tip.
			showTip = !this.isSwitchingFromExcludedToIncluded();
		}
		this.validate(showTip);
	};

	/**
	 * Returns if the field is currently changing from an excluded state to an
	 * included state.
	 * 
	 * @return if the field is currently changing from an excluded state to an
	 *         included state.
	 * @type Boolean
	 */
	this.isSwitchingFromExcludedToIncluded = function() {
		if (this.newIPDTRContent)
			return true;
		if (this.interestLevel.isExcluded()
				|| this.parentFieldset.getInterestLevel().isExcluded())
			return false;
		return this.interestLevel.isDirty()
				|| this.parentFieldset.getInterestLevel().isDirty();
	};

	/**
	 * Returns the user-facing value corresponding to the current value
	 * (Argument(s) acepted, will return displayValue for corresponding
	 * arguments)
	 * 
	 * @return Returns the user-facing value corresponding to the current value
	 *         (Argument(s) acepted, will return displayValue for corresponding
	 *         arguments)
	 * @type String
	 */
	this.getDisplayValue = function() {
		var codeValue;
		var displayValue = undefined;

		if (arguments.length == 0)
			codeValue = this.getValue(true);
		else
			codeValue = arguments[0];

		switch (this.type) {
		case "select-one":
			for (var i = 0; i < this.elements[0].options.length; i++) {
				if (this.elements[0].options[i].value.toLowerCase() == codeValue
						.toLowerCase()) {
					displayValue = this.elements[0].options[i].text;
				}
			}
			break;
		case "radio":
			for (var i = 0; i < this.elements.length; i++) {
				try {
					if (this.elements[i].value.toLowerCase() == codeValue
							.toLowerCase()) {
						displayValue = this.elements[i].label;
						break;
					}
				} catch (e) {
				}
			}
			break;
		case "checkbox":
			if (this.elements[0].value.toLowerCase() === codeValue
					.toLowerCase()
					&& this.elements[0].checked) {
				displayValue = this.checkedDisplayValue;
			} else if (this.elements[0].value.toLowerCase() != codeValue
					.toLowerCase()
					&& !this.elements[0].checked) {
				// this is for the initial display when the unchecked value is
				// not registered
				displayValue = this.uncheckedDisplayValue ? this.uncheckedDisplayValue
						: "";
			} else {
				displayValue = codeValue;
			}
			break;
		case "hidden":
			if (this.isFilterListType()) {
				displayValue = this.getFilterList().getDisplayValue();
			} else {
				displayValue = "";
			}

			break;
		default:
			displayValue = codeValue;
		}
		if (this.fieldElementType == "question") {
			for (var i = 0; i < this.elements.length; i++) {
				try {
					if (this.elements[i].value.toLowerCase() == codeValue
							.toLowerCase()) {
						displayValue = codeValue;
						break;
					}
				} catch (e) {
				}
			}
		}
		return displayValue;
	};

	/**
	 * Used to find the "formRow" (i.e. the parent container) for the field
	 * 
	 * @return the "formRow" (i.e. the parent container) for the field
	 */
	function getFormRow(element) {
		try {
			return $(element).parents('.form-group');
		} catch (e) {
			return false;
		}
	}
	;

	// used to determine the class of the fieldset within which this field
	// exists
	function getParentFieldsetClass(formRow) {
		try {
			return $(formRow).parents('fieldset').attr('class');
		} catch (e) {
			return false;
		}
	}

	/**
	 * Used to create a relationship between component elements and labels
	 * 
	 * @element is the element that needs a label
	 */
	this.labelElement = function(element) {
		var id = element.id;
		var labels = $('label');
		var fieldLabel = '';
		for (var i = 0; i < labels.length; i++) {
			if (labels[i].htmlFor == id)
				fieldLabel = labels[i];
		}
		if (fieldLabel == '') {
			// _YES or _NO gets appended to questionnaire element ID's - let's
			// strip this off and look again
			for (var i = 0; i < labels.length; i++) {
				if (labels[i].htmlFor == id.replace(/_YES/, '')
						|| labels[i].htmlFor == id.replace(/_NO/, ''))
					fieldLabel = labels[i];
			}
		}

		var displayValue = fieldLabel.textContent;
		if (displayValue === undefined)
			displayValue = fieldLabel.innerText;

		element.label = displayValue;
	};

	/**
	 * Returns an array of the fields member elements
	 * 
	 * @param formRow
	 *            is used for new IPDTR content only.
	 * @return an array of the fields member elements
	 * @type Array
	 */
	this.getElements = function(formRow) {
		var elements = new Array();
		var domElement = null;
		if (formRow != null) {
			if (this.fieldElementType == "question"
					|| this.fieldElementType == "radio") {
				elements = $(formRow).find("[name='" + this.name + "']")
						.addBack("#" + this.name);
			} else {
				elements = $(formRow).find("#" + this.name).addBack(
						"#" + this.name); // Adding the parent back in and
											// refiltering as find only looks
											// for childeren. This is
											// problematic when we have hidden
											// fields.
			}
			return elements;
		} else {
			domElement = form.elements[this.tdfId]; // Tdf Id represents the
													// name on the input field.
			if (domElement === undefined) { // form collections may not be ready
											// for query. check document
				if (this.fieldElementType == 'radio'
						|| this.fieldElementType == "question") {
					domElement = document.getElementsByName(this.tdfId);
				} else {
					var $domElement = $('#' + this.tdfId);
					if ($domElement.length) {
						domElement = $domElement[0];
					}
				}
			}
		}

		if (domElement === undefined) {
			// DOM content requested but field is now being excluded from view
			if (this.elements !== undefined)
				return this.elements;
			else
				return elements;

		}
		// fill up the elements array with the component elements of the field.
		// Tack their labels onto them as we do this.
		// getting an element from the named "elements" array will return either
		// a DOM node representing the element, or an array of DOM nodes
		// (checkbox, radio) that constitute the element
		if (domElement.nodeType == 1) {
			// a DOM Element came back from the form
			this.labelElement(domElement);
			elements.push(domElement);
		} else {
			// a DOM element collection DID NOT come back from the form ( we're
			// dealing with either a checkbox or a radio button.)
			for (var i = 0; i < domElement.length; i++) {
				this.labelElement(domElement[i]);
				elements.push(domElement[i]);
			}
		}
		return elements;
	};

	/**
	 * The <code>elements</code> field is an array containing the HTML
	 * elements that constitute the Field.
	 * 
	 * @type Array
	 */
	this.elements = null;
	if (this.isMessageType()) {
		this.elements = new Array();
		if (this.newIPDTRContent) {
			this.elements[0] = newFormRow;
			this.$formRow = $(newFormRow);
		} else {
			this.$formRow = $("#" + this.name);
			this.elements[0] = this.$formRow.get(0);
		}
	} else {
		this.elements = this.getElements(newFormRow); // an array of the
														// member elements that
														// make up the field
														// (Important - adds a
														// new "label" property
														// for each member
														// element to include a
														// reference to it's
														// corresponding
														// HTMLLabelElement)
		if (newFormRow != null)
			this.$formRow = $(newFormRow);
		else {
			var formRow = getFormRow(this.elements[0]); // the point of
														// attachment for
														// helpers
			if (!formRow.length) {
				this.$formRow = $(this.elements[0]);
			} else
				this.$formRow = formRow;
		}
	}

	/**
	 * The <code>formRowParent</code> field is DOM parent for the HTML DOM
	 * element directly relating to this field.
	 */
	this.$formRowParent = this.$formRow.parent();

	if (this.newIPDTRContent) {
		this.$formRowParent = this.parentFieldset.getDOMElement();
		var parentFieldSetIL = this.parentFieldset.getInterestLevel();
		if (parentFieldSetIL.isDirty() && !parentFieldSetIL.isExcluded()) {
			ap.consoleInfo("Dynamically including parent field set with id: "
					+ this.parentFieldset.getId());
			this.parentFieldset.include();
			parentFieldSetIL.clearDirtyFlag();
		}
		// Can't defer inclusion any longer, too many downstream algorithms
		// assume that the field
		// has been made part of the DOM document.
		ap.consoleInfo("Dynamically including new IPDTR field with id: "
				+ this.uniqueId);
		this.include(true);
		// Wire labels
		for (var ix = 0; ix < this.elements.length; ix++) {
			this.labelElement(this.elements[ix]);
		}
	}

	setFieldHelperContainer();

	/**
	 * The <code>type</code> field is the HTML type of field we're dealing
	 * with (checkbox, hidden, text, radio, textarea, select-one,
	 * select-multiple)
	 * 
	 * @type String
	 */
	this.type = this.elements[0].type;

	// the type of page element that this field is a member of (ie,
	// questionnaire, standardForm)
	var parentFieldsetClass = this.$formRow.parents('fieldset');

	if (this.isFilterListType())
		/**
		 * The <code>filterList</code> field is a reference to the filter list
		 * DOM element associated with this field. This will be null for fields
		 * that are not filter lists.
		 */
		this.filterList = this.getFilterList();

	if (this.isRadio())
		/**
		 * The <code>options</code> field is non null if this field is a radio
		 * button and contains a reference to the options array for this radio
		 * button group.
		 */
		this.options = this.$formRow.find("span.options")[0];

	/**
	 * Initializes the <code>label</code> field. Used to initially create a
	 * relationship between a field and it's label. Do not be deceived - label
	 * is not always an HTML Label element - it's a span in the case of radio
	 * buttons.
	 */
	this.attachLabel = function() { //
		try {
			this.label = $("#" + me.name + "_label")[0];
		} catch (e) {
			this.label = null;
		}
	};

	/**
	 * Initializes the <code>labelText</code> field. Used to create the
	 * initial relationship between a field and it's label text.
	 */
	this.attachLabelText = function() {
		try {
			this.labelText = $("#" + me.name + "_labelText")[0];
		} catch (e) {
			this.labelText = null;
		}
	};
	/**
	 * Sets the label on the related DOM HTML element.
	 * 
	 * @param label
	 *            is the text to set the label to.
	 */
	this.setLabelText = function(label) {
		if (this.labelText != null)
			if (this.labelText.firstChild != null)
				this.labelText.firstChild.nodeValue = ap.htmlDecode(label);
	};

	/**
	 * Initializes the <code>requiredIndicator</code> field. Used to create a
	 * relationship between a field and it's required indicator.
	 */
	this.attachRequiredIndicator = function() {
		try {
			this.$requiredIndicator = $("#" + me.name + "_requiredIndicator");
		} catch (e) {
			this.$requiredIndicator = null;
		}
	};

	this.attachLabel();
	this.attachLabelText();
	this.attachRequiredIndicator();

	/**
	 * The <code>initalValue</code> field (yes mispelled as it is) is the
	 * initial value of this field. The value of the field at time of object
	 * construction (this may contain an array in the case of a checkbox and
	 * multi-select control).
	 * 
	 * @type String
	 */
	this.initalValue = null;

	/**
	 * The <code>originalValue</code> field is the Pre-Transaction value of
	 * this field (NOT THE SAME AS INITIALVALUE) (Original Value cannot be
	 * changed over the context of a transaction, and is used in change
	 * management type transactions (ie endorsements, renewals))
	 * 
	 * @type String
	 */
	this.originalValue = null;

	this.originalValueIsValid = function() {
		return this.validate(false, false, true);
	};

	/**
	 * The <code>analyticsFieldData</code> field holds any
	 * analytics-supporting field data being tracked on the front-end. This is
	 * designed to be extensible per project needs through the use of
	 * field.setAnalyticsFieldData(name, value), which will cause the (name,
	 * value) pair to be included in the intraPageDTRRequest document and added
	 * to the IntraPageDTRField java object for server-side processing.
	 * 
	 * Warning: Keep an eye on the size of the IPDTR request if adding
	 * analyticsFieldData values as it could result in IPDTR performance issues.
	 */
	this.analyticsFieldData = {};

	/**
	 * Adds a (name, value) pair to be included along with IPDTR requests to
	 * support collection of data for analytics.
	 */
	this.setAnalyticsFieldData = function(name, value) {
		this.analyticsFieldData[name] = value;
	};

	/**
	 * The <code>isPendingIPDTR</code> flag is true/false depending on whether
	 * the field is queued for an upcoming IPDTR request. This is included with
	 * the analyticsFieldData on IPDTR requests
	 */
	this.setAnalyticsFieldData('isPendingIPDTR', false);

	/**
	 * Retrieve an <code>analyticsFieldData</code> value by key
	 */
	this.getAnalyticsFieldData = function(name) {
		return this.analyticsFieldData[name];
	};

	/**
	 * Returns true/false depending on whether the field is queued for an
	 * upcoming IPDTR request
	 */
	this.isPendingIPDTR = function() {
		return this.getAnalyticsFieldData('isPendingIPDTR');
	};

	/**
	 * Makes a field required. Used to add a required indicator to a field if
	 * one does not exist.
	 */
	this.addRequiredIndicator = function() {
		if (!this.$requiredIndicator.length) {
			this.$requiredIndicator = $("<span/>", {
				"id" : this.name + "_requiredIndicator"
			});

			if (parentFieldsetClass == "questionnaire") {
				this.$formRow.find('td').append(this.$requiredIndicator);
			} else {
				this.$requiredIndicator.insert(this.label.childNodes[0]);
			}
		}
		this.$requiredIndicator.addClass('requiredField');
		this.$requiredIndicator.text('*');

		this.revealRequiredIndicator();
	};

	/**
	 * Makes a field optional. Used to remove a required indicator from a field
	 * if one exists.
	 */
	this.removeRequiredIndicator = function() {
		if (this.$requiredIndicator != null) {
			this.$requiredIndicator.text('');
		}
	};

	/**
	 * The <code>tipTimeout</code> field contains the amount of time a tip
	 * should linger before disappearing. The unit of measure is in
	 * milliseconds.
	 * 
	 * @type Number
	 */
	this.tipTimeout = 3000;

	var validations = new Array(); // an array of this fields validation rules

	/**
	 * The <code>isValid</code> field is true if no errors have been
	 * discovered as part of the field's most recent validatation. Set to true
	 * prior to any validation taking place.
	 */
	this.isValid = true;

	var triggersSet = false;
	var isHighlighted = false;

	var validationEnabled = true;
	var validationStatePriorToHide = true;

	/**
	 * The <code>isHidden</code> field is true if this field is hidden.
	 * 
	 * @type Boolean
	 */
	this.isHidden = false;

	var helpers = {}; // a map of field helper ids

	/**
	 * Sets the <code>originalValue</code> field
	 * 
	 * @param originalValue
	 *            is the original value
	 */
	this.setOriginalValue = function(originalValue) {
		this.originalValue = originalValue;
	};

	/**
	 * Sets the <code>preCorrectedValue</code> field
	 * 
	 * @param preCorrectedValue
	 *            indicates the original pre-correction value of the field, if a
	 *            correction is applied. It's presence indicates a correction
	 *            has been applied.
	 */
	this.setPreCorrectedValue = function(preCorrectedValue) {
		this.preCorrectedValue = preCorrectedValue;
	};

	/**
	 * Sets the <code>isRequired</code> field
	 * 
	 * @param isRequired
	 *            indicates if the field is a required field or not
	 */
	this.setIsRequired = function(isRequired) {
		this.isRequired = isRequired;
	};

	/**
	 * Will apply special formatting to the label of the field. When invoked
	 * applies style to the field to draw the users attention.
	 */
	this.highlight = function() {
		try {
			$(me.labelText).addClass('problemField');
			$(me.$formRow.children("div").children("span")).addClass(
					'problemField');
			$(me.$formRow).addClass('problemFieldRow has-error');
			isHighlighted = true;
		} catch (e) {
		}
	};
	/**
	 * Will remove special formatting that has been applied to the label of the
	 * field. When invoked removes style added to draw the users attention.
	 */
	this.unHighlight = function() {
		try {
			$(me.labelText).removeClass('problemField');
			$(me.$formRow.children("div").children("span")).removeClass(
					'problemField');
			$(me.$formRow).removeClass('problemFieldRow has-error');
			isHighlighted = false;
		} catch (e) {
		}
	};

	/**
	 * Show the validation tip pop-up message. For backward compatibility, we
	 * support both the Validation object or the message string as parameter,
	 * but only the Validation version will callout to page.onValidationTip to
	 * allow for project customization in the tip message implementation.
	 */
	function validationTip(validationOrMessage) {
		var message; // the message text for overlib
		var attr; // object that holds the message attributes for overlib

		if (validationOrMessage.message) {
			var validation = validationOrMessage; // It has a message, so it's
													// a Validation
			attr = validation; // the validtion will hold the overlib
								// attributes
			attr.tipTimeout = me.tipTimeout;
			// setupDefaultValidationTipMessageAttributes(attr);

			if (typeof page.onValidationTip == 'function') {
				if (page.onValidationTip(me, validation) == false) {
					return;
				}
			}

			message = validation.message;
		} else {
			attr = me; // there's no validation, so we use the Field to hold
						// the overlib attributes
			// setupDefaultValidationTipMessageAttributes(attr);
			message = validationOrMessage; // It doesn't have a message
											// attribute, so it must be the
											// message
		}

		var popoverOptions = {
			'content' : message
		};

		var $valObj = null;
		if (me.isFilterListType()) {
			$valObj = me.filterList.getVisualControl(me);
		} else if (me.isDateField()) {
			$valObj = me.$formRow.find('.input-group-addon');
		} else {
			$valObj = $(me.elements[me.elements.length - 1]);
		}
		$valObj.popover(popoverOptions);
		$valObj.popover('show');

		setTimeout(function() {
			$valObj.popover('destroy');
		}, attr.tipTimeout);

	}

	/**
	 * Initialize default message attributes for the overlib call.
	 * 
	 * @param object
	 *            is the Field or Validation object to attach the attributes to.
	 */
	function setupDefaultValidationTipMessageAttributes(attr) {

		/*
		 * attr.tipWidth = 150; attr.xCoordinate = getElementX(me.elements[0]) +
		 * me.elements[0].offsetWidth + 25; attr.yCoordinate =
		 * getElementY(me.elements[0]) + 2; if (me.type == "textarea") {
		 * attr.xCoordinate = getElementX(me.elements[0]) +
		 * me.elements[0].offsetWidth - attr.tipWidth; attr.yCoordinate =
		 * getElementY(me.elements[0]); } if (me.fieldElementType == "radio") {
		 * attr.xCoordinate = getElementX(me.elements[me.elements.length-1]) +
		 * me.elements[me.elements.length-1].offsetWidth + 25; attr.yCoordinate =
		 * getElementY(me.elements[me.elements.length-1]) + 2; } if
		 * (me.fieldElementType == "question") { attr.xCoordinate =
		 * getElementX(me.elements[0]) - attr.tipWidth - 5; attr.yCoordinate =
		 * getElementY(me.elements[0]) - 25; }
		 */
	}

	/**
	 * Performs field validation execution. This is done automatically during
	 * the page submission process when client side field validations are
	 * enabled.
	 * 
	 * @return false if the field failed validation else true
	 * @type Boolean
	 */
	this.validate = function(shouldShowTip, shouldHighlightField,
			validateOriginalValue) {
		// return true immediately if there are no validations corresponding to
		// this field
		if (validations.length == 0 || validationEnabled == false
				|| me.isExcluded()) {
			me.isValid = true;
			return true;
		}

		// by default, tips are enabled when a validation fails. This behavior
		// can be overridden by passing false as an argument to the method
		var showTip = true;
		// undefined is false-y so the triple equals comparison to false is very
		// important - !shouldShowTip would introduce a bug
		if (shouldShowTip === false) {
			showTip = false;
		}
		var highlightField = true;
		// undefined is false-y so the triple equals comparison to false is very
		// important - !shouldHighlightField would introduce a bug
		if (shouldHighlightField === false) {
			highlightField = false;
		}

		for (var i = 0; i < validations.length; i++) {
			if (!validations[i].run(validateOriginalValue)) {
				if (showTip) {
					validationTip(validations[i]);
				}
				me.isValid = false;
				if (highlightField) {
					me.highlight();
				}
				return false;
			}
		}

		me.unHighlight();
		me.isValid = true;
		return true;
	};

	this.originalValueMaxlengthValid = function() {
		for (var i = 0; i < validations.length; i++) {
			if (validations[i].validatorName == 'MaxLengthValidator') {
				return validations[i].run(true);
			}
		}

		return true;
	};

	/**
	 * Removes all field validation methods associated with this field.
	 */
	this.removeValidations = function() {
		validations.splice(0, validations.length);
		triggersSet = false;
	};

	/**
	 * Used by the IPDTR response to ensure that the UI is updated to reflect
	 * the state of any changes to a field's validations. A revalidation of the
	 * field is only engaged if the field had been previouly been marked as
	 * invalid prior to the IPDTR call.
	 */
	this.resetValidationState = function() {
		if (!this.isValid) {
			// we pass false for the showTip argument - we dont want to distract
			// the user with tips he's already seen
			if (this.validate(false)) {
				this.unHighlight();
			}
		}
	};

	/**
	 * Used to initially register the focus event that runs validation for the
	 * element. Sets up the on focus event for all HTML elements associated with
	 * this field to trigger validation method invocation 'onfocus'.
	 */
	this.setFocusValidationTrigger = function() {
		for (var i = 0; i < me.elements.length; i++) {
			if (me.isFilterListType()) {
				ap.registerEvent(me.elements[i], "select2-focus", me.validate);
			} else {
				ap.registerEvent(me.elements[i], "focusin", me.validate);
			}
		}
		return true;
	};

	/**
	 * Used to register the blue and focus event that runs validation for the
	 * element. Sets up the on focus event for all HTML elements associated with
	 * this field to trigger validation method invocation 'onfocus' and
	 * 'onblur'.
	 */
	this.setValidationTriggers = function() {

		for (var i = 0; i < me.elements.length; i++) {
			if (me.isFilterListType()) {
				ap.registerEvent(me.elements[i], "select2-blur", me.validate);
			} else if (me.isListType()) {
				ap.registerEvent(me.elements[i], "change", me.validate);
				ap.registerEvent(me.elements[i], "blur", me.validate);
			} else {
				ap.registerEvent(me.elements[i], "blur", me.validate);
			}
		}

		triggersSet = true;
		return true;
	};

	/**
	 * Adds a validation method object to the running list of validation objects
	 * associated with this field.
	 * 
	 * @param validation
	 *            is the validation instance
	 * @return true
	 * @type Boolean
	 */
	this.addValidation = function(validation) {
		// add the validation to the validations array
		validations.push(validation);
		// if the validation triggers have not already been set for this field,
		// do so now.
		if (!triggersSet) {
			this.setValidationTriggers();
		}
		return true;
	};

	/**
	 * Sets the <code>validationEnabled</code> field to <b>true</b>. Can be
	 * used to enable client side field validation for a given field
	 */
	this.enableValidation = function() {
		validationEnabled = true;
	};

	/**
	 * Sets the <code>validationEnabled</code> field to <b>false</b>. Can be
	 * used as a switch to disable field validations for a given field
	 */
	this.disableValidation = function() {
		validationEnabled = false;
	};

	/**
	 * Adds a field helper to this field. Pass an anchor and we'll deal with
	 * adding it.
	 * 
	 * @param helper
	 *            is an anchor reference
	 * @return the ID of the field helper added.
	 * @type String
	 */
	this.addHelper = function(helper) {
		var id = helper.attr('id');
		// generate an id if none passed.
		if (!id) {
			id = ap.getUniqueId();
			helper.attr('id', id);
		}
		// keep track of this helper by storing it's id in the "helpers" array
		// for this field
		var $fldHelperContainer = this.getFieldHelperContainter(true);
		$fldHelperContainer.append(helper);
		helpers[id] = id;

		return id;
	};
	/**
	 * Fills up the helpers array with any field helpers in the HTML for this
	 * field.
	 */
	this.attachHelpers = function() {
		var $fldHelperContainer = this.getFieldHelperContainter(false);
		if ($fldHelperContainer.length == 0)
			return;
		var helperNodes = $fldHelperContainer.children(".tooltip-balloon");
		var helpersToRemove = new Array();
		for (var ix = 0; ix < helperNodes.length; ix++) {
			if (helperNodes.attr("data-content") == null
					|| helperNodes.attr("data-content").length == 0) {
				helpersToRemove.push(helperNodes);
			} else {
				helpers[helperNodes[ix].id] = helperNodes[ix].id;
			}
		}
		for (var ix = 0; ix < helpersToRemove.length; ix++) {
			helpersToRemove[ix].remove();
			if (helpers[helpersToRemove[ix].id]) {
				helpers[helpersToRemove[ix].id] = null;
			}
		}
	};

	this.attachHelpers();

	/**
	 * Gets a field helper by id.
	 * 
	 * @param id
	 *            is the id of the field helper.
	 * @return the helper anchor element.
	 */
	this.getHelper = function(id) {
		if (!id)
			return null;
		var helperId = helpers[id];
		var $helper = null;
		if (helperId != null) {
			$helper = this.$fieldHelperContainer.find("#" + id);
		}
		if (!$helper) {
			$helper = $("#" + id);
			if (!$helper.length) {
				$helper = this.$formRow.children().find("#" + id);
			}
		}
		return $helper;
	};

	/**
	 * Removes a field helper from this field.
	 * 
	 * @param id
	 *            of the id of the field helper
	 * @return return you true if the field helper was found and removed else
	 *         false
	 * @type Boolean
	 */
	this.removeHelper = function(id) {
		var $helper = this.getHelper(id);
		if ($helper == null)
			return false;

		$helper.off(); // turn off all events

		if (helpers[id] != null)
			helpers[id] = null;
		try {
			$helper.remove();
		} catch (e) {
		}
		return true;
	};
	/**
	 * Replaces and/or adds help bubble text in a help bubble
	 * 
	 * @param id
	 *            is the id of the anchor to which this help bubble is defined
	 * @param cssClassName
	 *            is the css class name to use
	 * @param text
	 *            is the help text to view when the user clicks on the help
	 *            bubble
	 * @param the
	 *            bubble width
	 */
	this.updateHelpBubbleText = function(id, cssClassName, text, width) {
		if (text.length == 0) {
			return this.removeHelper(id);
		}
		var $helper = this.getHelper(id);
		if ($helper == null || $helper.length == 0) {
			$helper = $("<span id="
					+ id
					+ " class='tooltip-balloon' data-placement='right' data-toggle='popover' data-html='true' data-original-title='' title=''><i class='fa fa-2 balloon'></i></span>");
			this.addHelper($helper);
			$helper.addClass(cssClassName);
		}
		$helper.attr("data-content", text);
	};

	/**
	 * Sets the CSS class name for the HTML element associated with this field
	 * 
	 * @param styleClass
	 *            is the class name to use.
	 */
	this.setStyleClass = function(styleClass) {
		$(this.elements[0]).addClass(styleClass);
	};

	/**
	 * Restores the current value to the original one.
	 */
	this.restoreOriginalValue = function restoreOriginalValue() {
		if (null != this.originalValue) {
			this.setValue(this.originalValue);
			this.setFocus();
			ap.closePopover(me.revertHelperId);
			this.removeHelper(me.revertHelperId);
			this.revertHelperId = null;
		}
	};

	/**
	 * Determines whether or not this field supports original values or not.
	 * 
	 * @return true if this field supports original values.
	 * @type Boolean
	 */
	this.supportOriginalValues = function supportOriginalValues(experienceType) {
		// Not applicable to hiddens (non-user facing fields)
		if (this.type == 'hidden' && !this.isFilterListType())
			return false;
		// there may well not be a original value for the field - that's okay,
		// there's no original value to support, so we can bail.
		if (this.originalValue == null)
			return false;

		// if we're still here, we have a field that supports original value who
		// has a corresponding Prior Value which has been captured.
		// create a copy of the field for reference by the later events that
		// will trigger manageChange
		var me = this;

		var toolTipTitle = "";
		switch (experienceType) {
		case "upload":
			styleClass = "fieldHelperUploadUnavailable";
			break;
		default:
			styleClass = "fieldHelperUndoUnavailable";
		}
		var manageChange = function() {

			var scenarioType = {
				// Primary three scenarios:
				MISMATCH_ATTENTION : {
					value : 'action.UploadMessage.AttentionRequired',
					name : 'Mismatch_Attention',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},
				MISMATCH_PASSIVE : {
					value : 'action.UploadMessage.AttentionNotRequired',
					name : 'Mismatch_Passive',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},
				REVERT : {
					value : 'action.UploadMessage.RevertMessage',
					name : 'Revert',
					fieldHelperClass : 'fieldHelperUndo'
				},

				// More detailed scenarios, can be enabled via properties.
				CORRECTED : {
					value : 'action.UploadMessage.Corrected',
					name : 'Corrected',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},
				CORRECTED_FORMATMASK : {
					value : 'action.UploadMessage.CorrectedFormatMask',
					name : 'Corrected_FormatMask',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},
				FORMATMASK_INVALID : {
					value : 'action.UploadMessage.FormatMaskInvalid',
					name : 'FormatMask_Invalid',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},
				MISMATCH_SELECT_LIST_REQUIRED : {
					value : 'action.UploadMessage.MismatchSelectListRequired',
					name : 'Mismatch_Select_List_Required',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},
				MISMATCH_SELECT_LIST_OPTIONAL : {
					value : 'action.UploadMessage.MismatchSelectListOptional',
					name : 'Mismatch_Select_List_Optional',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},
				INVALID_DATA_UPLOADED : {
					value : 'action.UploadMessage.InvalidDataUploaded',
					name : 'Invalid_Data_Uploaded',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},
				ORIGINAL_VALUE_DROPPED : {
					value : 'action.UploadMessage.OriginalValueDropped',
					name : 'Original_Value_Dropped',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},
				ORIGINAL_VALUE_TOO_LONG : {
					value : 'action.UploadMessage.OriginalValueTooLong',
					name : 'Original_Value_too_long',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				},

				Default : {
					value : 'action.UploadMessage.Default',
					name : 'Default',
					fieldHelperClass : 'fieldHelperUndoUnavailable'
				}
			};

			var subcategoriesEnabled = (ap.core_prompts["action.UploadMessage.SubcategoriesEnabled"] === 'true' ? true
					: false);

			var currentScenario = scenarioType.Default;

			var currentValue = ap.htmlDecode(me.getValue().toLowerCase());
			var originalCompareValue = ap.htmlDecode(me.originalValue
					.toLowerCase());
			var originalValue = ap.htmlDecode(me.originalValue);

			if (me.type == "textarea") {
				currentValue = currentValue.replace(new RegExp("\\r", "g"), "");
			}

			var maxLengthCorrect = false;
			// Scenarios where this logic gets invoked:
			// 1) When the current value is different to the originally uploaded
			// value
			// 2) There was a correction
			// 3) The originally uploaded value hasn't changed, but is invalid.
			if (currentValue != originalCompareValue || me.preCorrectedValue
					|| (currentValue == originalCompareValue && !me.isValid)) {
				var $revertHelper;
				var linkIcon;
				if (me.revertHelperId) {
					$revertHelper = me.getHelper(me.revertHelperId);
					linkIcon = $revertHelper.find('i');
				} else {
					$revertHelper = $(document.createElement('span'));
					linkIcon = document.createElement("i");
					$revertHelper.append(linkIcon);

					me.addHelper($revertHelper);
					me.revertHelperId = $revertHelper.attr("id");

				}
				$revertHelper.removeClass();
				var originalValueAvailable = true;
				var dataContent = "";
				var displayValue = "";

				if (me.getDisplayValue(originalValue) === undefined) {
					originalValueAvailable = false;
				}

				if (me.isFilterListType()) {
					var shadowBuffer = me.getFilterList()
							.getOptionsShadowBuffer();
					for (var ix = 0; ix < shadowBuffer.length; ix++) {
						var optionEntry = shadowBuffer[ix];
						if (optionEntry.value.toLowerCase() == originalCompareValue) {
							originalValueAvailable = true;
							displayValue = ap
									.addSlashes(optionEntry.displayText);
						}
					}
					if (!displayValue) {
						displayValue = me.originalValue;
					}
				} else {
					if (!me
							.getDisplayValue(me.preCorrectedValue ? me.preCorrectedValue
									: me.originalValue)) {
						displayValue = me.originalValue;
					} else {
						displayValue = ap
								.addSlashes(me
										.getDisplayValue((me.preCorrectedValue ? me.preCorrectedValue
												: me.originalValue)));
					}
				}

				// Determine which scenario we fall into:
				if (me.originalValueIsValid()) {
					// If original value is valid, give option to revert:
					if (me.preCorrectedValue
							&& (me.preCorrectedValue != me.originalValue || (me.preCorrectedValue == me.originalValue && me
									.isList()))) {
						// Correction was applied
						currentScenario = (subcategoriesEnabled ? scenarioType.CORRECTED
								: scenarioType.MISMATCH_PASSIVE);
						if (me.isRequired) {
							currentScenario = (subcategoriesEnabled ? scenarioType.CORRECTED
									: scenarioType.MISMATCH_ATTENTION);
						}
					} else if (originalValueAvailable) {
						if (me.fieldFormatMask
								&& me.fieldFormatMask.len == currentValue.length) {
							var maskedValue = me.fieldFormatMask
									.getUnmaskedValue(currentValue);
							if (maskedValue == me.originalValue) {
								currentScenario = (subcategoriesEnabled ? scenarioType.CORRECTED
										: scenarioType.MISMATCH_PASSIVE);
							} else {
								currentScenario = scenarioType.REVERT;
							}
						} else {
							currentScenario = scenarioType.REVERT;
						}
					} else {
						if (me.isList()) {
							if (me.isRequired) {
								currentScenario = (subcategoriesEnabled ? scenarioType.MISMATCH_SELECT_LIST_REQUIRED
										: scenarioType.MISMATCH_ATTENTION);
							} else {
								currentScenario = (subcategoriesEnabled ? scenarioType.MISMATCH_SELECT_LIST_OPTIONAL
										: scenarioType.MISMATCH_PASSIVE);
							}
						} else {
							currentScenario = (subcategoriesEnabled ? scenarioType.INVALID_DATA_UPLOADED
									: scenarioType.MISMATCH_ATTENTION);
						}
					}
				} else if (me.fieldFormatMask) {
					if (me.isValid
							&& me.originalValue.length > me.fieldFormatMask.len
							&& (me.originalValue.substring(0,
									me.fieldFormatMask.len) == currentValue)) {
						// Count it as a correction if the format-mask simply
						// truncated the value and it's now valid:
						currentScenario = (subcategoriesEnabled ? scenarioType.CORRECTED_FORMATMASK
								: scenarioType.MISMATCH_PASSIVE);
					} else if (!me.isValid) {
						if (me.fieldFormatMask.len == currentValue.length) {
							var maskedValue = me.fieldFormatMask
									.getUnmaskedValue(currentValue);
							if (maskedValue == me.originalValue) {
								currentScenario = (subcategoriesEnabled ? scenarioType.CORRECTED
										: scenarioType.MISMATCH_PASSIVE);
							} else {
								if (me.preCorrectedValue
										&& me.preCorrectedValue.length != currentValue.length) {
									currentScenario = (subcategoriesEnabled ? scenarioType.CORRECTED
											: scenarioType.MISMATCH_ATTENTION);
								} else {
									currentScenario = scenarioType.REVERT;
								}
							}
						} else {
							currentScenario = (subcategoriesEnabled ? scenarioType.FORMATMASK_INVALID
									: scenarioType.MISMATCH_ATTENTION);
						}
					}
				} else if (!me.isValid) {
					// Scenarios where current and original values are both
					// invalid:
					currentScenario = (subcategoriesEnabled ? scenarioType.INVALID_DATA_UPLOADED
							: scenarioType.MISMATCH_ATTENTION);

					if (!me.originalValueMaxlengthValid()
							&& me.preCorrectedValue) {
						currentScenario = (subcategoriesEnabled ? scenarioType.CORRECTED
								: scenarioType.MISMATCH_ATTENTION);
						maxLengthCorrect = true;
					}
				} else {
					// Current value is valid, original value was not valid.
					currentScenario = (subcategoriesEnabled ? scenarioType.INVALID_DATA_UPLOADED
							: scenarioType.MISMATCH_PASSIVE);

					if (!me.originalValueMaxlengthValid()
							&& me.preCorrectedValue) {
						currentScenario = (subcategoriesEnabled ? scenarioType.CORRECTED
								: scenarioType.MISMATCH_PASSIVE);
						maxLengthCorrect = true;
					}
				}

				displayValue = me.fieldFormatMask ? me.fieldFormatMask
						.decorate(displayValue) : displayValue;
				popoverMessage = ap.applyPositionalVariableSubstitutions(
						ap.core_prompts[currentScenario.value], ap
								.htmlDecode(displayValue));
				dataContent += popoverMessage;
				linkIcon.className = 'fa '
						+ ap.core_prompts[currentScenario.value + '.icon'];
				toolTipTitle = ap.core_prompts[currentScenario.value
						+ '.tooltip'];
				$revertHelper.addClass('fieldHelper '
						+ currentScenario.fieldHelperClass);

				// Add Revert functionality for Revert Scenario
				if (currentScenario == scenarioType.REVERT) {
					dataContent += "<div class=restoreOriginalValue>";
					dataContent += "<a href=\"javascript:void(0)\" onclick=\"javascript:var thisField = page.getField('"
							+ me.getUniqueId()
							+ "'); thisField.restoreOriginalValue() ; \">";
					dataContent += "<span class=\"btn btn-primary\">"
							+ "Revert" + "</span>";
					dataContent += "</a></div>";
				}

				// Build the popover:
				var titleString = '<span>&nbsp;<span><button type="button" class="close" onclick="ap.closePopover(\''
						+ $revertHelper.attr("id")
						+ '\');"  aria-hidden="true">&times;</button>';
				$revertHelper.popover({
					'html' : true,
					'content' : dataContent,
					'title' : titleString
				});

				// If revertHelper has already created a popover, bootstrap
				// doesn't let us reuse the
				// constructor above, so we have to set each dynamic attribute
				// again.
				$revertHelper.attr('data-content', dataContent);

				// Tooltips are now disabled in favor of pop-overs (more
				// responsive-friendly)
				if (ap.core_prompts["action.UploadMessage.tooltipsEnabled"] === 'true') {
					$revertHelper.tooltip({
						'title' : toolTipTitle
					});
				}

				// Sometimes we have to change the link icon if we have changed
				// between states:
				if (linkIcon.hasClass && !linkIcon.hasClass(linkIcon.className)) {
					linkIcon.removeClass();
					linkIcon.addClass(linkIcon.className);
				}

			} else {
				me.removeHelper(me.revertHelperId);
				me.revertHelperId = null;
			}
			me.validate(false, false, false); // reset isValid
			// if corrected via max length, no highlight
			if (me.isValid || maxLengthCorrect) {
				me.unHighlight();
			} else {
				me.highlight();
			}
		};
		for (var i = 0; i < this.elements.length; i++) {
			manageChange();
			ap.registerEvent(this.elements[i], 'change', manageChange);
			ap.registerEvent(this.elements[i], 'blur', manageChange);
		}
		return true;
	};

	/**
	 * Sets the focus on the first member element of this field and scroll the
	 * page to make the field visible. Since there is a fixed menu on the top,
	 * we need to scroll the page to field position + the height of the menu
	 * bar. 'main-menu' is the id of the menu bar div.
	 */
	this.setFocus = function() {
		try {
			var $el = $('#' + this.elements[0].id);
			if (!$el.visible()) {
				if ($('#main-menu').length) {
					var elOff = $el.offset().top;
					elOff = elOff - $('#main-menu')[0].scrollHeight - 10;
					$('body,html').animate({
						scrollTop : elOff
					}, 100);
				}
			}
			this.elements[0].focus();
		} catch (e) {
			ap.consoleError(e);
		}
	};

	/**
	 * Hides this field from the user.
	 * 
	 * @return true if the field results in a hidden state
	 * @type Boolean
	 */
	this.hide = function() {
		if (this.isHidden)
			return true;
		if (this.$formRow.length) {
			this.$formRow.css("display", "none");
			validationStatePriorToHide = validationEnabled;
			this.isHidden = true;
			this.disableValidation();
			return true;
		}
		return false;
	};

	/**
	 * Shows this field to the user.
	 * 
	 * @return true if the field results in a visible state
	 * @type Boolean
	 */
	this.show = function() {
		if (!this.isHidden)
			return true;
		if (this.$formRow) {
			this.$formRow.css("display", "block");
			if (this.isHidden)
				validationEnabled = validationStatePriorToHide;
			this.isHidden = false;
			return true;
		}
		return false;
	};

	/**
	 * Returns the relative position of this field.
	 * 
	 * @return the relative position of this field.
	 * @type Number
	 */
	this.getRelativePosition = function() {
		return this.relativePosition;
	};

	/*
	 * Set the snippet if for this field @param snipId is the string snippet id
	 */
	this.setSnippetId = function(snipId) {
		this.snippetId = snipId;
	}
	/*
	 * Set the snippet data @param json object representing snippet data
	 */
	this.setSnippetData = function(snipData) {
		this.snippetData = snipData;
	};

	this.setSnippetFileName = function(snipFileName) {
		this.snippetFileName = snipFileName;
	};

	this.setSnippetPageNumber = function(snipPageNum) {
		this.snippetPageNumber = snipPageNum;
	}

	this.setSnippetConfidence = function(snipConfidence) {
		this.snippetConfidence = snipConfidence;
	}

	this.setSupportsOverride = function(supportsOverride) {
		this.supportsOverride = supportsOverride;
	}

	this.setLowConfidenceIndicator = function() {
		try {
			conf = Number(this.snippetConfidence);
			if (this.snippetConfidence != "" && conf < page.lowConfidenceThreshold) {
				$("#" + me.name).addClass('snippet-low-confidence');
			}
		} catch (e) {
			ap.consoleError(e);
		}
	}

};

/*
 * The <code>filterListMap</code> is a map which contains all of the
 * FilterList instance for a page. The key to this map is the id of the
 * associated field element.
 */
ap.filterListMap = {};

/**
 * Returns the FilterList instance for the given field id.
 * 
 * @param fieldId
 *            is the field unique id
 * @return the FilterList instance or null if not found
 * @type FilterList
 */
ap.getFilterList = function(fieldId) {
	return ap.filterListMap[fieldId];
};

/**
 * Constructs a new FilterList object. Select2 jquery plugin is used for this
 * purpose http://ivaynberg.github.io/select2/
 * 
 * @constructor
 * @class The FilterList class provides a generalized implementation of a
 *        filtered list and replaces the previous filter list implementation
 *        with similar functionality.
 * @param filterListElementId
 *            is the HTMLInputHiddenElement which this instance manages.
 * @param optionData
 *            is array of OptionEntry objects consisting of data value and
 *            display value pairs.
 */
ap.FilterList = function(filterListElementId, initialValue, optionData) {

	/**
	 * Inner class OptionEntry simply is an association of the display and data
	 * values for a given select list entry/item.
	 * 
	 * @param displayValue
	 *            is the value displayed to the user
	 * @param dataValue
	 *            is the value that is posted to server
	 * @param isSelected
	 *            is a boolean flag indicated if the option has to be shown as
	 *            selected.
	 */
	function OptionEntry(displayValue, dataValue, isSelected) {
		this.displayText = displayValue;
		this.text = displayValue;
		this.value = dataValue;
		this.id = dataValue;
		this.isSelected = isSelected;
		this.getValue = function() {
			return this.dataValue;
		};
		this.getDisplayValue = function() {
			return this.displayValue;
		};
	}
	// Update filter list map
	ap.filterListMap[filterListElementId] = this;
	/**
	 * The <code>id</code> is the html id associated with this filter list.
	 * This is shared by the the AP Field instance which this filter list is
	 * directly related.
	 * 
	 * @type String
	 */
	this.id = filterListElementId;
	/**
	 * The <code>optionsData</code> field contains an array of OptionEntry
	 * objects that drive the filterlist. If changes to the options need to be
	 * made to this array inorder for them to be reflected on the UI.
	 * 
	 * @type Array
	 */
	this.optionsData = optionData; // an array of OptionEntry instances

	var me = this; // used to create a copy of this object for later callbacks
					// from page events

	/**
	 * The <code>$filterListElement</code> field is a reference to the
	 * HTMLInputElement in the DOM to which this is directly related.
	 */
	this.$filterListElement = $('#' + filterListElementId);

	// we use the standard jquery val() api instead of select2 here because
	// select2 hasn't been initialized yet.
	// the goal is to take the initial JS encoded value and place it onto the
	// DOM before select2 gets involved.
	// the DOM doesnt have the value during the initial paint because the server
	// side doesn't have the ability
	// to render js encoded string without also html encoding it first which
	// would create a mismatch between
	// the value on the DOM and the rendered list of optionsData that select2 is
	// working with.
	this.$filterListElement.val(initialValue);

	this.isInitialized = false;
	/**
	 * The <code>parentHotField</code> field is a reference to the parent hot
	 * field. This will remain null if the parent Field is not a hot field.
	 * 
	 * @type Field
	 */
	this.parentHotField = null;

	/**
	 * The <code>readOnly</code> represents if the field is readonly
	 */
	this.readOnly = false;
	/**
	 * The
	 * <code>previousSearchValue<code> tracks the previous value that the user typed
	 *	into the search input text control.
	 */
	this.previousSearchValue = '';

	/**
	 * The
	 * <code>isOriginHotField<code> will be true if the input search field caused
	 *	an IPDTR call.
	 */
	this.isOriginHotField = false;

	/**
	 * Initializes the filterlist object that will manage the lifecycle of the
	 * select2 combox box component
	 * 
	 * @return true if intialization was successful and if this is not a
	 *         reinitialization scenario
	 */
	this.init = function(reinitialize) {
		if (reinitialize) {
			// we pass true here to remove any exisitng control from the dom -
			// we're about to paint a new one
			this.destroy(true);
		}
		if (this.isInitialized || this.readOnly) {
			return;
		}

		// If the input search field is the cause of IPDTR then don't
		// reinitialize the list otherwise we will lose all of the non
		// matching entries.
		if (this.isOriginHotField) {
			this.isOriginHotField = false;
			return;
		}

		// select2 looks for properties id and text by default.
		// grab initial value
		var initialValue = this.$filterListElement.val();
		// Blow away current value since it may not be valid (upload scenario).
		this.$filterListElement.val("");
		for (var i = 0; i < this.optionsData.length; i++) {
			this.optionsData[i].id = this.optionsData[i].value;
			this.optionsData[i].text = this.optionsData[i].displayText;
			if (initialValue === this.optionsData[i].value) {
				ap.consoleInfo('Selected option = '
						+ this.optionsData[i].displayText);
				this.$filterListElement.val(this.optionsData[i].value);
			}
		}

		try {
			this.initSelect2();
		} catch (e) {
			ap.consoleError(e.message);
		}
		this.isInitialized = true;
	};

	/**
	 * Set a new array of the OptionsList Entries to this filterlist. This
	 * method is usually called when a list refresh is caused by an IPDTR call.
	 * 
	 * @param optionsObject
	 *            is an Array of OptionEntry instances
	 */
	this.setOptionListData = function(optionsObject) {
		this.optionsData = optionsObject;
	};

	/**
	 * Get the Array of OptionEntry objects that represent the optionlist
	 * entries
	 */
	this.getOptionListData = function() {
		return {
			results : this.optionsData
		};
	};

	/**
	 * Get boolean flag that indicates if the filterlist component is
	 * initialized
	 */
	this.getIsInitialized = function() {
		return this.isInitialized;
	};

	/**
	 * Get OptionEntry object representing the options selected by user
	 */
	this.getSelectedOption = function() {
		var val;

		if (this.getIsInitialized() == false || this.readOnly) {
			val = $('#' + filterListElementId).val();
		} else {
			val = this.$filterListElement.select2("val");
		}
		// find the corresponding option entry for the value
		for (var i = 0; i < this.optionsData.length; i++) {
			if (this.optionsData[i].value === val) {
				return this.optionsData[i];
			}
		}
		// its possible, especially in upload scenarios, to not have an option
		return null;
	};

	/**
	 * Retrieves the display value for the selected list item (typically used
	 * for readonly)
	 */
	this.getDisplayValue = function() {
		var option = this.getSelectedOption();
		if (option != null) {
			return option.displayText;
		}
		return "";
	};

	/**
	 * Destroy the select2 combobox component. Reverts the DOM struture to its
	 * prior state. The value selected by user will be retained
	 * 
	 * @param updateDom
	 *            inidicates whether we should physically remove the select2
	 *            control from the dom, useful for reinitialize scenarios
	 */
	this.destroy = function(updateDom) {
		try {
			// There should only ever be one control but techinically this is an
			// array
			var $controls = this.$filterListElement
					.siblings('.select2-container');
			if ($controls.length > 0) {
				this.$filterListElement.select2("destroy");
				// removing form the dom is necessary if we're about to
				// reinitialize the select2 component and draw a new one
				if (updateDom) {
					$controls.remove();
				}
			}
			this.isInitialized = false;
		} catch (e) {
			ap.consoleError(e.message);
		}
	};

	/**
	 * This is method invokes the filterlist implementation. There are different
	 * ways to initialize select2 component. 1) Use a html selects elements
	 * option to drive the select2 component 2) Provide an array of optionlist
	 * data with a hidden input element
	 * 
	 * Option 1 has performance issues when dealing with large lists. Option 2
	 * has more flexibility when loading data from IPDTR call and performance on
	 * IE is much better
	 */
	this.initSelect2 = function() {
		this.comboboxElement = this.$filterListElement
				.select2({
					initSelection : function(element, callback) {
						var selection = jQuery.grep(me.optionsData, function(
								option) {
							return option.id === element.val();
						});
						callback(selection[0]);
					},
					query : function(options) {
						var pageSize = 100;
						var startIndex = (options.page - 1) * pageSize;
						var filteredData = me.optionsData;
						var stripDiacritics = window.Select2.util.stripDiacritics;

						if (options.term && options.term.length > 0) {
							if (!options.context) {
								var term = stripDiacritics(options.term
										.toLowerCase());
								options.context = me.optionsData
										.filter(function(metric) {
											// since data is very big... save
											// the stripDiacritics result for
											// later
											// to speed up next search.
											// this does modify the original
											// array!
											if (!metric.stripped_text) {
												metric.stripped_text = stripDiacritics(metric.text
														.toLowerCase());
											}
											return (metric.stripped_text
													.indexOf(term) !== -1);
										});
							}
							filteredData = options.context;
						}

						options
								.callback({
									context : filteredData,
									results : filteredData.slice(startIndex,
											startIndex + pageSize),
									more : (startIndex + pageSize) < filteredData.length
								});
					},
					placeholder : "Select One",
					multiple : false,
					width : 'resolve'
				});
		this.$filterListElement.siblings('.select2-container').show();
	};

	/**
	 * Adds a new option entry to array of options used by the component. This
	 * is called from IPDTR javascript
	 * 
	 * @param displayText
	 *            is the display value for the option entry
	 * @param dataValue
	 *            is the value saved when an option is selected
	 * @param isSelected
	 *            is a boolean flag to indicate if this option is the selected
	 *            option
	 * @return an instance of OptionEntry created.
	 */
	this.addOption = function(displayText, dataValue, isSelected) {
		var optionEntry = new OptionEntry(displayText, dataValue, isSelected);
		this.optionsData.push(optionEntry);
		return optionEntry;
	};

	/**
	 * Empty the array of option list that drives the select2 component
	 */
	this.emptyList = function() {
		this.optionsData.splice(0, this.optionsData.length);
	};

	/**
	 * Gets the associated AP Field instance.
	 * 
	 * @return the related AP Field instance associated with this filter list
	 * @type ap.Field
	 */
	this.getRelatedParentField = function() {
		try {
			return page.getField(this.id);
		} catch (noPageError) {
			// Most likely running in an interview context where there is no
			// client side object model.
			return null;
		}
	};

	/**
	 * Mark this filterlist as readonly
	 * 
	 * @param readonly
	 *            boolean flag
	 */
	this.setReadOnly = function(readonly) {
		this.readOnly = readonly;
	};

	/**
	 * Set the tab index of the filterlist. Since filterlist is not a read input
	 * field, this method tries to set the index on the anchor
	 * 
	 * @type tabIndex is the index to use set
	 */
	this.setTabIndex = function(field, tabIndex) {
		if (this.readOnly) {
			return;
		}
		this.getFocusControl(field).attr('tabindex', tabIndex);
	};

	/**
	 * The the visual control for the given field. Since the true input is a
	 * hidden field, this function can be used to retrieve the visual on screen
	 * control, which in select2's case is an anchor tag
	 * 
	 * @param parentField
	 *            is the owning field, this is needed because the filterList
	 *            object doesn't have a reference to the parent field
	 * @returns the jQuery object representation of the select2-choice anchor
	 *          element
	 */
	this.getVisualControl = function(parentField) {
		return parentField.$formRow.find(".select2-choice");
	};

	/**
	 * The the focus control for the given field. This is the text field which
	 * has focus when we tab to the field or click on the visual control. It is
	 * listening for keyboard events to support opening the control on type and
	 * navigating with the arrows.
	 * 
	 * @param parentField
	 *            is the owning field, this is needed because the filterList
	 *            object doesn't have a reference to the parent field
	 * @returns the jQuery object representation of the select2-choice anchor
	 *          element
	 */
	this.getFocusControl = function(parentField) {
		return parentField.$formRow.find(".select2-focusser");
	};

	/**
	 * Gets the value from the underlying filterlist element. Returns an empty
	 * string if the filterlist has not been initialized yet or in some cases
	 * where the value could not be retrieved.
	 */
	this.getValue = function() {
		if (this.getIsInitialized()) {
			var optionEntry = this.getSelectedOption();

			if (optionEntry != null) {
				return optionEntry.value;
			}
		} else if (this.readOnly) {
			return this.$filterListElement.val();
		}
		return "";
	};

	/**
	 * Set the value to the filterlist element. By setting the value to the
	 * underlying input element, and triggering the change event, the select2
	 * component will refresh the UI appropriately
	 */
	this.setValue = function(value) {
		if (value != null && this.getIsInitialized()) {

			// store what the previous value is so we can monitor for changes
			var oldVal = this.getValue();

			this.$filterListElement.select2("val", value);

			// only trigger change events if the value has truly changed
			if (oldVal !== value) {
				this.$filterListElement.trigger("change");
			}
		}
	};

	/**
	 * Resets the HTMLSelectElement list to contain what the initial full
	 * contents. This method should be called when UI needs to be refreshed
	 * based on change in dom input elements value
	 */
	this.reset = function() {
		if (this.readOnly) {
			return;
		}
		this.$filterListElement.trigger("change");
	};

	/**
	 * Invoked by a 'hot' parent Field class to set up the input field to re-act
	 * as a hot field just like its related list. This does not check to see if
	 * the parent hot field reference is truly a hot field or not assuming that
	 * this method is only called when the parent Field is indeed a hot field.
	 * 
	 * @param parentHotField
	 *            is the parent hot Field class instance
	 */
	this.setupHotField = function(parentHotField) {
		this.parentHotField = parentHotField;
		if (!parentHotField.readOnly) {
			ap.registerEvent(this.$filterListElement, "change",
					onFilterInputHotFieldChanged);
		} else {
			$(this.$filterListElement).off("change",
					onFilterInputHotFieldChanged);
		}
	};

	/**
	 * Register a focus event for the filter list.
	 * 
	 * @param field
	 *            the ap.Field instance for this filterlist field
	 * @param callback
	 *            is the function to be called when focus event is raised.
	 */
	this.setupFocusEvent = function(field, callback) {
		var focusField = this.getFocusControl(field);
		if (this.readOnly) {
			$(focusField).off("focus", callback);
		} else {
			ap.registerEvent(focusField, "focus", callback);
		}
	}

	/**
	 * Event callback invoked when the user changes the input field associated
	 * with this filter list. This is the origin point of a AJAX DTR request.
	 */
	function onFilterInputHotFieldChanged() {
		me.isOriginHotField = true;

		me.parentHotField.makeIntraPageDTRRequest();
		// reset the isOriginHotFieldProperty:
		//
		// In the case that the IPDTR request
		// resulted in a refresh of the filterlist options,
		// this is redundant but will cause no harm
		//
		// in the case that the IPDTR request did not result in a refresh
		// of the filterlist, future IPDTR calls from other fields
		// which do result in an update of the filterlist contents will
		// have the optionsShadowBuffer reconstructed appropriately.
		//
		me.isOriginHotField = false;
	}

	/**
	 * Clears the value from the filterlist component and underlying input field
	 */
	this.clearField = function() {
		if (this.readOnly) {
			return;
		}
		if (this.$filterListElement) {
			this.$filterListElement.select2("val", "");
		}
	};

	/**
	 * Display the filterlist field with default value from the select input
	 * element
	 */
	this.show = function(parentField) {
		if (this.readOnly) {
			return;
		}
		this.getVisualControl(parentField).show();
	};

	/**
	 * Destroy the filterlist rendering as the field is set to readonly
	 */
	this.hide = function(parentField) {
		this.getVisualControl(parentField).hide();
	};

	/**
	 * Returns the option list buffer managed by this instance. Remember that
	 * this is an array OptionEntry instances.
	 * 
	 * @return the option list buffer managed by this instance.
	 * @type Array
	 */
	this.getOptionsShadowBuffer = function() {
		return this.optionsData;
	};

	/**
	 * Replace the list that drives the select2 component Called when the select
	 * list DOM element has been changed. This occurs when the innerHTML is
	 * overwritten.
	 */
	this.resetFilterListData = function(dataToUse, retainValue) {
		if (this.readOnly || !this.getIsInitialized()) {
			return;
		}
		var oldVal;

		if (retainValue) {
			oldVal = this.getValue();
		}
		if (dataToUse) {
			this.setOptionListData(dataToUse);
		}
		this.$filterListElement.select2("data", dataToUse);

		// Clearing the field after it's data has changed will bring back
		// the "Select One" placeholder and avoid an "undefined" selection
		this.clearField();

		if (retainValue) {
			this.setValue(oldVal);
		}
	};

};

/**
 * Construct a new Validation object.
 * 
 * @constructor
 * @class This is the basic Validation class. It relates loosely to the server
 *        side ValidationElement class
 * @param parentField
 *            is the field to which this validation applies.
 * @param routine
 *            is the validation routine to invoke.
 * @param message
 *            is the is the validation message to show when validation fails.
 * @param validatorName
 *            is the is the validator name
 * @return A new Validation
 */
ap.Validation = function(parentField, routine, message, validatorName) {
	/**
	 * The <code>parentField</code> field is a reference back to the field.
	 * 
	 * @type Field
	 */
	this.parentField = parentField; // addressability to parent Field
	/**
	 * The <code>routine</code> field is the validation function to call.
	 */
	this.routine = routine;
	/**
	 * The <code>message</code> field is the validation message to show the
	 * user when the validation fails.
	 * 
	 * @type String
	 */
	this.message = message;

	/**
	 * The <code>validatorName</code> field is the validator name
	 * 
	 * @type String
	 */
	this.validatorName = validatorName;
	/**
	 * Returns the current value of the parent field.
	 * 
	 * @return the current value of the parent field.
	 * @type String
	 */
	this.getValue = function getValue() {
		return parentField.getValue();
	};
	/**
	 * Runs the validation routine.
	 * 
	 * @return true if the validation method passes else false
	 * @type Boolean
	 */
	this.run = function run(validateOriginalValue) {
		if (validateOriginalValue) {
			this.getValue = function() {
				if (parentField.preCorrectedValue) {
					return parentField.preCorrectedValue;
				} else {
					return parentField.originalValue;
				}
			};
		} else {
			this.getValue = function() {
				return parentField.getValue();
			};
		}
		if (!eval(this.routine)) {
			return false;
		}
		return true;
	};
};

/**
 * Construct a new UserGroup object.
 * 
 * @constructor
 * @class This is basic UserGroup object
 * @param groupId
 *            is the identity of this user group
 * @param groupName
 *            is the name of this user group.
 * @param groupType
 *            is the type of this user group.
 * @return A new UserGroup instance.
 */
ap.UserGroup = function(groupId, groupName) {
	this.groupId = groupId;
	this.groupName = groupName;
	this.toString = function() {
		return 'Usergroup id: ' + this.groupId + ', name: ' + this.groupName;
	};

};

/**
 * Construct a new Permission object.
 * 
 * @constructor
 * @class This is basic Permission object
 * @param permissionId
 *            is identity of the permission.
 * @param permissionName
 *            is the name of the permission.
 * @return A new Permission instance.
 */
ap.Permission = function(permissionId, permissionName) {
	this.permissionId = permissionId;
	this.permissionName = permissionName;
	this.toString = function() {
		return 'Permission id: ' + this.permissionId + ', name: '
				+ this.permissionName;
	};
};

/**
 * Construct a new Role object.
 * 
 * @constructor
 * @class This is basic Role object
 * @param roleId
 *            is identity of the role.
 * @param roleName
 *            is the name of the role.
 * @param permissions
 *            is an array of Permission instances.
 * @return A new Role instance.
 */
ap.Role = function(roleId, roleName, permissions) {
	this.roleId = roleId;
	this.roleName = roleName;
	this.permissions = permissions;
	this.toString = function() {
		var stateAsString = new ap.StringBuffer();
		stateAsString.append('Role id: ' + this.roleId + ', name: '
				+ this.roleName);
		for (var ix = 0; ix < this.permissions.length; ix++) {
			stateAsString.append(' ');
			stateAsString.append(permissions[ix].toString());
		}
		return stateAsString.toString();
	};
};

ap.User = function() {
	/**
	 * The <code>firstName</code> field is the first name of the current user.
	 * 
	 * @type String
	 */
	this.firstName = '';
	/**
	 * The <code>middleName</code> field is the middle name of the current
	 * user.
	 * 
	 * @type String
	 */
	this.middleName = '';
	/**
	 * The <code>lastName</code> field is the last name of the current user.
	 * 
	 * @type String
	 */
	this.lastName = '';
	/**
	 * The <code>userGroupId</code> field is the user group id of the current
	 * user.
	 * 
	 * @type UserGroup
	 */
	this.primaryUserGroup = '';
	/**
	 * The <code>roles</code> field contains the roles for the current user.
	 * 
	 * @type Array of Role instances
	 */
	this.roles = '';

	/**
	 * Sets the <code>firstName</code> field.
	 */
	this.setFirstName = function setFirstName(firstName) {
		this.firstName = firstName;
	};
	/**
	 * Sets the <code>middleName</code> field.
	 */
	this.setMiddleName = function setMiddleName(middleName) {
		this.middleName = middleName;
	};
	/**
	 * Sets the <code>lastName</code> field.
	 */
	this.setLastName = function setLastName(lastName) {
		this.lastName = lastName;
	};
	/**
	 * Sets the <code>primaryUserGroup</code> field.
	 */
	this.setUserGroup = function setUserGroupId(primaryUserGroup) {
		this.primaryUserGroup = primaryUserGroup;
	};
	/**
	 * Sets the <code>roles</code> field.
	 */
	this.setRoles = function setRoles(roles) {
		this.roles = roles;
	};

};

/**
 * This class implements a countdown time used for browser inactivity.
 */
ap.Timer = function() {

	/**
	 * Initialize.
	 */
	this.initialize = function(options) {
		this.el = $('#' + options.id);
		this.countDownStart = options.countDownStart;
		this.intv = null;
	};

	this.initialize(arguments[0]);

	this.stop = function() {

		if (this.intv != null) {
			clearInterval(this.intv);
		}
		$('#lb_idle_message').modal('hide');
		if (typeof (page) != 'undefined') {
			page.autoSave();
		}
		$.idleTimer('destroy');
		var url = location.href;
		var index = (url.split("?")[0]).lastIndexOf('/');
		url = url.substring(0, index) + "/ProcessLogoff";
		location.href = url;
	};

	this.formatNum = function(n, addZero) {
		return (n < 10 && addZero == true) ? '0' + n : n;
	};

	this.formatTime = function(n, m, s) {
		s = n % 60;
		m = (n - s) / 60;
		return [ this.formatNum(m, false), ':', this.formatNum(s, true) ]
				.join('');
	};

	this.start = function() {

		ap.consoleInfo('start ilde timer count...................');
		if (this.intv != null) {
			clearInterval(this.intv);
		}

		this.counter = this.countDownStart * 60;
		this.intv = setInterval(function() {
			ap.timer.counter--;
			var timeVal = ap.timer.formatTime(ap.timer.counter);
			if (ap.timer.el != null) {
				ap.timer.el.html(timeVal + '&nbsp;');
			}
			if (ap.timer.counter == 0) {
				ap.timer.stop();
			}
		}, 1000);

		$('#lb_idle_message').modal('show');
	};

	this.continueWork = function() {

		$('#lb_idle_message').modal('hide');
		clearInterval(this.intv);
	};
};

$(function() {
	$(window).scroll(function() {	
		if ($(this).scrollTop() != 0) {
			$('#backtotop').fadeIn();
		} else {
			$('#backtotop').fadeOut();
		}
	});

	$('#backtotop').click(function() {
		$('body,html').animate({
			scrollTop : 0
		}, 100);
	});
});
