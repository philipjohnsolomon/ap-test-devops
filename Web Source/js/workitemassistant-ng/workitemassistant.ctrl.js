(function() {

	'use strict';

	var workitemAssistantModule = angular.module('workitemAssistantApp', ['angularFileUpload','angularModalService']);

	/**
	 * work item assistant controller
	 */
	workitemAssistantModule.controller('workitemAssistantCtrl', ['$scope', '$timeout', '$http', 'ModalService', function($scope, $timeout, $http, ModalService) {	

		$scope.showWorkitemAssistant = false;
		$scope.comments = {};
		$scope.fileattachments = {};
		$scope.activeusers = '';
		$scope.filetypes = {};
		$scope.editInProgress = false;
		$scope.commentInputs = {};

		/**
		 * pull data from REST
		 */
		$scope.update = function () {
			if(!$scope.editInProgress){
				$http.get("api/workitemassistants/data?WORKITEMID="+ ap.transaction.workItemId, {
					headers: { 'Accept': 'application/json' },
					params: {CSRF_TOKEN: ap.page.csrfToken,transaction_id: ap.transaction.id, rnd: new Date().getTime()}}
				).success(function(data){
					var results = data.response.results.workItemAssistant;
					$scope.updateData(results);
				})
				.error(function(data,status, headers){
					ap.consoleInfo("WIA is not supported");
					$scope.showWorkitemAssistant = false;
				});			
			}
		};

		/**
		 * update the data
		 * @param results the data from REST
		 */
		$scope.updateData = function(results){
			var comments = [];		
			if(results.comments){
				$.each(results.comments, function(i, entry) {
					comments[entry.id] = $("#comments_text" + entry.id).val();
				});
				$scope.comments = results.comments;
			}

			if(results.fileattachments){
				$scope.fileattachments = results.fileattachments;
				$scope.filetypes = $scope.fileattachments[0].fileTypes;
			}
			if(results.activeusers){
				$scope.activeusers =  results.activeusers;
			}
			$scope.showWorkitemAssistant = true;

			for (var key in comments) {
				$("#comments_text" + key).val(comments[key]);
			}
		};

		$scope.update();
		var poll = function() {
			if($scope.showWorkitemAssistant){
				$timeout(function() {
					$scope.update();
					if($scope.showWorkitemAssistant){
						poll();
					}
				}, ap.page.clientUpdateInterval * 1000);
			}
		};     
		poll();

		/**
		 * check if the comment input is empty
		 * @param section the section object
		 */
		$scope.commentsEmpty= function (section){
			var val = $scope.commentInputs[section.id];		
			return (null == val || val  == ''); 
		};

		/**
		 * add comment
		 * "pages/{" + PAGE_ID + "}/sections/{"  + SECTION_ID  +  "}/comments"
		 * @param section the section object
		 */
		$scope.addComment = function(section){
			var data = { commentText: $scope.commentInputs[section.id]};
			
			var url = $scope.getBaseUri(section.id) + "comments/contents?" + $scope.getCommonUrlParams();
			$scope.service(url, 'POST', data, function(results){
				$scope.update();
				$scope.commentInputs[section.id] = '';
			}, null);			

		};


		/**
		 * delete an entry
		 * @param entry the comment or file attachment entry
		 * @param section the section object
		 */
		$scope.deleteEntry = function(entry, section){	
			$scope.editInProgress = true;
			var template = 'deleteCommentConfirmModal.html';
			if(section.type == 'fileAttachments'){
				template = 'deleteFileConfirmModal.html';
			}
			ModalService.showModal({
				templateUrl: template,
				controller: "deleteModalCtrl",
				inputs: { entryId: entry.id, sectionType: section.type, sectionId:  section.id}
			}).then(function(modal) {
				modal.element.modal();
				modal.close.then(function(result) {
					$scope.editInProgress = false;
				});
			});
		};


		/**
		 * edit an entry (for file name only)
		 * @param entry the file attachment entry
		 */
		$scope.editEntry = function(entry, section){	
			$scope.editInProgress = true;
			ModalService.showModal({
				templateUrl: 'fileNameModal.html',
				controller: "fileNameModalCtrl",
				inputs: { entryId: entry.id, sectionId: section.id }
			}).then(function(modal) {
				modal.element.modal();
				modal.close.then(function(result) {
					$scope.editInProgress = false;
				});
			});
		};

		/**
		 * send request over
		 * @param url  the request url
		 * @param method the request method
		 * @param data the post form data
		 * @param callback the call back for a successful request
		 * @param error_callback the call back with error
		 */
		$scope.service = function(url, method, data, callback, error_callback){
			var params = {
					url: url,
					type: method,
					dataType : "json",
					headers: { Accept: 'application/json' },
					success:(function(response) {
						if(callback){ callback.call(this, response.response.results);}
					}),
					error:(function(response){
						if(error_callback){error_callback.call(this, response);}
					})
			};
			if(data){ params['data'] = data;}
			$.ajax(params);
		};
		
		/**
		 * return base uri
		 * @param sectionId the section id
		 */
		$scope.getBaseUri = function(sectionId){
			var url = "api/workitemassistants/pages/" + ap.page.id +  "/sections/" + sectionId +  "/";
			return url;
		};
		
		/**
		 * return the commom url parameters
		 * 
		 */
		$scope.getCommonUrlParams = function(){
			var params = 	$.param({"CSRF_TOKEN": ap.page.csrfToken, "WORKITEMID" : ap.transaction.workItemId, "transaction_id": ap.transaction.id});
			return params;
		};
		
	}]);

	/**
	 * file upload controller
	 */
	workitemAssistantModule.controller('workitemAssistantUploadCtrl', ['$scope','FileUploader', function($scope, FileUploader){	
		$scope.fileTypeCode = '';	    
		var uploader = $scope.uploader = new FileUploader({
			url: 'FrontServlet',
			removeAfterUpload:true,
			queueLimit:  1,
			autoUpload: false 
		});

		uploader._addToQueue = uploader.addToQueue;
		
		uploader.onBeforeUploadItem = function(item) {
			item.formData.push({
				CSRF_TOKEN: ap.page.csrfToken,
				WORKITEMID: ap.transaction.workItemId,
				PAGE_NAME: ap.page.id,
				TRANSACTION_NAME: ap.transaction.id,
				METHOD:'Process',
				NEXT: 'WorkItemAssistant',
				ACTION:'FileAttachmentAdd',
				SECTION: $scope.fileattachments[0].id,
				FILE_TYPE: $scope.fileTypeCode
			});
			
			$("#wia_filesize_error_msg").hide();
			$("#wia_filevalidation_error_msg").hide();
		};

		uploader.onCompleteItem = function(item, response, status, headers) {
			if (response && response.response && response.response.status && response.response.status == -119) {
				$("#wia_filesize_error_msg").show();
			}
			else if (response && response.response && response.response.status && response.response.status == -120) {
				$("#wia_filevalidation_error_msg").show();
			}
			else {
				$scope.update();
			}
			
			uploader.clearQueue();
		};
		
		uploader.hasFileCodeSelected = function() {			
			return ($("#fileTypeCode").val() != '');
		};

		uploader.showQueue = function(){
			if(uploader.isHTML5){
				return true;
			}

			return false;
		};

		uploader.showAction = function(){
			return false;
		};
		
		uploader.sendAll = function(){
			if(!uploader.hasFileCodeSelected() || uploader.getNotUploadedItems().length == 0 ){
				$("#wia_error_msg").show();
				$("#wia_filesize_error_msg").hide();
				$("#wia_filevalidation_error_msg").hide();
			}else{
				uploader.uploadAll();
				$("#wia_error_msg").hide();
			}
		};
		
		uploader.clearAll = function(){
			uploader.clearQueue();
			$("#wia_error_msg").hide();
			$("#wia_filesize_error_msg").hide();
			$("#wia_filevalidation_error_msg").hide();
		};
		
		/**
		 * add file to queue. if the queue is full,  remove the first one
		 */
		uploader.addToQueue = function(files, options, filters) {
			$scope.fileTypeCode = $("#fileTypeCode").val();
			 if(uploader.queue.length == uploader.queueLimit){
				 var item = uploader.queue[0];
	             if (item.isUploading){
	            	 item.cancel();
	             }
	             uploader.queue.splice(0, 1);
	             item._destroy();
	             uploader.progress = uploader._getTotalProgress();
			 }
			 uploader._addToQueue(files, options, filters);
			 $("#fileTypeCode").val($scope.fileTypeCode);
			 $("#wia_filesize_error_msg").hide();
			 $("#wia_filevalidation_error_msg").hide();
         };
	}]);

	/**
	 * upload file rename controller
	 */
	workitemAssistantModule.controller('fileNameModalCtrl', function($scope, entryId, sectionId, close) {
		$scope.filename = '';		
		$scope.filenNameEmpty = function(){
			return ($scope.filename == '');
		};

		$scope.close = function(arg) {
			if(arg == 'save' && $scope.filename != ''){
				var scope = angular.element($("#work_item_assistant_group")).scope();
				var url = scope.getBaseUri(sectionId) +  "fileattachments/filenames?" +  scope.getCommonUrlParams() +"&" +
					$.param({"file_name":$scope.filename, "WI_ASSISTANT_ID": entryId});
				scope.service(url, 'PUT', null, function(results){
					scope.editInProgress = false;
					scope.update();
					ap.consoleInfo("File name has been upated.");
				}, null);
			}
			close('', 300);
		};
	});

	/**
	 * comments or file deletion controller
	 */
	workitemAssistantModule.controller('deleteModalCtrl', function($scope, entryId, sectionType, sectionId, close) {	
		$scope.close = function(arg) {
			if(arg == 'delete'){
				var scope = angular.element($("#work_item_assistant_group")).scope();
				var url = scope.getBaseUri(sectionId);
				if(sectionType == 'fileAttachments'){
					url +=  "fileattachments?" + scope.getCommonUrlParams() + "&" +  $.param({"WI_ASSISTANT_ID": entryId});
				}else{
					url +=  "comments?" + scope.getCommonUrlParams() + "&"+  $.param({"commentId": entryId});	
				}
				scope.service(url, 'DELETE', null, function(results){
					scope.editInProgress = false;
					scope.update();
					ap.consoleInfo("Entry has been deleted.");
				}, null);
			}
			close('', 300);
		};
	});

})();
