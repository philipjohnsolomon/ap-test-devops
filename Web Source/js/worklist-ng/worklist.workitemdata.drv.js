(function() {

'use strict';

angular.module('ap.worklist.drv.card', ['ngRoute','ap.common.constants','ap.worklist.workListViewServices'])

	.directive('workitemCard',	['$log', 'WorkItemActionsSrv','WorkListViewSrv', function($log, WorkItemActionsSrv, WorkListViewSrv) {
		$log.log('workitemCard directive!!!');
		return {
			restrict : 'A',
			scope : {
				workitemData : '=',
				type: '@',
				whenSelected: '&',
				whenActionClicked: '&'
			},
			link : function(scope, element, attrs) {
				
		        scope.contentUrl = 'worklist/partials/' + attrs.type + '-card.tpl.jsp';
		        scope.actionsOpen = false;
		        
		        attrs.$observe("type", function (type) {
		                $log.log("type=" + type);
		                scope.contentUrl = 'worklist/partials/' + type + '-card.tpl.jsp';    
		        });
				
		        /*
				 * 
				 */
				scope.isWorkItemSelected = function(){
					if( !scope.workitemData.selected ){
						scope.workitemData.selected = false;
					}
					return scope.workitemData.selected;
				};
				
				scope.isLinkedToAccount = function(){
					if( !scope.workitemData.account_id ){
						scope.workitemData.account_id = -1;
					}
					return scope.workitemData.account_id != -1;
				};
				
				scope.performDoubleClick = function(){
					var workitem = scope.workitemData;
					if(workitem.actions && workitem.actions.length>0){
						var openAction = null;
						angular.forEach(workitem.actions,function(each){
							if(each.code == 'Open'){
								openAction = each;
							}
						});
						window.location = openAction.url;
					}else{
						scope.getWorkItemActions(scope.performDoubleClick);						
					}
				};
				
				/*
				 * Service call to get workitem actions
				 */
				scope.getWorkItemActions = function(callbackFunction){
					var workitem = scope.workitemData;
					
					//Call back parent controller's function
					scope.whenSelected({
						selectedWorkItem: workitem
					});

					if(workitem.actions && workitem.actions.length>0){
						return;
					}
					WorkItemActionsSrv.getWorkItemActions(workitem.work_item_id,
					function(res){
						workitem.actions = res.data.response.results.actions;
						if(callbackFunction){
							callbackFunction(workitem.actions);							
						}
						$log.log("workitem actions retrieved");
					},function(res){
						$log.log("Error retrieving workitem actions: " + res);
					});
				};
				
				scope.actionClicked = function(action){
					scope.whenActionClicked({
						selectedWorkItem: scope.workitemData,
						action: action
					});
				};
				
				scope.lookupValue = function(key,code){
					return WorkListViewSrv.lookupValue(key,code);
				};
				
				scope.isWorkItemSubmitted = function(){
					return scope.workitemData.external_id  &&  scope.workitemData.external_id > 0;			
				};
			},
			template : '<div><p ng-include="contentUrl"></p></div>'
		};
	} ]);

})();