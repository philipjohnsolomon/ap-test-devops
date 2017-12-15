(function() {
'use strict';

	angular.module('ap.worklist.workitemActionsService', ['ap.common.constants'])

	.service('WorkItemActionsSrv', ['$http', 'contextPath', 'csrf', function($http, contextPath, csrf){
		
		var self = this;
		
		self.getWorkItemActions = function(workitemId, successCallBack, errorCallBack){
			 return $http.get("WorkItemAction?action=GetWorkItemActions",{
				 params: angular.extend({WORKITEMID: workitemId},csrf),
				 headers: { Accept: 'application/json', 'Content-Type': 'application/json'}
			 }).then(successCallBack, errorCallBack);
		};
		
		self.executeAction = function(workitem, action, successCallBack, errorCallBack){
		 return $http.get(action.url,{
			 params: csrf,
			 headers: { Accept: 'application/json', 'Content-Type': 'application/json' }
		 }).then(successCallBack, errorCallBack);
		};
	}]);
	
	
})();