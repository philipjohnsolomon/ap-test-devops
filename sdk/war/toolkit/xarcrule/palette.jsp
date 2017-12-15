<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<div id="palette">
	<div id="${param.artifactId}_palette" style="" class="palette events_created">
		
		<tk:tabs path="${param.artifactId}">
			<tk:tab tabName="Options" focusOnLoad="true" path="${param.artifactId}"></tk:tab>
		</tk:tabs>
	
		<tk:tabContent tabName="Options" path="${param.artifactId}">
			<input type="hidden" id="${param.artifactId}.@delete" name="${param.artifactId}.@delete" value=""/>
	
			<tk:input path="@title" 
					label="Rule Library Title" 
					fieldValue="${tk:getFieldValue(toolkitData,'.@title','New Rule Library Title')}"  
					required="*" 
					defaultValue="" 
					size="20" 
					className="rulefile_title_event" 
					helptext="xarc_helptext|title">
				</tk:input>	
				<tk:input path="@name" 
					label="Rule Library ID" 
					fieldValue="${tk:getFieldValue(toolkitData,'.@name','New_Rule_Library_ID')}" 
					required="*" 
					defaultValue="" 
					size="20" 
					className="" 
					helptext="xarc_helptext|name">
				</tk:input>	
		</tk:tabContent>
	</div>
</div>