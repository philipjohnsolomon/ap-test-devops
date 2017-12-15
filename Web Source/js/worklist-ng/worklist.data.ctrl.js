(function() {

'use strict';

angular.module('ap.worklist.main')

/*
 * This controller is responsible for displaying the data on the worklist for all views (card/tabular).
 * It is currently referenced in cardView.jsp and tabularView.jsp
 */
.controller('ap.worklist.worklistDataCtrl', [ '$log','$modal', '$timeout', '$filter',
                                             'model','WorkListViewSrv', 'WorkItemActionsSrv', 'csrf', 
                      function($log, $modal, $timeout, $filter, model, WorkListViewSrv, WorkItemActionsSrv, csrf) {
	
	$log.log("WorklistDataCtrl is created!!!");
	
	var self = this;
	
	self.workListModel = model;
	
	self.loading = false; 
	
	$log.log(self.workListModel.workItems);
	
	self.messages = [];
	
	self.getLobDesc = function(lobCd){
		var allFilters = self.workListModel.metaData.filters;
		for (var index = 0; index < allFilters.length; ++index) {
			if(allFilters[index].name === 'lobs'){
				for(var lobIdx=0; lobIdx < allFilters[index].filterOptions.length; lobIdx++){
					if(allFilters[index].filterOptions[lobIdx].name == lobCd){
						return allFilters[index].filterOptions[lobIdx].title; 
					}
				}
			}
		}
		return lobCd;
	};
	
	//Upload file handler
	self.initiateUpload = function(){
		self.messages.splice(0, self.messages.length);
		var accountId = WorkListViewSrv.getParameterByName('WORKITEMID');
		ap.turnstileWidget.launchUploadWidget(accountId);
	};
	
	self.isWorkItemSelected = function(workitem){
		return workitem.selected;
	};
	
	self.isLinkedToAccount = function(workitem){
		return (typeof workitem.account_id !== 'undefined' && workitem.account_id != -1);
	};
	
	/*
	 * Service call to get workitem actions
	 */
	self.getWorkItemActions = function(workitem){
		if(workitem.actions && workitem.actions.length>0){
			return;
		}
		WorkItemActionsSrv.getWorkItemActions(workitem.work_item_id,
		function(res){
			workitem.actions = res.data.response.results.actions;
			$log.log("workitem actions retrieved");
			$log.log(res);
		},function(res){
			$log.log("Error retrieving workitem actions");
			$log.log(res);
		});
	};
	
	/*
	 * Call back function to be called when a work item tile or row is selected
	 */
	self.itemSelected = function(selectedWorkItem){
		angular.forEach(self.workListModel.workItems, function(workitem){
			if(workitem.selected == true){
				workitem.selected = false;
			}
		});
		selectedWorkItem.selected = true;
		self.getWorkItemActions(selectedWorkItem);
	};
	/** 
	 * Return true if index is account.
	 */
	self.isAccountsView = function(){
		return angular.equals(self.workListModel.metaData.name, 'AccountsView'); 
	};
	/** 
	 * Return true if workListModel.metaData.name is WorkItemsView.
	 */
	self.isWorkItemsView = function(){
		return angular.equals(self.workListModel.metaData.name, 'WorkItemsView'); 
	};
	/** 
	 * Return true if workListModel.metaData.name is AccountItemsView.
	 */
	self.isAccountItemsView = function(){
		return angular.equals(self.workListModel.metaData.name, 'AccountItemsView'); 
	};
	
	
	/*
	 * Perform the delete workitem/account action.
	 */
	self.deleteWorkItem = function(selectedWorkItem, action){
	    var modalInstance = $modal.open({
	      templateUrl: 'worklist/partials/modals/workitem-deleteWorkitem.mdl.jsp',
	      controller: 'WorkListConfirmationCtrl',
	      resolve: {
	          details: function () {
	        	  return {workitem: selectedWorkItem, isAccount: self.isAccountsView()};
	          }
	        }
	    });

	    modalInstance.result.then(function () {
    		var plsWaitModal =  $modal.open({
	  		      templateUrl: 'worklist/partials/modals/pleasewait.mdl.jsp',
	  		      keyboard: false,
	  		      backdrop: 'static'
	  		    });	    	
	    	WorkItemActionsSrv.executeAction(selectedWorkItem,action,
			function(response){
	    		var timer = $timeout(function(){
	    			WorkListViewSrv.getWorkItems(function(data){
	    				plsWaitModal.dismiss('dismiss');
					});	
	    		},2000);
				
			},function(response){
				$log.log("Failed to complete action of " + action.code + " on workitem.");
			});
			      
	    }, function () {
	      $log.info('Modal dismissed at: ' + new Date());
	    });
	};
	
	self.doApprove = function(selectedWorkItem, action){
		
	    var modalInstance = $modal.open({
	      templateUrl: 'worklist/partials/modals/workitem-approveWorkitem.mdl.jsp',
	      controller: 'WorkListConfirmationCtrl'
	    });

	    modalInstance.result.then(function () {

	    	WorkItemActionsSrv.executeAction(selectedWorkItem,action,
			function(response){
				WorkListViewSrv.getWorkItems(function(){});
			},function(response){
				$log.log("Failed to complete action of " + action.code + " on workitem.");
			});
				
	    }, function () {
	      $log.info('Modal dismissed at: ' + new Date());
	    });
	};

	self.doLinkToAccount = function(selectedWorkItem, action){
		
	    var modalInstance = $modal.open({
	      templateUrl: 'worklist/partials/modals/workitem-linkWorkitem.mdl.jsp',
	      controller: 'WorkItemLinkModalCtrl',
	      resolve: {
	          workitem: function () {
	            return selectedWorkItem;
	          },
	          action: function () {
	            return action;
	          }
	        }
	    });
	    
	    modalInstance.result.then(function (selectedAccount) {
    		var plsWaitModal =  $modal.open({
	  		      templateUrl: 'worklist/partials/modals/pleasewait.mdl.jsp',
	  		      keyboard: false,
	  		      backdrop: 'static'
	  		    });	    	

	    	action.url = action.url + '&TARGET_ACCOUNT=' + selectedAccount.work_item_id;
	    	WorkItemActionsSrv.executeAction(selectedWorkItem,action,
			function(response){
	    		$log.log("Workitem linked to account: " + selectedAccount.work_item_id);
	    		$timeout(function(){
	    			WorkListViewSrv.getWorkItems(function(data){
	    				plsWaitModal.dismiss('dismiss');
						var successMsgModalInstance = $modal.open({
						      templateUrl: 'worklist/partials/modals/workitem-success.mdl.jsp',
						      controller: 'WorkListSuccessCtrl',
						      resolve: {
						    	  response: function () {
						            return response.data.response.results;
						          }
						        }
						    });	    				
					});	
	    		},2000);
			},function(response){
				$log.log("Failed to complete action of " + action.code + " on workitem.");
			});
				
	    }, function () {
	      $log.info('Modal dismissed at: ' + new Date());
	    });
	};

	self.doMoveToAccount = function(selectedWorkItem, action){
		
	    var modalInstance = $modal.open({
	      templateUrl: 'worklist/partials/modals/workitem-moveWorkitem.mdl.jsp',
	      controller: 'WorkItemMoveModalCtrl',
	      resolve: {
	          workitem: function () {
	            return selectedWorkItem;
	          }
	        }
	    });
	    
	    modalInstance.result.then(function (selectedAccount) {
    		var plsWaitModal =  $modal.open({
	  		      templateUrl: 'worklist/partials/modals/pleasewait.mdl.jsp',
	  		      keyboard: false,
	  		      backdrop: 'static'
	  		    });	    	

	    	action.url = action.url + '&TARGET_ACCOUNT=' + selectedAccount.work_item_id;
	    	WorkItemActionsSrv.executeAction(selectedWorkItem,action,
			function(response){
	    		$log.log("Workitem linked to account: " + selectedAccount.work_item_id);
	    		var timer = $timeout(function(){
	    			WorkListViewSrv.getWorkItems(function(data){
	    				plsWaitModal.dismiss('dismiss');
						$modal.open({
						      templateUrl: 'worklist/partials/modals/workitem-moveWorkToAccountSuccess.mdl.jsp',
						      controller: 'WorkListSuccessCtrl',
						      resolve: {
						    	  response: function () {
						            return response.data.response;
						          }
						        }
						    });	    				
					});	
	    		},2000);
			},function(response){
				$log.log("Failed to complete action of " + action.code + " on workitem.");
			});
				
	    }, function () {
	      $log.info('Modal dismissed at: ' + new Date());
	    });
	};
	
	self.pageChanged = function(){
		$log.log("Changing page " + self.workListModel.pagination.currentPage);
		angular.forEach(self.workListModel.metaData.listViews,function(view){
			if(view.selected == true){
				view.startRowNumber = (self.workListModel.pagination.currentPage * self.workListModel.pagination.fetchSize) - self.workListModel.pagination.fetchSize;
			}
		});
		var currentPage = self.workListModel.pagination.currentPage;
		WorkListViewSrv.getWorkItems(function(){
			self.workListModel.pagination.currentPage = currentPage;
			$log.log(self.workListModel.pagination);
		});
	};	
	/*
	 * Call back function called when a action is selected on the title or row
	 */
	self.performAction = function(selectedWorkItem, action){
		self.messages.splice(0, self.messages.length);
		$log.log('perform action: ' + action.code);
		if(action.code == "Open" || action.code == 'View') {
			window.location = action.url + '&' + $.param(csrf);
		}
		else if (action.code == 'Endorse') {
			window.location = action.url + '&TRANSACTION_NAME='+ action.endorseTransactionId + '&' + $.param(csrf);
		}else if (action.code == 'Copy' || action.code == 'Claim' || action.code == 'Requote' || action.code == 'Withdraw') {
			var plsWaitModal = $modal.open({
				templateUrl: 'worklist/partials/modals/pleasewait.mdl.jsp',
				keyboard: false,
				backdrop: 'static'
			});
			
			WorkItemActionsSrv.executeAction(selectedWorkItem,action,
					function(response){
						plsWaitModal.dismiss('dismiss');	
						if(response.data.response[0].error){
							$log.log("Failed to complete action of " + action.code + " on workitem.");											
							self.messages.push(response.data.response[0].error);
						}else{
							var newWorkItemId = response.data.response[0].newWorkItemId;
							var openMode = response.data.response[0].openMode;
							var openAction = null;
							angular.forEach(selectedWorkItem.actions,function(each){
								if(each.code == 'Open'){
									return openAction = each;
								}
							});
							if(openAction != null){
								var openUrl = openAction.url;
								openUrl = openUrl.replace(selectedWorkItem.work_item_id,newWorkItemId);
								window.location = openUrl + "&openmode=" + openMode + '&' + $.param(csrf);
							}else{
								$log.log("Unable to launch the newly created workitem: " + newWorkItemId);
								self.messages.push("Unable to launch the newly created workitem: " + newWorkItemId);					
							}
						}
					},function(response){
						$log.log("Failed to complete action of " + action.code + " on workitem. Error: " + response);
						plsWaitModal.dismiss('dismiss');		
						self.messages.push("Failed to complete action of " + action.code + " on workitem. Error: " + response);	
					});
		}else if(action.code == 'Delete'){
			self.deleteWorkItem(selectedWorkItem,action);
		}else if(action.code == 'Link'){
			self.doLinkToAccount(selectedWorkItem,action);
		}else if(action.code == 'Move'){
			self.doMoveToAccount(selectedWorkItem,action);
		}else{
			this.performCustomAction(selectedWorkItem,action);
		}
		
	};
	
	
	self.performCustomAction = function(selectedWorkItem,action){
		$log.log("You should not be seeing this message in the logs. This method should have been overriden for the custom action :" + action.code);
	};
	
	self.createWorkItem = function(href){
		if('upload' === href){
			self.initiateUpload();
		}else{
			var plsWaitModal = $modal.open({
				templateUrl: 'worklist/partials/modals/pleasewait.mdl.jsp',
				keyboard: false,
				backdrop: 'static'
			});

			self.messages.splice(0, self.messages.length);
			if(self.isAccountItemsView()) {
				var action = {};
				action.url = href;
				action.code = "Copy";
				WorkItemActionsSrv.executeAction({},action, function(response){
					if(response.data.response[0].error){
						$log.log("Failed to complete action of " + action.code + " on workitem.");
						plsWaitModal.dismiss('dismiss');						
						self.messages.push(response.data.response[0].error);
					}else{
						var url = response.data.response[0].url;
						plsWaitModal.dismiss('dismiss');
						window.location = url;
					}
				},function(response){
					$log.log("Failed to complete action of " + action.code + " on workitem.");
					plsWaitModal.dismiss('dismiss');
				});
			}else {
				window.location = href;
			}		
		}
	};
	self.saveSearch = function(responseHandler){
		WorkListViewSrv.saveSearch(null,function(data){
			$log.log("saved search " + self.savedSearchName);
			self.savedSearchName = ""; //reset the name after its been saved.
			if(angular.isFunction(responseHandler)){
				responseHandler(data);
			}
		});
	};
	
	/*
	 * These methods are related to tabular view
	 */	
	self.lookupValue = function(field, workitem){
		var val = workitem[field.id];
		var newVal = WorkListViewSrv.lookupValue(field.id,val); //lookup using field id
		if(val == newVal){
			val = WorkListViewSrv.lookupValue(field.type,val); //lookup using field type
		}else{
			val = newVal;
		}
		if(field.format){
			try{
				var filtersToApply = [];
				if(field.format.indexOf('|')){
					filtersToApply = field.format.split('|');
				}else{
					filtersToApply = field.format;
				}
				
				for(var ix=0; ix<filtersToApply.length; ix++){
					var formatVal =  filtersToApply[ix];
					if(formatVal.indexOf(': ')>-1){ //multiple arguments to the filter. e.g. current : '$'
						var tokens = formatVal.split(': ');
						for(var i=0; i<tokens.length; i++){ //remove any extra ' character
							tokens[i] = tokens[i].replace(/'/g, "");
						}
						val = $filter(tokens[0].trim())(val, tokens.slice(1));
					}else{
						val = $filter(formatVal)(val);					
					}
				}
			}catch(error){
				console.log('Unsupported format error: ' + error);
			}
		}
		return val;
	};
	
	/*
	 * Get the table columns to display based on the listview configuration.
	 * Make the fields as sortable based on sortinfo configuraiton 
	 */
	self.getTableColumns = function(){
		var views = self.workListModel.metaData.listViews;
		
		for (var index = 0; index < views.length; ++index) {
			if(views[index].type == 'TABULAR'){
				angular.forEach(views[index].fields,function(listField){
					angular.forEach(self.workListModel.metaData.sortInfo.sortOptions,function(sortField){
						if(sortField.relatedFieldId == listField.id){
							listField.isSortable = true;
						}
					});
				});
				return views[index].fields;
			}
		}
		return [];
	};
	
	self.toggleSort = function(listField){
		angular.forEach(self.workListModel.metaData.sortInfo.sortOptions,function(sortField){
			if(sortField.relatedFieldId == listField.id){
				sortField.selected = true;
				sortField.ascending = !sortField.ascending;
			}else{
				sortField.ascending = false;
				sortField.selected = false;
			}
		});
		//Save search criteria and get workitems
		if(self.workListModel.metaData.isSaveable == true){
			self.workListModel.metaData.savedSearchInfo.currentSearch.id = -1;
			self.workListModel.metaData.savedSearchInfo.currentSearch.name = null;
			self.saveSearch(WorkListViewSrv.getWorkItems);
		}else{
			WorkListViewSrv.getWorkItems(function(){
				$log.log("retrieved workitems");
			});
		}
		
	};
		 
	self.getSortDirection = function(listField){
		var className = '';
		angular.forEach(self.workListModel.metaData.sortInfo.sortOptions,function(sortField){
			if(sortField.relatedFieldId == listField.id){
				className = sortField.selected?'active':'';
				if(sortField.ascending){
					className = className + ' asc';
				}else{
					className = className + ' desc';
				}

			}
		});
		return className;
	};
	
	self.performDoubleClick = function(workitem){
		if(workitem.actions && workitem.actions.length>0){
			var openAction = null;
			angular.forEach(workitem.actions,function(each){
				if(each.code == 'Open'){
					openAction = each;
				}
			});
			if(openAction != null){
				window.location = openAction.url;
				return;
			}
		}
		
		self.getWorkItemActions(workitem);						
	};
}]);

})();