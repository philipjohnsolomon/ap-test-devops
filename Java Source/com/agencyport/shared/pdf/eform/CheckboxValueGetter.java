/*
 * Created on Feb 1, 2016 by ktamma AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.pdf.eform;

import com.agencyport.fieldvalidation.validators.BaseValidator;
import com.agencyport.pdf.PDFContext;
import com.agencyport.pdf.resource.FormField;

/**
 * The CheckboxValueGetter class
 */
public class CheckboxValueGetter extends OtherCheckboxValueGetter{

	@Override
	protected boolean shouldRenderValue(String value, FormField field, PDFContext context, int[] indices) {
		
		return !BaseValidator.checkIsEmpty(value);
	}

}
