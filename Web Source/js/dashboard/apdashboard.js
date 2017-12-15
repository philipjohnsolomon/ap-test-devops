// Setup ap namespace if not already defined.
if(typeof(ap) == 'undefined') {
	var ap ={};
}
 
/**
 * Constructs a new ReportParameter object.
 * @constructor
 * @class The ReportParameter class contains information regarding a report parameter. Its name, type and ultimately value. 
 * @param paramName is parameter name.
 * @param paramType is the parameter type.
 * @param drilldown indicated if this parameter is used for drill down report
 * @return A new ReportParameter instance
*/
ap.ReportParameter= function(){
	
	this.initialize = function(paramName, paramType, drilldown) {
		this.paramName = paramName;
		this.paramType = paramType;
		this.isDrilldown = drilldown; 
		this.paramValue = null;
	};
	
	this.setValue = function(value){
		this.paramValue = value;
	};
	
	this.getValue = function(){
		return this.paramValue;
	};
	
	this.getName = function(){
		return this.paramName;
	};
	
	this.getType = function(){
		return this.paramType;
	};
	
	this.setDrilldown = function(drilldown){
		this.isDrilldown = drilldown;
	};
	this.getIsDrilldown = function(){
		return this.isDrilldown;
	};	
	
	this.initialize(arguments[0],arguments[1],arguments[2]); 
};

/**
 * Constructs a new ReportParameters object.
 * @constructor
 * @class The ReportParameters class contains zero or more ReportParameter instances. It provides a way to sequential walk
 * all parameters as well as providing a lookup by parameter name.
 * @return A new ReportParameters instance
*/
ap.ReportParameters = function(){
	
	this.initialize = function(){
		this.repositoryByName = {};	
		this.repository = new Array();
	};
	
	this.add = function(param){
		this.repositoryByName[param.getName()] = param;
		this.repository.push(param);
	};
	
	this.getByName = function(paramName){
		return this.repositoryByName[paramName];
	};
		
	this.asURLParameters = function(){
		var urlParameters = '';
		for ( var ix = 0; ix < this.repository.length; ix++ ){
			var param = this.repository[ix];
			if ( param.getValue() != null ){
				urlParameters += '&' + param.getName() + '=' + param.getValue();
			}
		}
		return urlParameters;
	};
	
	this.reset = function() {
		for ( var ix = 0; ix < this.repository.length; ix++ ){
			this.repository[ix].setValue(null);
		}
	};
	
	this.initialize();
};


