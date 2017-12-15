 /**
 * This grunt file (see: http://gruntjs.com/) can combine, minify, and generate sourcemaps for javascript and less files. To use it, simply download and install node.js (at least version 0.10),
 * run the npm install command at this directory, then run the grunt command to execute the build's default task. Make sure you add the generated 'node_modules' directory to svn:ignore 
 *
 *
 * This build file assumes a certain project directory structure. Please update this file if your project structure must differ from the following:
 * 
 * 	Project
 * 	|-- Web Source
 * 	|-- |-- js
 * 	|-- |-- lib
 *  |-- |-- less
 * 	|-- Web Root
 * 	|-- |-- assets
 * 	|-- |-- |-- js
 * 	|-- |-- |-- themes
 */
module.exports = function(grunt) {

	// Default task(s).
	grunt.registerTask('default', ['uglify', 'less', 'bless']);

	//some properties to use during the build...
	var headJSFiles = [
      	'lib/es5-shim/es5-shim.js',
      	'lib/es5-shim/es5-sham.js',
		'lib/jquery/jquery-1.10.2.js',
		'lib/jquery-ui/js/jquery-ui-1.10.4.custom.min.js',
		'lib/bootstrap-3.1.1/dist/js/bootstrap.js',
		'lib/typeahead/js/typeahead.bundle.js',
		'lib/jquery-visible-master/jquery.visible.js',
		'lib/angular/angular.js',
		'lib/angular-bootstrap/ui-bootstrap-tpls.js',
		'lib/angular-route/angular-route.js',
		'lib/angular-ui-router/angular-ui-router.js',
		'lib/angular-resource/angular-resource.js',
		'lib/angular-loader/angular-loader.js',
		'lib/angular-mocks/angular-mocks.js',
		'lib/angular/angular-file-upload.js',
		'lib/angular/angular-modal-service.js',
		'lib/angular-sanitize/angular-sanitize.js',
		'lib/respond/respond.min.js',
		'lib/modernizr/modernizr.js',
		'lib/jQuery-File-Upload/js/jquery.iframe-transport.js',
		'lib/jQuery-File-Upload/js/jquery.fileupload.js',
		'lib/jQuery-File-Upload/js/jquery.fileupload-process.js',
		'lib/jQuery-File-Upload/js/jquery.fileupload-validate.js',
		'lib/formatmask/jquery.maskedinput.js',
		'lib/bootstrap-datepicker-1.4.1/js/bootstrap-datepicker.js',
		'lib/bootstrap-datepicker-1.4.1/js/locales/bootstrap-datepicker.es.js',
		'lib/select2-3.5.2/select2.js',
		'lib/spin.js/spin.js', 
		'lib/timer/idle_timer.js',
		'lib/jquery-ui-timepicker/jquery.ui.timepicker.js',
		'js/ap_javascript_base.js',
		'js/ap_account.js',
		'js/ap_workitemLock_widget.js',
		'js/snippets/ap_snippets.js',
		'js/ap_javascript_objects.js',
		'js/ap_fieldmask.js',
		'js/ap_fieldsecurity_handler.js',
		'js/ap_navigation.js',
		'js/ap_javascript_dtr.js',
		'js/ap_messaging.js',
		'js/ap_installer.js',
		'js/ap_timeline.js',
		'js/ap_multiresult.js',
		'js/ap_override.js',
        'lib/imageMapster-master/dist/jquery.imagemapster.js',
		
		'lib/amcharts/amcharts.js',
		'lib/amcharts/pie.js',
		'lib/amcharts/serial.js',
		'js/dashboard/apdashboard.js',			
		'lib/amcharts/amexport.js',
		'lib/amcharts/rgbcolor.js',	
		'lib/amcharts/canvg.js',
		'lib/amcharts/filesaver.js',
		'lib/amcharts/jspdf.js',
		'lib/amcharts/jspdf.plugin.addimage.js',
		'js/ap_dynamic_background_manager.js',
		'lib/tablesorter/js/jquery.tablesorter.min.js',
		'lib/tablesorter/js/jquery.tablesorter.widgets.min.js',		
	    ];
	var bodyJSFiles = [
		'lib/infinite-scroll/jquery.infinitescroll.js',
		'js/solr/solrbatchupdate.js',
		'js/ap_turnstile_widget.js',
		'js/worklist-ng/worklist.app.js',
		'js/worklist-ng/worklist.srv.js',
		'js/worklist-ng/worklist.search.ctrl.js',
		'js/worklist-ng/worklist.data.ctrl.js',
		'js/worklist-ng/worklist.workitemactions.srv.js',
		'js/worklist-ng/worklist.workitemdata.drv.js',
		'js/worklist-ng/worklist.addnewcard.drv.js',
		'js/worklist-ng/worklist.workitemactions.mdl.js',
		'js/workitemassistant-ng/workitemassistant.ctrl.js',
		'js/queues/worklist.recentWorkItemsQueue.ctrl.js',
		'js/custom/cust.worklist.workitemdata.drv.js'
		];

	grunt.initConfig({

	    uglify: {
	      
	      	options: {
        		sourceMap: true,
        		sourceMapIncludeSources: true,
	        	mangle: false,
	      	},

		    headJS: {
		      	options: {
		      		sourceMapRoot: '../',
		        	sourceMapName: '../Web Root/assets/js/agencyportal.js.map',
		      	},
		        src : headJSFiles,
		        dest: '../Web Root/assets/js/agencyportal.js',
		    },
		    bodyJS: {
		      	options: {
		      		sourceMapRoot: '../',
		        	sourceMapName: '../Web Root/assets/js/agencyportal-body.js.map',
		      	},
		        src : bodyJSFiles,
		        dest: '../Web Root/assets/js/agencyportal-body.js',
		    },
		},

	    less: {
		    css: {
		    	options: {
		    		paths: ['less', 'lib'],
		    		sourceMap: true,
		    		sourceMapFilename: '../Web Root/assets/themes/agencyportal/agencyportal.css.map',
		    		outputSourceFiles: true,
		            sourceMapURL: 'agencyportal.css.map', // the complete url and filename put in the compiled css file
		            sourceMapRootpath: '/Web Source', // adds this path onto the sourcemap filename and less file paths
		    	},
		    	
		    	src: 'less/agencyportal.less',
		    	dest: '../Web Root/assets/themes/agencyportal/agencyportal.css',
		    },
		},
		bless: {
			css: {
				options: {
					imports: false,
					logCount: true
				},
				files: {
					'../Web Root/assets/themes/agencyportal/agencyportal-ie9.css': '../Web Root/assets/themes/agencyportal/agencyportal.css'
				}
			}
		},
		watch: {
			headJS: {
				files: headJSFiles,
				tasks: ['uglify:headJS'],
			},
			bodyJS: {
				files: bodyJSFiles,
				tasks: ['uglify:bodyJS'],
			},
		    css: {
		    	files: ['less/*.less', 'lib/**/*.less'],
		    	tasks: ['less:css'],
		    }
		}
	});
	
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-bless');

  
};