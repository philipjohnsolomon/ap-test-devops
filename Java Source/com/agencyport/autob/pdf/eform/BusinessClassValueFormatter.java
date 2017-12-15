package com.agencyport.autob.pdf.eform;

import java.util.Collections;
import java.util.Map;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.FieldValue;
import com.agencyport.pdf.IFieldValueGetter;
import com.agencyport.pdf.PDFContext;
import com.agencyport.pdf.resource.FormField;
import com.agencyport.shared.APException;
import com.google.common.collect.ImmutableMap;

/**
 * The OtherValueFormatter class
 */
public class BusinessClassValueFormatter implements IFieldValueGetter {

	private static final Map<String, String> VALUES_FOR_BC_TYPE = Collections
			.unmodifiableMap(new ImmutableMap.Builder<String, String>()
					.put("1234", "Bakeries Retail and Catering")
					.put("2345", "Fuel Delivery Service")
					.put("3456", "Retail Hardware")
				    .build());

	@Override
	public FieldValue get(FormField field, PDFContext context, int[] indices,
			Map<String, String> customParams) throws APException {

		String configuredXPath = field.getXpath();

		APDataCollection dataSource = context.getAcordData();
		String value = dataSource.getFieldValue(configuredXPath, indices, null);

		FieldValue fieldValue = new FieldValue();
		// Credits Check box
		if (VALUES_FOR_BC_TYPE.containsKey(value)) {
			fieldValue.addValue(VALUES_FOR_BC_TYPE.get(value));
		}
		return fieldValue;
	}

}