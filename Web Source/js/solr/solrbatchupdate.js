(function() {

	'use strict';

	angular.module('ap.solrbatchupdater', ['ap.common.constants'])
	.controller('ap.solrbatchupdater.SolrBatchUpdater', ['$log','$http', 'csrf','metaData', function($log, $http, csrf, metaData) {
		ap.consoleInfo("Initialized Solr batch indexer");
		var self = this;
		self.metaData = metaData;
		self.message = "";
		self.error = false;
		self.success = false;
		
		self.updateIndex = function(type){
			self.error = false;
			self.success = false;

			$http({
		        url: 'SolrBatchUpdate?type=' + type,
		        method: "POST",
		        params: csrf,
		        headers: { Accept: 'application/json', 'Content-Type': 'application/json' }
		    })
		    .then(function(response) {
		    	ap.consoleInfo(response);
		    	if(response.data.responseHeader.status == 0) {
		    		self.success = true;
		    	}else{
			    	self.message = response.data.error_msg;
			    	self.error = true;
		    	}
		    });
		}
		
	}]);
	
})();