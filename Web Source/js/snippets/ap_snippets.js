/**
 * This file has the javascript has the javascript for the snippets feature.
 *  
 */
ap.Snippet = function(snipImage){
	
	this.currentSnippetId;
	
	this.snippetField = snipImage;
	
	this.displayWidth;
	
	this.displayHeight;
	
	this.inArea = false;
	
	this.imageOptions = {
            highlight: true,
            mapKey: 'data-key',
            scaleMap: true,
            isSelectable: false,
            singleSelect: false,
            render_highlight: {
                fillColor: 'ffff99',
                fillOpacity: 0.2,
                stroke: true,
                strokeColor: 'ff0000',
                strokeOpacity: 1,
                strokeWidth: 1
            },
            render_select: {
                fillColor: 'ffff99',
                fillOpacity: 0.2,
                stroke: true,
                strokeColor: 'ff0000',
                strokeOpacity: 1,
                strokeWidth: 1
            }
        };
	
	this.zoomOptions = { padding: 30, duration: 100, force: true, scroll: true };
	
	
	this.init = function(){
	 	if(this.snippetField){
	 		ap.consoleInfo("Initializing mapster for " + this.snippetField.attr('id'));
	 	    this.displayWidth = this.snippetField.width();
	 	    this.displayHeight = this.snippetField.height();
	 	    
	 	   this.snippetField.mapster(this.imageOptions);
	 	}
	};
	this.init();

	this.showSnippetImage = function(){
		this.snippetField.show();
	};

	this.hideSnippetImage = function(){
		this.snippetField.hide();
	};	
	this.onMouseOver = function (data, event) {
		return event.stopImmediatePropagation();
		
        this.inArea = true;
        this.currentSnippetId = data.key;
        window.setTimeout(function () {
            var newKey = this.snippetField.mapster('highlight');
            if (newKey && newKey === this.currentSnippetId) {
                zoom(newKey);
            }
            this.currentSnippetId = null;
        }, 500);
    }
	
	this.zoomout = function zoomOut(e) {
        if (!this.snippetField.mapster('state').zoomed) {
            return;
        }
        var x=e.pageX-this.snippetField[0].offsetLeft,
            y = e.pageY-this.snippetField[0].offsetTop;

        if (x<0 || y<0 || x>width || y>height) {
        	this.snippetField.mapster('zoom',null,zoomOpts);
        }   
    };

	this.showSnippet = function(snippetId){
		var allPages = $(".snippet-body");
		if(allPages.length > 1){
			$(".snippet-body").each(function(){
				$(this).hide();
			});
		}
		this.snippetField.parents(".snippet-body").show();

		console.info("Showing: " + snippetId);
		console.info("currentkey=" + this.currentSnippetId);
    	if(this.currentSnippetId == snippetId){
    		console.info("Aleary highlighted " + snippetId);
    		return;
    	}
    	console.info("highlighting " + snippetId);
    	this.currentSnippetId = snippetId;
    	this.highlightSnippet(snippetId);
	};

	this.unHighlightSnippet = function(snippetId){
		this.snippetField.mapster('highlight',false);
	}
	
	this.highlightSnippet = function zoom(snippetId) {
		this.snippetField.mapster('zoom',null,this.zoomOptions);
		setTimeout($.proxy(function () {
	    	this.snippetField.mapster('highlight',snippetId);
	    	this.snippetField.mapster('zoom',snippetId,this.zoomOptions);
		},this), 500);
	};

	
	this.removeHighlight = function(){
		this.snippetField.mapster('zoom',null,this.zoomOptions)
	};

	this.showSnippetImage = function(){
		this.snippetField.show();
	};

	this.hideSnippetImage = function(){
		this.snippetField.hide();
	};
};


