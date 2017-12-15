/*
 * Created on July 14, 2015 by zhe AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.pdf.eform;

import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.agencyport.api.workitemassistant.pojo.CommentEntry;
import com.agencyport.database.provider.DatabaseResourceAgent;
import com.agencyport.logging.LoggingManager;
import com.agencyport.pdf.FieldValue;
import com.agencyport.pdf.IFieldValueGetter;
import com.agencyport.pdf.PDFContext;
import com.agencyport.pdf.resource.FormField;
import com.agencyport.shared.APException;
import com.agencyport.workitemassistant.WorkitemAssistantOperationProvider;


/**
 * WorkItemAssistantCommentFieldValueGetter will get all the remarks
 *
 */
public class WorkItemAssistantCommentFieldValueGetter implements IFieldValueGetter {

	/**
	 * construct a new instance
	 */
	public WorkItemAssistantCommentFieldValueGetter() {
	}

	/**
	 * The <code>LOGGER</code>is my Logger.
	 */
	private static final Logger LOGGER = LoggingManager.getLogger(
			WorkItemAssistantCommentFieldValueGetter.class.getPackage().getName());
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public FieldValue get(FormField field, PDFContext context, int[] indices, Map<String, String> customParams) {

		DatabaseResourceAgent dra = new DatabaseResourceAgent(this);
		WorkitemAssistantOperationProvider provider = new WorkitemAssistantOperationProvider();
		StringBuilder builder = new StringBuilder();
		
		try {
			List<CommentEntry> comments = provider.listComments(dra, context.getWorkItem().getWorkItemId().intValue());
			for(CommentEntry entry : comments){
				builder.append(entry.getComment());
				builder.append("\n");
			}
		} catch (APException e) {
			LOGGER.log(Level.FINE,e.getMessage(), e);
		}finally{
			dra.closeDatabaseResources(this);
		}
		FieldValue value = new FieldValue();
		value.addValue(builder.toString());
		return value;
	}

}
