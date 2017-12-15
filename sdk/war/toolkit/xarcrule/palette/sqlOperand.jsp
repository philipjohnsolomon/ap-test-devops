<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="dataSourcePrefixPath" value="${param.path}.@dataSourcePrefix"/>
<div id="${param.path}_formRow" class="operand" style="${param.hidden}">
	<tk:input path="${dataSourcePrefixPath}" 
				label="Data Source" 
				fieldValue="${tk:getFieldValue(toolkitData,dataSourcePrefixPath,'')}"  
				required="" 
				defaultValue="" 
				size="40"
				hidden=""
				className="operand resetValue" 
				helptext="xarc_helptext|datasource">
	</tk:input>	
	
	<tk:textarea path="${param.path}" 
				label="SQL Query" 
				fieldValue="${tk:getFieldValue(toolkitData,param.path,'')}"  
				required="*" 
				defaultValue="" 
				size="40"
				className="operand change_event resetValue accordion_update"
				hidden=""
				helptext="xarc_helptext|sqlquery">
	</tk:textarea>	
</div>