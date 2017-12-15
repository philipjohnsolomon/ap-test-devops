/*
 * Created on Aug 12, 2015 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.pdf.eform;

import java.util.Map;

import com.agencyport.pdf.FieldValue;
import com.agencyport.pdf.IFieldValueGetter;
import com.agencyport.pdf.PDFContext;
import com.agencyport.pdf.resource.FormField;
import com.agencyport.shared.APException;

/**
 * The OtherCheckboxValueGetter class provides a way to support the "Other" check box
 * on PDF ACORD eForms that follows a set of other check boxes wherein an AgencyPortal list has more values 
 * than the previous check boxes on the ACORD form can accommodate.   
 */
public abstract class OtherCheckboxValueGetter implements IFieldValueGetter {

	/**
	 * Constructs an instance.
	 */
	public OtherCheckboxValueGetter() {
	}

	/** 
	 * {@inheritDoc}
	 */

	@Override
	public final FieldValue get(FormField field, PDFContext context, int[] indices, Map<String, String> customParams) throws APException {
		FieldValue fieldValue = new FieldValue(); 
		String value = context.getAcordData().getFieldValue(context.getXpath(field), indices, "");
		if (shouldRenderValue(value, field, context, indices)){
			value = context.getDataProcessor().normalizeValue(field, value);
			fieldValue.addValue(value);
		}
		return fieldValue;
	}
	
	/**
	 * Returns whether or not the value should be rendered or not.
	 * @param value is the value under consideration.
	 * @param field is the PDF form field.
	 * @param context is the current context.
	 * @param indices are the indices for repeating values.
	 * @return true if the value should be rendered.
	 */
	protected abstract boolean shouldRenderValue(String value, FormField field, PDFContext context, int[] indices);

}
