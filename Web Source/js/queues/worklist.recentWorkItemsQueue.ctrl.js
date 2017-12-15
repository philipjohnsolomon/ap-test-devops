(function (angular) {

'use strict';

angular.module('ap.worklist.queues', ['ngResource', 'ngRoute', 'ui.bootstrap', 'ap.common.constants','ap.worklist.workListViewServices'])

/*
 * ap.worklist.worklistViewCtrl is first controller that paints the worklist.
 * It initiates query for worklist meta data
 * Paints the worklist search options
 */
.controller('ap.worklist.recentWorkItemsQueueCtrl', ['$resource', '$filter', 'csrfObject','contextPath','WorkListViewSrv', '$log',
                    function($resource, $filter, csrfObject, contextPath, WorkListViewSrv, $log) {
	$log.log('created ap.worklist.recentWorkItemsQueueCtrl');
	var self = this;
	self.agentqueue = {};
	self.uwqueue ={};	
	self.quoteBoxes = {};
	
	self.agentqueue.metaData = {};
	self.agentqueue.workItems = {};
	self.agentqueue.fetchWorkItem=true;

	self.uwqueue.metaData = {};
	self.uwqueue.workItems = {};
	self.uwqueue.fetchWorkItem=true;

	self.quoteBoxes.metaData = {};
	self.quoteBoxes.fetchWorkItem = false;
	
	
	self.agentqueue.worklistResource = 
		 $resource(contextPath + '/api/worklists/workitems/views/WorkItemsRecentAgentQueue?:csrftokenname=:csrftoken' , {},{
			query: {method:'GET', params: {csrftokenname: '@csrftokenname', csrftoken: '@csrftoken'}, isArray:false, headers: { Accept: 'application/json' } },
			read: {method:'POST', params: {csrftokenname: '@csrftokenname', csrftoken: '@csrftoken'}, isArray:false, headers: { Accept: 'application/json', 'Content-Type': 'application/json' }}
		});

	self.uwqueue.worklistResource = 
		 $resource(contextPath + '/api/worklists/workitems/views/WorkItemsRecentUWQueue?:csrftokenname=:csrftoken' , {},{
			query: {method:'GET', params: {csrftokenname: '@csrftokenname', csrftoken: '@csrftoken'}, isArray:false, headers: { Accept: 'application/json' } },
			read: {method:'POST', params: {csrftokenname: '@csrftokenname', csrftoken: '@csrftoken'}, isArray:false, headers: { Accept: 'application/json', 'Content-Type': 'application/json' }}
		});

	self.quoteBoxes.worklistResource = 
		 $resource(contextPath + '/api/worklists/workitems/views/QuotesByStatus?:csrftokenname=:csrftoken' , {},{
			query: {method:'GET', params: {csrftokenname: '@csrftokenname', csrftoken: '@csrftoken'}, isArray:false, headers: { Accept: 'application/json' } },
			read: {method:'POST', params: {csrftokenname: '@csrftokenname', csrftoken: '@csrftoken'}, isArray:false, headers: { Accept: 'application/json', 'Content-Type': 'application/json' }}
		});
	
	//This function is called after the initial meta for worklist is retrieved
	//initView will setup any state default values for painting the UI
	self.initView = function(queue){
		$log.log(queue.metaData);
		WorkListViewSrv.retrieveLookupList(queue.metaData.lookupLinks,{worklistType: 'workitems'});
		
		if(queue.fetchWorkItem){
			self.fetchWorkItems(queue);
		}
	};
	
	self.getItemCount = function(status){
		for(var index in self.quoteBoxes.statuses){
			if(self.quoteBoxes.statuses[index] == status){
				return self.quoteBoxes.items[index];
			}
		}
		return 0;
	};
	
	self.fetchWorkItems = function(queue,resHandler){
		var par = angular.extend({csrftokenname: csrfObject.csrftokenName, csrftoken: csrfObject.csrftokenValue},queue.metaData);
			queue.worklistResource.read(par,function(data,headers){
			 queue.workItems = data.response.results.docs;
			 if(angular.isFunction(resHandler)){
				 resHandler(data.response); 
			 }
		 },function(data){
			 $log.log(data);
		});
	};
	
	self.getMetaData = function(queue,resHandler){

		queue.worklistResource.query({csrftokenname: csrfObject.csrftokenName, csrftoken: csrfObject.csrftokenValue},function(data,headers){
			queue.metaData = data.response.results.workListView;
			 
			 self.initView(queue);
			 
			 if(angular.isFunction(resHandler)){
				 resHandler();
			 }
			},function(data){
			$log.log('Unable to retrieve valid meta data for worklist : ' + data);
		});

	};
	
	self.getMetaData(self.agentqueue,function(){
		self.getMetaData(self.uwqueue,function(){
			self.getMetaData(self.quoteBoxes,function(){
				$log.log(self.quoteBoxes);
				self.getQuoteGroups(self.quoteBoxes);
			});
		});
	});
	

	self.lookupValue = function(key,code){
		return WorkListViewSrv.lookupValue(key,code);
	};
	
	self.getDaysFromToday = function(lastUpdated){
		var  nowTime = (new Date()).getTime();
		var index = lastUpdated.indexOf(' ');		
		var pattern = /(\d{2})\-(\d{2})\-(\d{4})/;
		var dt =  lastUpdated.substring(0, index).replace(pattern,'$3/$1/$2');
		
		lastUpdated = dt +  lastUpdated.substring(index);
		
		var lastDatetime = (new Date(lastUpdated)).getTime();
		var diff = nowTime - lastDatetime;
		var secs = Math.abs(diff)/1000;
		return Math.round(secs/(60*60*24));
	};
	
	self.getQuoteGroups = function(quene){
		
		quene.statuses = [];
		quene.items = [];
		quene.params = [];
		var  keepGoing = true;
		angular.forEach(quene.metaData.queryInfo.queryFields,function(queryField){			
			if(queryField.dataType=='STATUS' && keepGoing){
				keepGoing = false;
				quene.statuses = angular.copy(queryField.operands);				
				for(var index in quene.statuses){			
					var status = quene.statuses[index];
					queryField.operands= [status];
					var par = angular.extend({csrftokenname: csrfObject.csrftokenName, csrftoken: csrfObject.csrftokenValue}, quene.metaData);
					quene.params[index] =  angular.copy(par);
				};
			}
		});

		self.getQuoteCount(quene, 0);
		$log.log(self.quoteBoxes);
	};
	
	//get count by status using $resource chain.
	self.getQuoteCount =  function (quene, index){
		if(index < quene.statuses.length){
			quene.worklistResource.read(quene.params[index],function(data,headers){
				quene.items[index] = data.response.results.hits;
				self.getQuoteCount(quene, index + 1);
			},function(data){
				$log.log(data);
			});
		}else{
			quene.params = [];
		}
	};
	
	self.getWorkItemValue = function(field, workitem){
		var val = workitem[field.id];
		if(field.id == 'last_update_time'){
			val = self.getDaysFromToday(workitem.last_update_time);
		}else{
			var newVal = self.lookupValue(field.id,val); //lookup using field id
			if(val == newVal){
				val = self.lookupValue(field.type,val); //lookup using field type
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
							val = $filter(tokens[0])(val, tokens.slice(1));
						}else{
							val = $filter(formatVal)(val);
						}
					}
				}catch(error){
					console.log('Unsupported format error: ' + error);
				}
			}
			return val;
		}
		return val;
		
	};
}]);

})(window.angular);