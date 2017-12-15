<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="hotFieldPath" value="${toolkitData.basePath}"/>
<c:set var="transactionFieldName" value="${hotFieldPath}.@transaction"/>
<c:set var="pageFieldName" value="${hotFieldPath}.@page"/>
<c:set var="pageElementFieldName" value="${hotFieldPath}.@pageElement"/>
<c:set var="fieldElementFieldName" value="${hotFieldPath}.@fieldElement"/>
<c:set var="refreshListPath" value="${hotFieldPath}.refreshListFieldEvent"/>
<c:set var="transactionHelpText" value="${tk:getOptionsListValue('behavior_helptext', 'hotfield_transaction_key')}"/>
<c:set var="pageHelpText" value="${tk:getOptionsListValue('behavior_helptext', 'hotfield_page_key')}"/>
<c:set var="pageElementHelpText" value="${tk:getOptionsListValue('behavior_helptext', 'hotfield_pageElement_key')}"/>
<c:set var="fieldHelpText" value="${tk:getOptionsListValue('behavior_helptext', 'hotfield_field_key')}"/>

<tk:basePalette path="${hotFieldPath}">
	<tk:tabs path="${hotFieldPath}">
		<tk:tab tabName="Key" focusOnLoad="true" path="${hotFieldPath}"></tk:tab>
		<tk:tab tabName="options" tabDisplayName="Advanced Options" focusOnLoad="false" path="${hotFieldPath}"></tk:tab>
		<tk:tab tabName="refreshList" tabDisplayName="List Fields to Refresh" focusOnLoad="false" path="${hotFieldPath}"></tk:tab>
	</tk:tabs>
	<tk:tabContent tabName="Key" path="${hotFieldPath}">
	<input type="hidden" name="${hotFieldPath}.@delete" id="${hotFieldPath}.@delete" value=""/>
	<div id="${transactionFieldName}_formRow" class="formRow">
		<label class="label" id="${transactionFieldName}_labelElement" for="${transactionFieldName}">
			<span id="${transactionFieldName}_required">*</span>
			<span id="${transactionFieldName}_labelText"><acronym title="${transactionHelpText}">Transaction</acronym></span>
		</label>
		<span>
			<select id="${transactionFieldName}_inversion" name="${transactionFieldName}_inversion" class="pageEntityList_event change_event inversion">
				<c:out value="${HOTFIELDDETAILS.transactionInversion}" escapeXml="false"/>
			</select>
 		</span>
 		<span>
			<select id="${transactionFieldName}" name="${transactionFieldName}" class="pageEntityList_event change_event accordion_update"/>
				<c:out value="${HOTFIELDDETAILS.transactions}" escapeXml="false"/>
			</select>
 		</span>
	</div>
	<div id="${pageFieldName}_formRow" class="formRow">
		<label class="label" id="${pageFieldName}_labelElement" for="${pageFieldName}">
			<span id="${pageFieldName}_required">*</span>
			<span id="${pageFieldName}_labelText"><acronym title="${pageHelpText}">Page</acronym></span>
		</label>
		<span>
			<select id="${pageFieldName}_inversion" name="${pageFieldName}_inversion" class="pageEntityList_event change_event inversion">
				<c:out value="${HOTFIELDDETAILS.pageInversion}" escapeXml="false"/>
			</select>
 		</span>
 		<span>
			<select id="${pageFieldName}" name="${pageFieldName}" class="pageEntityList_event change_event accordion_update"/>
				<c:out value="${HOTFIELDDETAILS.pages}" escapeXml="false"/>
			</select>
 		</span>
	</div>
	<div id="${pageElementFieldName}_formRow" class="formRow">
		<label class="label" id=${pageElementFieldName}_labelElement" for=${pageElementFieldName}">
			<span id=${pageElementFieldName}_required">*</span>
			<span id=${pageElementFieldName}_labelText"><acronym title="${pageElementHelpText}">Section</acronym></span>
		</label>
		<span>
			<select id="${pageElementFieldName}_inversion" name="${pageElementFieldName}_inversion" class="pageEntityList_event change_event inversion">
				<c:out value="${HOTFIELDDETAILS.pageElementInversion}" escapeXml="false"/>
			</select>
 		</span>
 		<span>
			<select id="${pageElementFieldName}" name="${pageElementFieldName}" class="pageEntityList_event change_event accordion_update"/>
				<c:out value="${HOTFIELDDETAILS.pageElements}" escapeXml="false"/>
			</select>
 		</span>
	</div>
	<div id="${fieldElementFieldName}_formRow" class="formRow">
		<label class="label" id="${fieldElementFieldName}_labelElement" for="${fieldElementFieldName}">
			<span id="${fieldElementFieldName}_required">*</span>
			<span id="${fieldElementFieldName}_labelText"><acronym title="${fieldHelpText}">Field</acronym></span>
		</label>
		<span>
			<select id="${fieldElementFieldName}_inversion" name="${fieldElementFieldName}_inversion" class="hotfieldKey inversion">
				<c:out value="${HOTFIELDDETAILS.fieldElementInversion}" escapeXml="false"/>
			</select>
 		</span>
 		<span>
			<select id="${fieldElementFieldName}" name="${fieldElementFieldName}" class="hotfieldKey change_event accordion_update"/>
				<c:out value="${HOTFIELDDETAILS.fieldElements}" escapeXml="false"/>
			</select>
 		</span>
	</div>
	</tk:tabContent>
	<tk:tabContent tabName="options" path="${hotFieldPath}" styleValue="display: none">
		<c:set var="blockDataEntryPath" value="${hotFieldPath}.@blockDataEntry"/>
		<c:set var="defaultValue" value="${tk:getFieldValue(toolkitData, blockDataEntryPath, '')}"/>
		<tk:select path="${blockDataEntryPath}" label="Block Data Entry" elementName="${blockDataEntryPath}" required="" helptext="behavior_helptext|blockdataentry">
			<c:out value="${tk:getOptionsHTML(toolkitData, 'booleanFalse', hotFieldPath, defaultValue)}" escapeXml="false"/>
		</tk:select>
		<c:set var="assistantPath" value="${hotFieldPath}.@assistant"/>
		<tk:input path="${assistantPath}" label="Assistant" fieldValue="${tk:getFieldValue(toolkitData,assistantPath,'')}"
			elementName="${assistantPath}" required="" defaultValue="" size="20" className="" helptext="behavior_helptext|assistant">
		</tk:input>
	</tk:tabContent>
	<tk:tabContent tabName="refreshList" path="${hotFieldPath}" styleValue="display: none">
		<table>
			<thead>
				<tr class="refreshListPaletteRow paletteRow">
						<td class="refreshListKey" colspan="2">
							<acronym title="${tk:getOptionsListValue('behavior_helptext', 'refreshlisttransaction')}">
							Transaction
							</acronym>
						</td>
						<td class="refreshListKey" colspan="2">
							<acronym title="${tk:getOptionsListValue('behavior_helptext', 'refreshlistpage')}">
							Page
							</acronym>
						</td>

						<td class="refreshListKey" colspan="2">
							<acronym title="${tk:getOptionsListValue('behavior_helptext', 'refreshlistsection')}">
							Section
							</acronym>
						</td>
						<td class="refreshListKey" colspan="2">
							<acronym title="${tk:getOptionsListValue('behavior_helptext', 'refreshlistfield')}">
							Field
							</acronym>
						</td>
						<td class="refreshListKey">
							<acronym title="${tk:getOptionsListValue('behavior_helptext', 'refreshlistselectionhint')}">
							Selection Hint
							</acronym>
						</td>
				</tr>
			</thead>
			<tbody id="${refreshListPath}_refreshListPalette" class="refreshListPalette childPalette">
				<c:set var="refreshListCount" value="${tk:getCount(toolkitData, refreshListPath)}"/>
				<c:forEach var="count" begin="1" step="1" end="${refreshListCount}">
					<tk:setBeanContext index="${count-1}" path="${refreshListPath}[${count-1}]" />
					<c:set var="PAGEENTITYDATA" value="${PAGEENTITYLIST[count-1]}" scope="request"/>
					<jsp:include page="refreshList.jsp" >
						<jsp:param name="product" value="${param.product}"></jsp:param>
		   				<jsp:param name="artifactId" value="${param.artifactId}"></jsp:param>
					</jsp:include>
				</c:forEach>
		  	</tbody>
		  </table>
		  <div id="${refreshListPath}_addable" class="children">
			  <tkmenu:menuPill id="${refreshListPath}_behaviorPill">
				<tkmenu:menuButton id="${refreshListPath}_addRefreshList" title="Add list field to refresh" text="Add list field to refresh" classname="addNew addable refreshList"/>
		  	  </tkmenu:menuPill>
		  </div>
	</tk:tabContent>
</tk:basePalette>