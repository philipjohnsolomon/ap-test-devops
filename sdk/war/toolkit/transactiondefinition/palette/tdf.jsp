<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="fieldPath" value="${toolkitData.basePath}[${toolkitData.currentIndex}]"/>
<c:set var="pageDetails" value="${tdfData.pageDetails[toolkitData.currentIndex]}"/>
<div id="${param.artifactId}_palette" style="" class="palette events_created">
	<tk:tabs path="${param.artifactId}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${param.artifactId}"/>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${param.artifactId}"/>
	</tk:tabs>
	<tk:tabContent tabName="Options" path="${param.artifactId}">
			<input type="hidden" name="${param.artifactId}.@delete" id="${param.artifactId}.@delete" value="" />
			<tk:input path="@title" label="Menu Title" fieldValue="${tk:getFieldValue(toolkitData,'.@title','')}" 
					required="*" defaultValue="" size="20" className="" helptext="transaction_helptext|menutitle">
			</tk:input>
			<tk:input path="@id" label="Transaction ID" fieldValue="${tk:getFieldValue(toolkitData,'.@id','')}" 
						required="*" defaultValue="" size="20" className="" helptext="transaction_helptext|id">
			</tk:input>
			<tk:input path="@lob" label="Product ID" fieldValue="${tk:getFieldValue(toolkitData,'.@lob','')}" 
						required="*" defaultValue="" size="20" className="" helptext="transaction_helptext|lob">
			</tk:input>
			<tk:input path="@target" label="Schema" fieldValue="${tk:getFieldValue(toolkitData,'.@target','')}" 
						required="*" defaultValue="" size="20" className="" helptext="transaction_helptext|target">
			</tk:input>
			<tk:textarea path="@mappingId" label="Mapping ID for ACORD Data" fieldValue="${tk:getFieldValue(toolkitData,'.@mappingId','')}" 
						required="*" defaultValue="" size="40" className="" helptext="transaction_helptext|nameofsourceforwip">
			</tk:textarea>
			<tk:select label="Summary Page" path="@summaryPageId" helptext="transaction_helptext|summarypage">
				<c:out value="${tdfData.summaryPageList}" escapeXml="false"></c:out>
			</tk:select>
			<tk:select label="Work Item Assistant" path="@workItemAssistantId" helptext="transaction_helptext|workitemassistant">
				<c:out value="${tdfData.workItemAssistantList}" escapeXml="false"></c:out>
			</tk:select>
		</tk:tabContent>
		<tk:tabContent tabName="Advanced" path="${param.artifactId}" styleValue="display: none;">		
			<tk:select label="Prevalidate" path="@prevalidate" helptext="transaction_helptext|prevalidate">
				${tk:getOptionsHTML(toolkitData, 'booleanTrue', '@prevalidate', '')}
			</tk:select>	
			<tk:select label="Field Validations" path="@fieldValidations" helptext="transaction_helptext|fieldvalidations" >
				${tk:getOptionsHTML(toolkitData, 'enabledDisabled', '@fieldValidations', 'enabled')}
			</tk:select>	
			<tk:select label="Auto Maintain ID Attributes" path="@autoMaintainIdAttributes" helptext="transaction_helptext|automaintainidattributes" >
				${tk:getOptionsHTML(toolkitData, 'booleanFalse', '@autoMaintainIdAttributes', '')}
			</tk:select>	
			<tk:select label="Enable All Menu Entries" path="@enableAllMenuEntries" helptext="transaction_helptext|enableallmenuentries" >
				${tk:getOptionsHTML(toolkitData, 'booleanFalse', '@enableAllMenuEntries', '')}
			</tk:select>	
			<tk:select label="Support Defaults" path="@supportsDefaults" helptext="transaction_helptext|supportdefaults" >
				${tk:getOptionsHTML(toolkitData, 'booleanTrue', '@supportsDefaults', '')}
			</tk:select>		
			<!-- related transaction -->
			<tk:select label="Related Transaction ID" path="@relatedTransactionId" helptext="transaction_helptext|relatedtransactionid">
				<c:out value="${tdfData.relatedTransacitonList}" escapeXml="false"></c:out>
			</tk:select>
			<tk:select label="Support Upload Data Correction" path="@supportsUploadDataCorrection" helptext="transaction_helptext|supportuploaddatacorrection">
				${tk:getOptionsHTML(toolkitData, 'booleanTrue', '@supportsUploadDataCorrection', '')}
			</tk:select>	
			<tk:select label="Has Available UI" path="@hasAvailableUI" helptext="transaction_helptext|hasavailableui">
				${tk:getOptionsHTML(toolkitData, 'booleanTrue', '@hasAvailableUI', '')}
			</tk:select>
			<tk:select label="Support IPDTR Dynamic Content" path="@supportsIPDTRDynamicContent" helptext="transaction_helptext|supportsipdtrdynamiccontent" >
				${tk:getOptionsHTML(toolkitData, 'booleanFalse', '@supportsIPDTRDynamicContent', '')}
			</tk:select>							
	</tk:tabContent>
</div>