/**
 * Constructs a new Report object.
 * @constructor
 * @class The Report class contains information specific to a dashboard report. 
 * @param reportId is the report identity of this report.
 * @param drillDownReportId is the report identity of a drill down report. We currently only support a single level of 
 * drill downs.
 * @param parameters contains all of the parameters for this report.
 * @param servlet is the URL to servlet which serves up the data for this report. 
 * @param swf is the SWF object if this is a chart based report. Otherwise this is null.
 * @return A new Report instance
*/
ap.Report = function (){
	
	/**
	 * The <code>STATUS</code> is the the status of the operation
	 */
	var STATUS = {
		 SUCCESS:0,
		 ERROR:-109,
		 NODATA:-110
	};
	
	this.initialize = function(reportId, drillDownReportId, reportParameters, servletUrl, isDrillDown, parentId) {

		this.reportId = reportId;
		this.drillDownReportId = drillDownReportId;
		this.servletURL = servletUrl;
		this.drillDownURL = this.servletURL.replace(reportId, drillDownReportId);
		this.chart = null;
		this.legend = null;
		this.parameters = reportParameters;
			
		if (!isDrillDown) {		
			this.registerClickEvents();
		}

		this.isDrillDown = isDrillDown;		
		this.parentReportId = parentId;
		this.reportList = [];
		this.inDrillDownReport = false;
		this.reportContainer = 'content_' + this.reportId;
		this.messageContainer = "message_" + this.reportId;
		
		$.each(this.parameters.repository, function( index, param ) {
			if('date' == param.getType()){
				var dateField = $('#' + reportId + '_' + param.getName());
				dateField.parent().datepicker({
				autoclose: true,
				format: ap.format_info["default_display.datepicker.date_format"],
				language : ap_locale,
			    todayHighlight: true}) ;
			}			
		});
	};
	
	this.hasDrillDown = function(){
		return this.drillDownReportId != null;
	};
		
	this.getServlet = function(){
		return this.servletURL;
	};
	
	this.getId = function(){
		return this.reportId;
	};
	
	this.getParameterByName = function(name){
		return this.parameters.getByName(name);
	};
	
	this.getParameters = function(){
		return this.parameters;
	};
	
	this.get = function(reportId){
		return this.reportList[reportId];
	};
		
	/**
	 * Register events on the buttons for each dash board report
	 */
	this.registerClickEvents= function() {

		if ($("#reset_" + this.reportId)) {
			$("#reset_" + this.reportId).bind("click", {self:this}, this.reset);
		}
	
		if ($("#go_" + this.reportId)){
			$("#go_" + this.reportId).bind("click", {self:this}, this.go);
		}
	};
	
	this.go = function(event){
		
		var self = event.data.self;
		var reportId = self.reportId;
		$("#primary_" + reportId).find("input, select").each(
			function (item) {
				var name  = $(this).attr('id');
				var value = $(this).val();				
				var inputName = name.split(reportId + "_");
				self.setParameterValue(inputName[1], value);
			}
		);
		self.updateChart();
	};
	
	this.reset = function(event) {	
		
		var self = event.data.self;
		var reportId = self.reportId;
		
		$("#primary_" + reportId).find("input, select").each(
			function (item) {
				$(this).val("");
		});
		
		self.parameters.reset();		
		self.updateChart('reset');		
	};
		
	this.generateURL = function () {
		if (this.parameters === null) {
			return this.servletURL;
		} 			
		return this.servletURL + this.parameters.asURLParameters();
	};
	
	this.updateChart = function (action) {
		
		$.ajax({
			type: 'POST',
			url: this.generateURL()
		}).done($.proxy(function (response, textStatus, jqXHR ){
			response = $.trim(response);
			var data = $.parseJSON(response);
			if(data.response.status == STATUS.ERROR || data.response.status == STATUS.NODATA){	
				$("#" + this.messageContainer).html(data.response.message);
				$("#" + this.messageContainer).show();
			}
			
			if(data.response.status == STATUS.SUCCESS){		
				$("#" + this.messageContainer).hide();
			}
			
			if(data.response.status == STATUS.SUCCESS || data.response.status == STATUS.NODATA){
				var chart = this.reportList[this.reportId];
				if(action == 'reset'){
					chart = null;
					this.reportList[this.reportId] = null;
				}
				if(chart){
					chart.dataProvider =  data.response.results.chartData.dataProvider;
					chart.validateData();
				}else{
					chart = AmCharts.makeChart(this.reportContainer, data.response.results.chartData);
					this.reportList[this.reportId] = chart;	
				}
			}
		},this)).fail($.proxy(function(jqXHR, textStatus, errorThrown) {
			this.updateFailure(errorThrown);
		},this));		
	};
	
	this.render = function () {		
		$.ajax({
			type: 'POST',
			url: this.generateURL()
		}).done($.proxy(function (response, textStatus, jqXHR ){
			response = $.trim(response);
			var data = $.parseJSON(response);
			if(data.response.status == STATUS.ERROR || data.response.status == STATUS.NODATA){	
				$("#" + this.messageContainer).html(data.response.message);
				$("#" + this.messageContainer).show();
			}
			
			if(data.response.status == STATUS.SUCCESS){		
				$("#" + this.messageContainer).hide();
			}
			
			if(data.response.status == STATUS.SUCCESS || data.response.status == STATUS.NODATA){
				var chart = AmCharts.makeChart(this.reportContainer, data.response.results.chartData);
				this.reportList[this.reportId] = chart;	
			}
		},this)).fail($.proxy(function(jqXHR, textStatus, errorThrown) {
			this.updateFailure(errorThrown);
		},this));		
	};
	
	this.updateFailure = function(response) {
		if(response){
			var errorMessage = response;
			if(errorMessage){
				alert(errorMessage);
			}
		}
	};
	
	this.setParameterValue = function (name, value) {
		var parameter = this.getParameterByName(name);
		parameter.setValue(value);
	};
	
	this.initialize(arguments[0],arguments[1],arguments[2],arguments[3], arguments[4],arguments[5]); 
};


 

