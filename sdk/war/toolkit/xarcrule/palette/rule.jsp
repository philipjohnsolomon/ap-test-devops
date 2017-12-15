<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="pageData" class="com.agencyport.toolkit.data.search.PageEntitySearchData" scope="request"/>

<c:set var="ruleNamePath" value="${param.path}.@name"/>
<c:set var="ruleTitlePath" value="${param.path}.@title"/>
<c:set var="idPath" value="${param.path}.@id"/>
<c:set var="ruleDescPath" value="${param.path}.description"/>
<c:set var="ruleDependsOnPath" value="${param.path}.@dependsOn"/>
<c:set var="selectNodePath" value="${param.path}.step[0].selectNodes.@xpath"/>
<c:set var="useRosterIndexPath" value="${param.path}.step[0].selectNodes.@useRosterIndex"/>
<c:set var="highlightRostersOnTVR" value="${param.path}.@highlightRostersOnTVR"/>

<tk:basePalette path="${param.path}">
	<tk:tabs path="${param.path}">
		<tk:tab tabName="Rule" focusOnLoad="true" path="${param.path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${param.path}"></tk:tab>
		<tk:tab tabName="Uses" focusOnLoad="false" path="${param.path}"></tk:tab>
		<tk:tab tabName="Used By" focusOnLoad="false" path="${param.path}"></tk:tab>
	</tk:tabs>
	<tk:tabContent tabName="Rule" path="${param.path}">
		<input type="hidden" id="${param.path}.@delete" name="${param.path}.@delete" value="false" />
		<tk:input path="${ruleTitlePath}"
			label="Title"
			fieldValue="${tk:getFieldValue(toolkitData,ruleTitlePath,'New Rule Title')}"
			required="*"
			defaultValue=""
			size="60"
			elementName="${ruleTitlePath}"
			className="message_editor accordion_update change_event autofocus"
			helptext="xarc_helptext|ruletitle">
		</tk:input>
		<div id="${ruleNamePath}_formRow" class="formRow">
			<label class="label" id="${ruleNamePath}_labelElement" for="${ruleNamePath}">
				<span id="${ruleNamePath}_labelText">
							ID
				</span>
			</label>
			<span>
				<span id="${ruleNamePath}">${tk:getFieldValue(toolkitData,ruleNamePath,'New_Rule')}</span>
			</span>
		</div>
		<tk:textarea path="${ruleDescPath}"
			label="Description"
			fieldValue="${tk:getFieldValue(toolkitData,ruleDescPath,'')}"
			required=""
			defaultValue=""
			size="60"
			elementName="${ruleDescPath}"
			className="message_editor"
			helptext="xarc_helptext|description">
		</tk:textarea>
	</tk:tabContent>
	<tk:tabContent tabName="Advanced" path="${param.path}" styleValue="display: none">
		<tk:textarea path="${selectNodePath}"
			label="Page Source"
			fieldValue="${tk:getFieldValue(toolkitData,selectNodePath,'')}"
			required=""
			defaultValue=""
			size="40"
			elementName="${selectNodePath}"
			className=""
			helptext="xarc_helptext|pagesource">
		</tk:textarea>
		<tk:select label="Use Roster Index When Available"
			path="${useRosterIndexPath}"
			helptext="xarc_helptext|userosterindexwhenavailable">
			${tk:getOptionsHTML(toolkitData,'booleanTrue',useRosterIndexPath, '')}
		</tk:select>
		<tk:input path="${ruleDependsOnPath}"
			label="Depends On"
			fieldValue="${tk:getFieldValue(toolkitData,ruleDependsOnPath,'')}"
			required=""
			defaultValue=""
			size="40"
			elementName="${ruleDependsOnPath}"
			className="message_editor">
		</tk:input>
		<tk:select label="Highlight Rosters"
			path="${highlightRostersOnTVR}"
			helptext="xarc_helptext|highlightRostersOnTVR">
			${tk:getOptionsHTML(toolkitData,'booleanTrue',highlightRostersOnTVR, '')}
		</tk:select>
	</tk:tabContent>

	<tk:tabContent tabName="Uses" path="${param.path}" styleValue="display: none">
		<tk:displayPageSearch errorMsg="${pageData.fieldErrorMsg}">
			<jsp:include page="../../shared/palette/tdfCrossReferencePalette.jsp">
				<jsp:param name="entity" value="xArc Rule" />
			</jsp:include>
		</tk:displayPageSearch>
	</tk:tabContent>

	<tk:tabContent tabName="Used By" path="${param.path}" styleValue="display: none">
		<tk:displayPageSearch errorMsg="${pageData.pageErrorMsg}">
			<jsp:include page="rulesUsedByPalette.jsp">
				<jsp:param name="entity" value="xArc Rule" />
			</jsp:include>
		</tk:displayPageSearch>
	</tk:tabContent>
</tk:basePalette>