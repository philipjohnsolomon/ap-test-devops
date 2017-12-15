(function() {

'use strict';

angular.module('ap.worklist.main', ['ngRoute', 'ui.bootstrap', 'ap.worklist.workListViewServices','ap.common.constants'])

.config([ '$routeProvider', function($routeProvider) {
  //$log.log('Created ap.worklist.main:config');
  $routeProvider.when('/CARD', {
    templateUrl: 'worklist/partials/cardView.jsp',
    reloadOnSearch: false
  })
  .when('/TABULAR',{
	  templateUrl:'worklist/partials/tabularView.jsp',
	  reloadOnSearch: false
  })
  .otherwise({redirectTo: '/CARD'});
  
 }

])

/*
 * ap.worklist.worklistViewCtrl is first controller that paints the worklist.
 * It initiates query for worklist meta data
 * Paints the worklist search options
 */
.controller('ap.worklist.worklistViewCtrl', ['$filter','$location', '$modal', 'WorkListViewSrv','model', '$log', 'dateFormat',
                                             	function($filter, $location, $modal, WorkListViewSrv,model, $log, dateFormat) {
	$log.log('created ap.worklist.worklistViewCtrl:controller');
	var self = this;
	
	self.workListModel = model;
	self.advancedDropDown = {isopen: false};
	self.sortByStatus = {isOpen: false };
	self.searchValue = ""; 
	self.searchField = {};
	self.savedSearchName = null;
	self.currentSearchName = -1;


	/*
	 * Performs any initial setup needed after the meta-data is retrieved.
	 * This function is called after the initial meta for worklist is retrieved
	 * initView will setup any state default values for painting the UI
	 * @param data is the response object from the getMetaData Service call.
	 */
	self.initView = function(data){
		angular.forEach(self.workListModel.metaData.listViews, function(listview){
			$log.log('List view '+ listview.type + ", selected: " + listview.selected);
			if(listview.selected == true){
				$log.log('redirecting to: ' + listview.type);
				$location.path('/' + listview.type);
			}
		});
		
		var allFilters = self.workListModel.metaData.filters;
		var status = WorkListViewSrv.getParameterByName('status');
		//If the request has originated from the quote boxes.
		//We need to clear all filters and set the status to status on request
		if(status != null && status.length > 0 && angular.equals(self.workListModel.workItems, {})){
			
			//Clear all filters
			var allFilters = self.workListModel.metaData.filters;
			
			angular.forEach(allFilters, function(each){
				angular.forEach(each.filterOptions,function(filterOption){
					filterOption.selected = false;
				});
			});
			//reset the query fields
			angular.forEach(self.workListModel.metaData.queryInfo.queryFields, function(each){
				if(each.interactive == true){
					each.selected = false;
				}
			});
	
			//set the status filter to whats on the request
			angular.forEach(allFilters, function(each){
			if(each.type == 'STATUS'){
				angular.forEach(each.filterOptions,function(option){
					if(option.value == status){
						option.selected = true;
					}else{
						option.selected = false;
					}
				});
				}
			});
		}		
		
		WorkListViewSrv.retrieveLookupList(self.workListModel.metaData.lookupLinks,null);
		
		$log.log(self.workListModel);

		//If this is a worklist under an account, we only display workitem associated with that account.
		//Set the account filter
		var accountId = WorkListViewSrv.getParameterByName('WORKITEMID');
		angular.forEach(self.workListModel.metaData.queryInfo.queryFields, function(queryField){
			if(queryField.relatedFieldId == 'entity_name'){
				//identify the search field for later use.
				self.searchField = queryField;
			}else if(queryField.relatedFieldId == 'account_id' && accountId.length > 0){
				queryField.selected = true;
				queryField.operands[0] = accountId;
				queryField.opCode = "EQUALS";
			}
		});
	
		//Fetch the workitems using the meta-data
		self.fetchWorkItems();
		$log.log("WorkItems");
		$log.log(self.workListModel.workItems);
	};
	
	
	/*
	 *Get the meta for the worklist being painted based on the parameter WorkListType 
	 */
	self.getMetaData = function(searchName){
		var workListType = WorkListViewSrv.getParameterByName('WorkListType');
		var searchNameParam = -1;
		if(searchName){
			searchNameParam = searchName;
		}
		WorkListViewSrv.getMetaData(workListType, searchNameParam, self.initView);		
	};
	
	/*
	 * Get information required to paint links for new workitems
	 */
	self.getNewWorkItemLinks = function(){
		WorkListViewSrv.getNewWorkItemLinks();
	};
	
	//Fectch the workitem with the meta data
	//The function is called when user changes any filters,search criteria
	//as well for the initial data load.
	self.fetchWorkItems = function(){
		if(self.searchValue.length > 0 && self.searchValue.length < 3){
			return;
		}
		self.searchField.selected = true;
		if(self.searchValue.length == 0){
			self.searchField.operands[0] = '*';
		}else{
			self.searchField.operands[0] = self.searchValue;
		}
		
		self.clearPagination();
		
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
	
	
	/*
	 * Set the query parameters in the meta data for advanced query fields.
	 * This is called when search button on more options is clicked.
	 * @param pageField is the adv. search field selected on the UI
	 */
	self.setAdvQueryField = function(pageField){
		angular.forEach(self.workListModel.metaData.queryInfo.queryFields, function(queryField){
			if(queryField.pageFieldId == pageField.name){
				if(pageField.type == 'date'){
					if(pageField.selectedOperator){
						queryField.opCode = pageField.selectedOperator;
					}else{
						queryField.opCode = null;
					}
					
					 if(pageField.startDate){
						 queryField.operands[0] = $filter('date')(pageField.startDate, dateFormat);
						 queryField.selected = true;
					 }
					 if(pageField.selectedOperator == 'BETWEEN'){
						 queryField.operands[1] = $filter('date')(pageField.endDate, dateFormat);
						 queryField.selected = true;						 
					 }else{
						 if(queryField.operands.length > 1){
							 queryField.operands = queryField.operands.splice(1,1);
						 }
					 }
				 }else if(pageField.type == 'selectlist' && pageField.selectedOption){
					 queryField.operands[0] = pageField.selectedOption;
					 queryField.opCode = "EQUALS";
					 queryField.selected = true;
				 }else if(pageField.value){
					 queryField.operands[0] = pageField.value;
					 queryField.opCode = "EQUALS";
					 queryField.selected = true;
				 }else{
					 if(queryField.interactive == true){
						 queryField.selected = false;
					 }
				 }
				return;
			}
		});
	};

	/*
	 * Validate more options search input.
	 * This function validates date fields based on the date operator  
	 */
	self.validateAdvSearch = function(){
		$log.log("Validating adv search");
		self.invalidAdvSearch = false;
		angular.forEach(self.workListModel.metaData.queryInfo.queryFields, function(queryField){
			if(queryField.selected && queryField.dataType == 'DATE'){
				
				if(queryField.opCode == 'BETWEEN' && queryField.operands.length < 2){
					self.invalidAdvSearch = true;
				}else if(queryField.opCode == null && queryField.operands.length > 0){
					self.invalidAdvSearch = true;
				}else if(queryField.opCode != null && queryField.operands.length == 0){
					self.invalidAdvSearch = true;
				}
			}
		});
		
		return self.invalidAdvSearch;
	};
	
	/*
	 * Gets workitems for the selected adv search criteria.
	 * Called when the user clicked search on the more options
	 */
	self.advanceSearchClicked = function(){
		$log.log("perform adv search");
		angular.forEach(self.workListModel.metaData.queryInfo.pages[0].sections[0].fields, function(pageField){
			self.setAdvQueryField(pageField);
		});
		
		self.validateAdvSearch();
		
		if(!self.invalidAdvSearch){
			self.advancedDropDown.isopen = false;
			self.fetchWorkItems();
		}else{
			$log.log("Invalid advanced search!!!");
		}
	};
	
	/*
	 * Save the currently selected search criteria against entered search name
	 */
	self.saveSearchClicked = function(){
		self.saveError = false;
		if(self.savedSearchName.length == 0){
			self.saveError = true;
			return;
		}
		angular.forEach(self.workListModel.metaData.queryInfo.pages[0].sections[0].fields, function(pageField){
			self.setAdvQueryField(pageField);
		});
		
		self.validateAdvSearch();
		if(!self.invalidAdvSearch){
			self.advancedDropDown.isopen = false;
			self.workListModel.metaData.savedSearchInfo.currentSearch.id = -1;
			self.workListModel.metaData.savedSearchInfo.currentSearch.name = self.savedSearchName;
			
			var callBackFn = function(data){
				var currSearch = data.response.results.workListView.savedSearchInfo.currentSearch;
				return self.retriveSavedSearch(currSearch);
			};
			self.saveSearch(callBackFn);
		}else{
			$log.log("Invalid advanced search!!!");
		}
	};
	
	/*
	 * Call the WorklistService to execute save search
	 * @param responseHandler is the success callback handler 
	 */
	self.saveSearch = function(responseHandler){
		WorkListViewSrv.saveSearch(null,function(data){
			$log.log("saved search " + self.savedSearchName);
			//reset the name after its been saved.
			self.savedSearchName = "";
			if(angular.isFunction(responseHandler)){
				responseHandler(data);
			}
		});
	};
	
	/*
	 * Retrieve meta data/search criteria for selected search name
	 */
	self.retriveSavedSearch = function(savedSearch){
		self.workListModel.metaData.savedSearchInfo.currentSearch.id = savedSearch.id;
		self.workListModel.metaData.savedSearchInfo.currentSearch.name = savedSearch.name;		
		self.getMetaData(savedSearch.id);
	};
	
	/*
	 * Delete the selected search name and corresponding search criteria
	 */
	self.deleteSavedSearch = function(savedSearch){
		var modalInstance = $modal.open({
		      templateUrl: 'worklist/partials/modals/saved-filter-delete.mdl.jsp',
		      controller: 'SavedFilterDeleteCtrl',
		      resolve: {
		    	  savedSearch: function () {
		            return savedSearch.id;
		          },
		          getMetaData : function(){
		        	  return self.getMetaData;
		          },
		          WorkListViewSrv : function(){
		        	  return WorkListViewSrv;
		          }
		        }
		    });				
	};
	
	/*
	 * Get lob filteroption for display on the UI
	 */
	self.getLOBs = function(){
		var allFilters = self.workListModel.metaData.filters;
		var lobsArray = [];
		for (var index = 0; index < allFilters.length; ++index) {
			if(allFilters[index].name === 'lobs'){
				lobsArray.push(allFilters[index].filterOptions);
			}
		}
		return lobsArray;
	};
	
	/*
	 * Get queryField json object that corresponds to entity_name search field
	 */
	self.getEntityNameModel = function(){
		var fields = self.workListModel.metaData.queryInfo.queryFields;
		for(var ix=0; ix<fields.length; ix++){
			if(fields[ix].relatedFieldId == "entity_name"){
				return fields[ix].operands[0];
			}
		}
		return "";
	};

	/*
	 * This function is called by the filter drop down when they are clicked.
	 * The status of dropdown is toggled on model object
	 */
	self.selectFilter = function(object) {
		object.selected = true;
		self.fetchWorkItems();
	 };

	/*
	 * Unselect the filter option selected. This is called when 'x' is clicked on the filter bread crumbs
	 * Clear the pagination before making a server side call to get new set of workitems.
	 */
	self.clearSelected = function(object) {
		object.selected = false;
		if(object.relatedFieldId == 'entity_name'){
			self.searchValue = "";
		}
		self.fetchWorkItems();
	};
		
	/*
	 * Clear all filters. This function is called when user click on "clear all" link.
	 * Clears the selected filter and makes a call to retrieve data for default selections 
	 */
	 self.clearFilters = function(){
		var allFilters = self.workListModel.metaData.filters;
		
		angular.forEach(allFilters, function(each){
			angular.forEach(each.filterOptions,function(filterOption){
				filterOption.selected = false;
			});
		});
		//reset the query fields except entity name search
		angular.forEach(self.workListModel.metaData.queryInfo.queryFields, function(each){
			if(each.interactive == true && each.isSaveable == true){
				each.selected = false;
			}
		});
		angular.forEach(self.workListModel.metaData.sortInfo.sortOptions, function(sortOpt){
			sortOpt.selected = false;
		});

		$log.log("Cleared all ");
		$log.log(self.workListModel.metaData.queryInfo.queryFields);
		self.savedSearchName = null;
		if(self.workListModel.metaData.isSaveable == true){
			self.saveSearch(function(data){
				self.getMetaData();
			});			 
		}else{
			self.getMetaData();
		}
	 };
	 
	 /*
	  * Clear the current pagination information.
	  * This is called when query,filter options have changes resulting in a call to get new set of workitems
	  */
	 self.clearPagination = function(){
		self.workListModel.pagination.startRowNumber = 0;
		self.workListModel.pagination.currentPage = 1;
		angular.forEach(self.workListModel.metaData.listViews,function(view){
			if(view.selected == true){
				self.workListModel.pagination.viewPortSize = view.viewPortSize;
				view.startRowNumber = 0;
				self.workListModel.pagination.fetchSize = view.fetchSize;
			}
		});
	 };
	 
	 /*
	  * Get the filters that have 'selected' set to true
	  * Utility function used by UI
	  */
	 self.getSelectedFilters = function(){
		var allFilters = self.workListModel.metaData.filters;
		var selectedFilters = [];
		if(!allFilters){
			return selectedFilters;
		}
		for (var index = 0; index < allFilters.length; ++index) {
			for(var ix =0; ix<allFilters[index].filterOptions.length; ix++){
				if(allFilters[index].filterOptions[ix].selected == true){
					selectedFilters.push(allFilters[index].filterOptions[ix]);
				}
			}
		}
		return selectedFilters;
	 };

	 /*
	  * Get the sort options that have 'selected' set to true
	  * Utility function used by UI
	  */
	 self.getSelectedSorts = function(){
		var selectedSorts = [];
		var sorts = self.workListModel.metaData.sortInfo;
		if(!sorts){
			return selectedSorts;
		}
		for (var index = 0; index < sorts.sortOptions.length; ++index) {
			if(sorts.sortOptions[index].selected == true){
				selectedSorts.push(sorts.sortOptions[index]);
			}
		}
		return selectedSorts;
	 };
	 
	 /*
	  * set the selected value to true for the sort option based in
	  * Utility function used by UI
	  */
	 self.selectSortOption = function(sortOption){
		var sorts = self.workListModel.metaData.sortInfo;
		for (var index = 0; index < sorts.sortOptions.length; ++index) {
			if(sorts.sortOptions[index].relatedFieldId == sortOption.relatedFieldId && sorts.sortOptions[index].selected == true){
				sorts.sortOptions[index].ascending = !sorts.sortOptions[index].ascending;
				sorts.sortOptions[index].selected = true;
			}else{
				sorts.sortOptions[index].ascending = false;
				sorts.sortOptions[index].selected = false;
			}
			sortOption.selected = true;
		}
		self.fetchWorkItems();
	 };
	 
	 /*
	  * Get the title of selected filter
	  * @param filterType is the unique identifier for the filter
	  * @param filterValue is the value of the selected filter.
	  */
	 self.getFilterTitle = function(filterType, filterValue){
		var allFilters = self.workListModel.metaData.filters;
		for (var index = 0; index < allFilters.length; ++index) {
			if(allFilters[index].type == filterType){
				for(var ix =0; ix<allFilters[index].filterOptions.length; ix++){
					if(allFilters[index].filterOptions[ix].value == filterValue){
						return allFilters[index].filterOptions[ix].title;
					}
				}
			}
		}
		return filterValue;
	 };
	 
	 /*
	  * Switch between card view and tabular view.
	  * @param selectedView is the view object for selected made
	  */
	 self.switchView = function(selectedView){
		 angular.forEach(self.workListModel.metaData.listViews,function(eachView){
			if(selectedView.type == eachView.type){
				$log.log("Selected view: " + selectedView.type);
				eachView.selected = true;
				self.workListModel.pagination.viewPortSize = eachView.viewPortSize;
				self.workListModel.pagination.startRowNumber = 0;
				eachView.startRowNumber = 0;
				self.workListModel.pagination.fetchSize = eachView.fetchSize;
				self.workListModel.pagination.currentPage = 1;
				$log.log("pagination changed to ");
				$log.log(self.workListModel.pagination);
				self.fetchWorkItems();
			}else{
				eachView.selected = false;
			} 
		 });
	 };
	 
	 /*
	  * 
	  */
	 self.open = function(fieldName, $event) {
		$event.preventDefault();
		$event.stopPropagation();
		
		self[fieldName] = true;
	 };
	 
	 //Launch the application
	//Get the meta based on the URL parameters
	self.getMetaData();
	 
}]);


})();