(function() {

'use strict';

/*
 * Directive for add new card.
 * This directive is engaged by adding the attribute "addnew-card" to any html element.
 * 
 * Example
		<div addnew-card
			addlinks="dataCtrl.workListModel.metaData.newWorkItemLinks"
			type="{{dataCtrl.workListModel.metaData.index}}"
			name="dataCtrl.workListModel.metaData.name"
			when-upload="dataCtrl.initiateUpload()"
			create-work-item="dataCtrl.createWorkItem(href)">
		</div>
 * 
 * Based on the type argument passed in template 'worklist/partials/' + type + '-addnewcard.tpl.jsp' is engaged
 * 
 * dependencies:
 */
angular.module('ap.worklist.drv.adddNewCard', ['ngRoute'])

	.directive('addnewCard',	[ '$log', function($log) {
		$log.log('addnewCard directive!!!');
		return {
			restrict : 'A',
			scope : {
				addlinks : '=',
				type: '@',
				workListType: '=name',
				whenUpload:'&',
				createWorkItem: '&'
			},
			link : function(scope, element, attrs) {
				//$log.log(scope, element, attrs);
				
		        scope.contentUrl = 'worklist/partials/worklist-addnewcard.tpl.jsp';
		        $log.log("add new card content url=" + scope.contentUrl);
		        scope.addNewState = "none";
		        scope.setState = function(state){
		        	scope.addNewState = state;
		    	};		        
		        attrs.$observe("type", function (type) {
	                $log.log("Add new card in observe=" + type);
	                scope.contentUrl = 'worklist/partials/' + type + '-addnewcard.tpl.jsp';
	                $log.log("add new card content url=" + scope.contentUrl);
		        });
			},
			template : '<div ng-include="contentUrl"></div>'
		};
	} ]);

})();