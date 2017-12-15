(function() {
'use strict';

	angular.module('ap.worklist.workListViewServices', ['ngResource','ap.common.constants'])

	/*
	 *Model defined as a service so it can shared by all the components 
	 */
	.service('model', [function WorklistModel(){
		var model = this;
		model.metaData = {};
		model.workItems = {};
		model.pagination = {};
		model.cleanMetaData = {
				worklist_metaData: {},
				account_metaData: {}
		};
		model.lookuplist = {};
		model.loading = false;
		
	}])
	
	/*
	 * This service is responsible for all the rest call to the worklist api
	 * model is the model service which is the container for model objects
	 * contextPath is the constant for the contextpath defined in ap.common.constants
	 * csrfobject is json object containing CSRF TOKEN key and value. Defined in ap.common.constants
	 */
	.service('WorkListViewSrv', ['model','$resource', '$filter', 'contextPath','csrfObject', '$log', 
	                             	function(model, $resource, $filter, contextPath, csrfObject, $log){
		$log.log('created WorkListViewSrv');
		var self = this;

		/*
		 * This is map containing parameter values to be used for REST calls keyed by worklist urls
		 */
		self.urls = {
				WorkItemsView: {listId: 'WorkItemsView', worklistType: 'workitems'  },
				AccountItemsView: {listId: 'AccountItemsView', worklistType: 'workitems'  },
				AccountsView: {listId: 'AccountsView', worklistType: 'accounts' },
				worklist: {listId: 'WorkItemsView', worklistType: 'workitems'  },
				account: {listId: 'AccountsView', worklistType: 'accounts' }
		};
		
		/*
		 * Parameters map used in by the rest calls 
		 */
		var wlResParams = { worklistType:'@worklistType', listId: '@listId', views: 'views', csrftokenname: '@csrftokenname', 
							csrftoken: '@csrftoken', saved_search_id: 'saved_search_id', searchName: '@searchName'};
		
		/*
		 * WorklistResources definition 
		 */
		self.worklistResource = 
		 $resource(contextPath + '/api/worklists/:worklistType/:views/:listId?:csrftokenname=:csrftoken&:saved_search_id=:searchName' , {},{
			getmetadata: {method:'GET', params: wlResParams, isArray:false, headers: { Accept: 'application/json' } },
			query: {method:'POST', params: wlResParams, isArray:false, headers: { Accept: 'application/json', 'Content-Type': 'application/json' }},
			save: {method:'PUT', params: wlResParams, isArray:false, headers: { Accept: 'application/json', 'Content-Type': 'application/json' }},
			remove: {method:'DELETE', params: wlResParams, isArray:false, headers: { Accept: 'application/json', 'Content-Type': 'application/json' }}
		});

		/*
		 * NewWorkitem Links Resource definition
		 */
		self.newWorkItemLinksResource = 
			 $resource(contextPath + '/api/lookups/basic/NewWorkItemLink?:csrftokenname=:csrftoken',{},{
				query: {method:'GET', params: { work_item_type:'@worklistType', csrftokenname: '@csrftokenname', csrftoken: '@csrftoken'}, isArray:false, headers: { Accept: 'application/json' }}
		});

		
		/*
		 * Set csrf token value after each service call.
		 */
		self.setCSRFToken = function(headers){
			csrfObject.csrftokenValue = headers(csrfObject.csrftokenName);
			csrfObject.tokenobj[csrfObject.csrftokenName] = csrfObject.csrftokenValue;
		};

		/*
		 * Retrieve lookup lists for the lookup url in the metadata
		 */
		self.retrieveLookupList = function(lookupLinks,paramsObj){
			angular.forEach(lookupLinks,function(link){
				var realmComponentArray = link.rel.split(".");
				var type = realmComponentArray[realmComponentArray.length-1];
				var params = {};
				if(paramsObj){
					params = angular.extend(paramsObj,csrfObject.tokenobj);
				}else{
					var worklistType = self.getParameterByName('WorkListType');
					params = angular.extend(self.urls[worklistType],csrfObject.tokenobj);
				}
				$resource(contextPath + link.href,params,{
					get: {method:'GET', headers: { Accept: 'application/json' }}
				})
				.get(function(data,headers){
					self.setCSRFToken(headers);
					model.lookuplist[type] = data.response.results.codeList.codes;
				});					
			});
		};
		
		/*
		 * Get title/description for given code and list type
		 */
		self.lookupValue = function(type,code){
			var retVal = code;
			angular.forEach(model.lookuplist[$filter('uppercase')(type)],function(option){
				if(option.value == code){
					retVal = option.title;
				}
			});
			return retVal;
		};
		
		/*
		 * Get the content for advanced search using the url in the metadata
		 */
		self.getAdvancedSearch = function(){
			var queryInfoLinks = model.metaData.queryInfo.links;
			var dialogResUrl = null;
			angular.forEach(queryInfoLinks, function(link) {
				if(link.rel == 'dialog-resource'){
					dialogResUrl = link.href;
				}
			 });
			if(dialogResUrl != null){
				var getList = function(){
					
					$log.log("Getting optionslist for advanced search operators");
					angular.forEach(model.metaData.queryInfo.pages[0].sections[0].fields,function(field){
						if(field.type == 'selectlist'){
							if(field.name == 'operator'){
								var effDtField = $filter('filter')(model.metaData.queryInfo.pages[0].sections[0].fields, {type: 'date'});
								if(effDtField.length){
									effDtField[0].selectedOperator = field.defaultValue;
								}
							}
									
							angular.forEach(field.optionLists,function(optionlist){
								$log.log('query operators= ' + optionlist.link.href);
								$resource(contextPath + optionlist.link.href,csrfObject.tokenobj,{
									get: {method:'GET', headers: { Accept: 'application/json' }}
								})
								.get(function(data,headers){
									self.setCSRFToken(headers);
									field.options = data.response.results.optionList.optionEntries;
									field.selectedOption = field.defaultValue;
									$log.log(field);
								},function(data){
									$log.log('Unable to retrieve valid meta data for worklist : ' + data);
								});
							});
						}
					})
				};
				$log.log('query page = ' + dialogResUrl);
				$resource(contextPath + dialogResUrl,csrfObject.tokenobj,{
					get: {method:'GET', headers: { Accept: 'application/json' }}
				})
				.get(function(data,headers){
					self.setCSRFToken(headers);
					queryInfoLinks.content = {};
					queryInfoLinks.content.pageId = model.metaData.queryInfo.pageId;
					model.metaData.queryInfo.pages = [];
					model.metaData.queryInfo.pages.push(data.response.results.page);
					$log.log(model.metaData.queryInfo);
					getList();
				},function(data){
					$log.log('Unable to retrieve valid meta data for worklist : ' + data);
				});
			}
		};
		
		/*
		 * Save search options selected this far.
		 */
		self.saveSearch = function(searchName, resHandler){
				
			var type = self.getParameterByName('WorkListType');
			var searNameParam = -1;
			if(searchName != null){
				searNameParam = searchName;
			}
			var par = angular.extend({csrftokenname: csrfObject.csrftokenName, csrftoken: csrfObject.csrftokenValue, searchName : searNameParam},self.urls[type],model.metaData);
			$log.log(par);
			self.worklistResource.save(par, function(data,headers){
				if (data.response.status === 0) {
					self.setCSRFToken(headers);
					if(angular.isFunction(resHandler)){
						resHandler(data);
					}
		        } else {
		        	$log.log('Unable to retrieve valid meta data for worklist : ' + data.response.message);
		        }
			});
		};
		
		/*
		 * Delete the selected search entry selected
		 */
		self.deleteSearch = function(searchId, resHandler){
			var worklistType = self.getParameterByName('WorkListType');
			var par = angular.extend({csrftokenname: csrfObject.csrftokenName, 
				csrftoken: csrfObject.csrftokenValue, searchName : searchId},self.urls[worklistType]);

			self.worklistResource.remove(par,function(data,headers){
				 self.setCSRFToken(headers);
				 if(angular.isFunction(resHandler)){
					 resHandler();
				 }
			},function(data){
				$log.log('Unable to delete saved search : ' + data);
			});
		};
		
		/*
		 * Get metadata for the worklist view based on the URL path param
		 */
		self.getMetaData = function(worklistType, searchName, resHandler){
			var searNameParam = searchName;
			if(searchName == null){
				searNameParam = searchName;
			}
			var par = angular.extend({csrftokenname: csrfObject.csrftokenName, 
								csrftoken: csrfObject.csrftokenValue, searchName : searNameParam},self.urls[worklistType]);
			
			self.worklistResource.getmetadata(par,function(data,headers){
				 self.setCSRFToken(headers);
				 model.metaData = data.response.results.workListView;
				 angular.forEach(model.metaData.listViews,function(view){
					if(view.selected == true){
						model.pagination.viewPortSize = view.viewPortSize;
						model.pagination.startRowNumber = view.startRowNumber;
						model.pagination.fetchSize = view.fetchSize;
					} 
				 });
				 
				 self.getNewWorkItemLinks(worklistType);
				 self.getAdvancedSearch();
				 if(angular.isFunction(resHandler)){
					 resHandler();
				 }
				},function(data){
					$log.log('Unable to retrieve valid meta data for worklist : ' + data);
					$log.log(data);
			});
		};
		
		/*
		 * Function that performs the search initiated from modal dialog
		 */
		self.performModalSearch = function(indexType, searchValue, accountIdToExclude, callback){
			var metaDataCopy = angular.copy(model.cleanMetaData[indexType +'_metaData']);
			var searchField = null;
			var workItemField = null;
			angular.forEach(metaDataCopy.queryInfo.queryFields, function(queryField){
				if(queryField.relatedFieldId == 'entity_name'){
					searchField = queryField;
				}else if(queryField.relatedFieldId == 'work_item_id'){
					workItemField = queryField;
				}
				
			});
			
			//set the search value to query field
			if(searchValue.length == 0){
				searchField.operands[0] = '*';
			}else{
				searchField.operands[0] = searchValue;
			}
			
			//set the account id to be excluded
			if(accountIdToExclude != null && typeof accountIdToExclude !== 'undefined'){
				workItemField.opCode = 'NOT_EQUAL';
				workItemField.operands[0] = accountIdToExclude;
				workItemField.selected = true;
			}
			
			var par = angular.extend({},self.urls[indexType],{csrftokenname: csrfObject.csrftokenName, csrftoken: csrfObject.csrftokenValue},metaDataCopy);
			$log.log(par);
			self.worklistResource.query(par, function(data){
				if (data.response.status === 0) {
					$log.log("fetched workitems. count: " + data.response.results.docs.length);
					callback(data);
		        } else {
		        	$log.log('Unable to retrieve valid meta data for worklist : ' + data.response.message);
		        }
			});			
		};
		
		
		
		/*
		 * Search for accounts or workitems 
		 */
		self.searchEntities = function(indexType, searchValue,accountIdToExclude, callback){
			if(searchValue.length > 0 && searchValue.length < 3){
				return; //no ops. we search only when 3 chars are entered
			}
			 //make a copy that can used for search modals.
			 //We should save a clean copy before user makes changes
			if(model.cleanMetaData[model.metaData.index +'_metaData'].index != indexType){
				var par = angular.extend({csrftokenname: csrfObject.csrftokenName, csrftoken: csrfObject.csrftokenValue},self.urls[indexType]);
				self.worklistResource.getmetadata(par,function(data,headers){
					 self.setCSRFToken(headers);
					 model.cleanMetaData[indexType +'_metaData'] = data.response.results.workListView;
					 $log.log(model.cleanMetaData[indexType +'_metaData']);
					 return self.performModalSearch(indexType, searchValue,accountIdToExclude, callback);
					},function(data){
					$log.log('Unable to retrieve valid meta data for worklist : ' + data);
				});
			}else{
				return self.performModalSearch(indexType, searchValue,accountIdToExclude, callback);
			}
			 
		};
		
		/*
		 * Get workitems based on the search options selected
		 */
		self.getWorkItems = function(resHandler){
			var type = self.getParameterByName('WorkListType');
			var par = angular.extend({csrftokenname: csrfObject.csrftokenName, csrftoken: csrfObject.csrftokenValue},self.urls[type],model.metaData);
			$log.log(par);
			self.worklistResource.query(par, function(data,headers){
				if (data.response.status === 0) {
					$log.log("fetched workitem ");
					self.setCSRFToken(headers);
					model.workItems = data.response.results.docs;
					model.pagination.startRowNumber = data.response.results.start;
					model.pagination.total = data.response.results.hits;
					model.pagination.currentPage = 1;
					$log.log(model.workItems);
					$log.log(model.pagination);
					if(angular.isFunction(resHandler)){
						resHandler(data);
					}
		        } else {
		        	$log.log('Unable to retrieve valid meta data for worklist : ' + data.response.message);
		        }
			});
		};
		
		/*
		 * Get workitem links for the worklist type (workitem/account)
		 */
		self.getNewWorkItemLinks = function(worklistType){
			var wid = self.getParameterByName('WORKITEMID');
			var par = angular.extend({csrftokenname: csrfObject.csrftokenName, csrftoken: csrfObject.csrftokenValue},self.urls[worklistType]);
			if(wid.length > 0){
				par["WORKITEMID"] = wid;
			}
			self.newWorkItemLinksResource.query(par,function(data,headers){
				 self.setCSRFToken(headers);
				 model.metaData.newWorkItemLinks = data.response.results.codeList.codes;
				 $log.log("New Workitem links");
				 $log.log(model.metaData.newWorkItemLinks);
				},function(data){
				$log.log('Unable to retrieve valid meta data for worklist : ' + data);
			});			
		};
		
		/*
		 * Utility function used to parse the path param
		 */
		self.getParameterByName = function(name) {
		    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		        results = regex.exec(location.search);
		    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
		};
		
	}]);
	
})();