/**
 * Created on May 8, 2007 by Sathish Sundaramurthy /  AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.view.AggregateExistsBooleanView;

/**
 * The AggregateExistsWithValueBooleanView class accommodates a data value to be
 * used in combination with the notion of the normal AggregateExistsBooleanView
 */
public class AggregateExistsWithValueBooleanView extends AggregateExistsBooleanView {

    /**
     * The <code>serialVersionUID</code>
     */
    private static final long serialVersionUID = -5806705005646887805L;

    /**
     * Constructs an instance.
     */
    public AggregateExistsWithValueBooleanView() {
        super();
    }

    /**
     * {@inheritDoc} Extend the base class's update method to create the new
     * element and add a value to that element
     */
    @Override
    public void update(APDataCollection apData, int[] indices, String value, String associatedElementPath) {
        if (isTrueValue(value)) {
            // Now set the value
            apData.setFieldValue(associatedElementPath, indices, value);
        } else {
            apData.deleteElement(associatedElementPath, indices);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String read(APDataCollection apData, int[] indices, String defaultValue, String associatedElementPath) {
        return apData.getFieldValue(associatedElementPath, indices, defaultValue);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void delete(APDataCollection apData, int[] indices, String associatedElementPath) {
        apData.deleteElement(associatedElementPath, indices);
    }

}
