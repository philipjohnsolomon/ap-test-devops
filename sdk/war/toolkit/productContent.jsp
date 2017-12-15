<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal"%>
<div id="wizard">
	<div id = "contextAction" class="context_action">
			<div id="product_menu" style="" class="menu">
				<tk:menuPill id="${param.productId}_productPill">
					<tk:menuButton id="${param.productId}_exportButton" title="Export the product" text="Export" classname="primary exportProduct"/>
					<tk:menuButton id="${param.productId}_deleteButton" title="Delete the product" text="Delete" classname="deleteProduct"/>
				</tk:menuPill>
				<tk:menuPill id="${param.productId}_copyPill">
					<tk:menuButton id="${param.productId}_copyButton" title="Copy the product" text="Copy" classname="copyProduct"/>
				</tk:menuPill>
			</div>
		</div>	
	<div id="editor">
		<div id="editor_inner">
			<div id="artifact_header">
				<div>
					<span
						id="productDatabase.product[@id='${param.productId}'].@title_label">Product
						Title: </span> <span
						id="productDatabase.product[@id='${param.productId}'].@title_title_wrapper">
						<span
						id="productDatabase.product[@id='${param.productId}'].@title_title">
							<span>${title}</span>
					</span>
					</span>
				</div>
				<div>
					<span
						id="productDatabase.product[@id='${param.productId}'].@type_label">Product
						ID: </span> <span
						id="productDatabase.product[@id='${param.productId}'].@type_wrapper">
						<span
						id="productDatabase.product[@id='${param.productId}'].@type_title">
							<span>${productType}</span>
					</span>
					</span>
				</div>
				<div id="${productId}_description_formRow">
					<span id="${param.productId}_description_label">Description:
					</span> <span id="file_description"> <span> <span>${description}</span>
					</span>
					</span>
				</div>
				<div id="${productId}_version_formRow">
					<span id="${param.productId}_version_label">Based on
						AgencyPort Template Version: </span> <span id="product_version"> <span>
							<span>${version}</span>
					</span>
					</span>
				</div>
			</div>
		</div>
	</div>
</div>