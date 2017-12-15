<div id="file-uploader-widget" class="file-uploader-widget">
	<div class="upload-file-queue">
		<div uploader="uploader" class="file-drop-zone" id="turnstile-files-selector">
			<div class="file-drop-instructions">			
				<p>Drag file here</p>
				<i class="fa"></i>
			</div>
		</div>
	</div>
	
	<div class="turnstile-file-upload-list">
		<table class="table table-striped">
			<tbody id="fileupload-file-listing">
	
			</tbody>
		</table>
	</div>
	<span class="btn btn-default fileinput-button add-files">
		<span><%= coreRB.getString("label.FileSelector.AddFiles") %></span> 
		<input type="file" name="files[]" multiple id="fileupload_blueimp"/>
	</span>
	
	<button type="submit" class="btn btn-primary start">
		<span><%= coreRB.getString("label.FileSelector.StartUpload") %></span>
	</button>
</div>