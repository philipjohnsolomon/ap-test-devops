(function() {
'use strict';

// Declare app level module which depends on views, and components
angular.module('ap.worklist', [
  'ngRoute',
  'ui.bootstrap',
  'ap.worklist.workListViewServices',
  'ap.worklist.workitemActionsService',
  'ap.worklist.mdl',
  'ap.worklist.main',
  'ap.worklist.drv.card',
  'ap.worklist.drv.adddNewCard',
  'ap.common.constants',
  'ap.worklist.queues'
])

/*
 * Register a http interceptor that will handle error at a global level for all http calls
 * Intercepts the response when http error occurs (status code between 200 and 299 is considered a success status)
 * Broadcasts (with name 'ap.messages') the error response for whoever is listening  
 */
.config(['$provide', '$httpProvider', function($provide, $httpProvider) {
	$httpProvider.interceptors
	.push(function($q, $rootScope) {
		return {
			'responseError': function(response) {
				if(response.status != 404){
					 $rootScope.$broadcast('ap.messages', response);
			    }
				return $q.reject(response);
			}
		};
	});
}])


/*
 * This directive listens to error messages broadcasted by the http interceptor.
 * Uses messages.tpl.jsp template to display the error messages.
 * The messages are removed after 5 secs by default with an exception of security error.
 * An error is considered security error if error code is one of the error codes defined in ap.common.constants (see site_shell.jsp) 
 * When the security error is detected, the session is usually invalidated and hence "Click here to Continue" button is present 
 * which will take the use to the Login page.
 * This directive can be engaged using <ANY messages /> or <messages />
 */
.directive('messages',	[ '$timeout', '$log', 'securityErrorCodes', function($timeout, $log, securityErrorCodes) {
	ap.consoleInfo('messages directive!!!');
	return {
		restrict : 'AE',
		link : function(scope, element, attrs) {
			scope.messages = [];
			scope.hasSecurityError = false;
			$log.log("Messages directive");
			
			scope.$on('ap.messages',function(event,eventData){
				$log.log("Received messages");
				var msg = eventData.data.response.message;
				scope.messages.splice(0, scope.messages.length);
				scope.messages.push(msg);
				console.log(securityErrorCodes);
				if(securityErrorCodes.indexOf(eventData.data.response.status) < 0 ){
					var index = scope.messages.indexOf(msg);
					$timeout(function(){
						scope.messages.splice(index,1);
					},5000);
				}else{
					scope.hasSecurityError = true;
				}
			});
		},
		templateUrl: 'shared/partials/messages.tpl.jsp'
	};
} ])

.filter('percentage', ['$filter', function ($filter) {
	  return function (input, decimals) {
		  if (decimals && decimals.length){
			    return $filter('number')(input, decimals) + '%';
		  } else {
			    return $filter('number')(input) + '%';
		  }
	  };
	}]);

})();

