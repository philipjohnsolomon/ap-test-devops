(function() {

'use strict';

angular.module('ap.worklist.mdl',[])

	.controller('WorkListConfirmationCtrl', ['$scope', '$modalInstance', '$log', 'details', function ($scope, $modalInstance, $log, details) {
	  $scope.details = details;
	  $scope.yes = function () {
	    $modalInstance.close();
	  };

	  $scope.no = function () {
	    $modalInstance.dismiss('cancel');
	  };
	}])
	
	/* Link to account modal */
	.controller('WorkItemLinkModalCtrl', ['$scope', '$modalInstance', '$log','WorkListViewSrv','WorkItemActionsSrv', 'workitem','action',
	                                      	function ($scope, $modalInstance, $log, WorkListViewSrv, WorkItemActionsSrv, workitem, action) {
	  $scope.accounts = [];
	  $scope.searchVal = "";
	  $scope.showSearchAccounts = false;
	  $scope.displayResults = false;
	  
	  $scope.select = function (account) {
	    $modalInstance.close(account);
	  };

	  $scope.close = function () {
	    $modalInstance.dismiss('cancel');
	  };
	  
	  $scope.createNewAccount = function(){
	    	action.url = action.url + '&TARGET_ACCOUNT=-1';
	    	WorkItemActionsSrv.executeAction(workitem,action,function(res){
	    		var url = res.data.response.results.url;
	    		window.location = url;
	    	});
	  };
	  
	  $scope.lookupAccounts = function(){
		  if($scope.searchVal.length < 3){
			  $scope.accounts =  [];
			  $scope.displayResults = false;
			  return;
		  }
		  
		  WorkListViewSrv.searchEntities('account',$scope.searchVal,null,function(data){
			  $scope.accounts =  data.response.results.docs;
			  $scope.displayResults = true;
		  });
	  };
	}])
	
	/* Move to account modal */
	.controller('WorkItemMoveModalCtrl', ['$scope', '$modalInstance', '$log','WorkListViewSrv', 'workitem', function ($scope, $modalInstance, $log, WorkListViewSrv, workitem) {
	  $scope.accounts = [];
	  $scope.searchVal = "";
	  $scope.showSearchAccounts = false;
	  $scope.displayResults = false;
	  
	  $scope.select = function (account) {
	    $modalInstance.close(account);
	  };

	  $scope.close = function () {
	    $modalInstance.dismiss('cancel');
	  };
	  
	  $scope.lookupAccounts = function(){
		  if($scope.searchVal.length < 3){
			  $scope.accounts =  [];
			  $scope.displayResults = false;
			  return;
		  }
		  
		  WorkListViewSrv.searchEntities('account',$scope.searchVal,workitem.account_id, function(data){
			  $scope.accounts =  data.response.results.docs;
			  $scope.displayResults = true;
		  });
	  };
	}])
	
	/* Success controller */
	.controller('WorkListSuccessCtrl', ['$scope', '$modalInstance', '$log', 'response', function ($scope, $modalInstance, $log, response) {
	  $scope.response = response;
	  $scope.successMessage = ap.htmlDecode(response.message);
	  $log.log($scope.successMessage);
	  $scope.no = function () {
	    $modalInstance.dismiss('cancel');
	  };
	}])
	
	/* saved filter delete controller */
	.controller('SavedFilterDeleteCtrl', ['$scope', '$modalInstance', '$log', 'savedSearch', 'getMetaData', 'WorkListViewSrv', function ($scope, $modalInstance, $log, savedSearch, getMetaData, WorkListViewSrv) {
	
	  $scope.savedSearch = savedSearch;
	  $scope.getMetaData = getMetaData;
	  $scope.WorkListViewSrv = WorkListViewSrv;
	  $scope.no = function () {
	    $modalInstance.dismiss('cancel');
	  };
	  
	  $scope.yes = function () {
		  WorkListViewSrv.deleteSearch(savedSearch, getMetaData);
		  $modalInstance.dismiss('cancel');
	  };
	}]);
})();