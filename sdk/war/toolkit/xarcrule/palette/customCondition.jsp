<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<tk:basePalette path="${param.path}">
	<input type="hidden" class="paletteType" value="customCondition" />
	<input type="hidden" id="${param.path}.@delete" name="${fn:substringBefore(param.path,'.javaclass')}.@delete" value="false" />
		
	<tk:tabs path="${param.path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${param.path}"></tk:tab>
	</tk:tabs>	

	<tk:tabContent tabName="Options" path="${param.path}">
		<tk:textarea path="${param.path}.@content" 
			label="Java Class" 
			fieldValue="${tk:getFieldValue(toolkitData,param.path,'')}"  
			required="*" 
			defaultValue="" 
			size="60"
			elementName="${param.path}"
			className="change_event accordion_update" 
			helptext="xarc_helptext|javaclass">
		</tk:textarea>
	</tk:tabContent>	
</div>
</tk:basePalette>