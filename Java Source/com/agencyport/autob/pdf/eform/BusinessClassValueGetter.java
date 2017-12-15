/*
 * Created on Feb 1, 2016 by ktamma AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.pdf.eform;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import com.agencyport.pdf.PDFContext;
import com.agencyport.pdf.resource.FormField;
import com.agencyport.shared.pdf.eform.OtherCheckboxValueGetter;
import com.agencyport.utils.ArrayHelper;

/**
 * The Class of business value class
 */
public class BusinessClassValueGetter extends OtherCheckboxValueGetter{
	
	/**
	 * The <code>VALUES_FOR_APIP</code>
	 */
	
	private static final Set<String> VALUES_FOR_BC = Collections.unmodifiableSet(new HashSet<String>(ArrayHelper.createImmutableList(
			"1234",
			"2345",
			"3456"
			)));
	
	@Override
	protected boolean shouldRenderValue(String value, FormField field, PDFContext context, int[] indices) {
		return VALUES_FOR_BC.contains(value);
	}

}
