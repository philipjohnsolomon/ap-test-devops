/*
 * Created on Apr 1, 2014 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import java.util.Map;

import org.jdom2.Element;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.view.Field;
import com.agencyport.domXML.view.FieldSet;
import com.agencyport.domXML.view.View;
import com.agencyport.shared.APException;
import com.agencyport.shared.custom.CustomViewParser;
import com.agencyport.utils.text.StringUtilities;
import com.agencyport.webshared.HTMLDataContainer;
import com.agencyport.workitem.context.WorkItemContextStore;

/**
 * The OtherThanCollisionCoverageView class handles the other than coverages
 * I/O.
 * 
 * @since 5.0 replacement for old SFHs HiredAutoOTCHelper and SymbolFieldHelper.
 */
public class OtherThanCollisionCoverageView extends View {

    /**
     * The <code>serialVersionUID</code>
     */
    private static final long serialVersionUID = 386745164522195887L;
    /**
     * The <code>CUSTOM_ARGUMENT_NAME</code> a constant for the custom argument
     * name attribute value this class requires. This should be the field id of
     * the OTC coverage.
     */
    private static final String CUSTOM_ARGUMENT_NAME = "htmlCoverageCodeFieldId";

    /**
     * The <code>htmlCoverageCodeFieldId</code> is the HTML data container field
     * id associated with the current coverage code value.
     */
    private String htmlCoverageCodeFieldId;

    /**
     * The <code>deductibleFieldsets</code> is a parallel set of field sets that
     * have had their field ids changed from .CoverageCd to
     * .Deductible.FormatInteger.
     */
    private FieldSet[] deductibleFieldsets;

    /**
     * Constructs and instance.
     */
    public OtherThanCollisionCoverageView() {
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void init(Element viewElement) throws APException {
        super.init(viewElement);
        Map<String, String> customArguments = CustomViewParser.parseView(viewElement, false, CUSTOM_ARGUMENT_NAME);
        htmlCoverageCodeFieldId = customArguments.get(CUSTOM_ARGUMENT_NAME);
        deductibleFieldsets = new FieldSet[this.fieldSets.length];
        try {
            // Change all coverage code element names to
            // Deductible.FormatInteger
            for (int fieldSetIndex = 0; fieldSetIndex < this.fieldSets.length; fieldSetIndex++) {
                this.deductibleFieldsets[fieldSetIndex] = (FieldSet) this.fieldSets[fieldSetIndex].clone();
                Field[] fields = this.deductibleFieldsets[fieldSetIndex].getFieldSet();
                for (Field field : fields) {
                    String deductibleFieldId = field.getFieldId().replace(".CoverageCd", ".Deductible.FormatInteger");
                    field.setFieldId(deductibleFieldId);
                }
            }

        } catch (CloneNotSupportedException cnse) {
            throw new APException(cnse);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void update(APDataCollection apData, int[] indices, String value, String associatedElementPath) {
        if (associatedElementPath.contains("Deductible")) {
            handleDeductibleAmountUpdate(apData, indices, value);
        } else {
            super.update(apData, indices, value, associatedElementPath);
        }
    }

    /**
     * Updates the deductible amount.
     * 
     * @param apData
     *            is the data collection in context.
     * @param indices
     *            are the indices to apply to the data collection.
     * @param value
     *            is the value to apply to the data collection.
     */
    private void handleDeductibleAmountUpdate(APDataCollection apData, int[] indices, String value) {
        if (StringUtilities.isEmptyOnTrim(value)) {
            // deletion of parent aggregate assumed to be handled by the
            // call into this view for the coverage code and not the
            // delete element
            return;
        }
        // Look up the coverage code value from the HTML data container
        HTMLDataContainer htmlDataContainer = WorkItemContextStore.get().getHtmlDataContainer();
        if (htmlDataContainer == null) {
            throw new IllegalStateException("HTML data container missing from work item context store but is needed by this view.");
        }
        String htmlCoverageCodeValue = htmlDataContainer.getStringValue(htmlCoverageCodeFieldId, null);
        if (StringUtilities.isEmptyOnTrim(htmlCoverageCodeValue)) {
            // no update needed
            return;
        }
        int fieldSetIndex = this.determineFieldSetFromInputValue(htmlCoverageCodeValue);
        deductibleFieldsets[fieldSetIndex].update(apData, indices, value);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String read(APDataCollection apData, int[] indices, String defaultValue, String associatedElementPath)
            throws APException {
        if (associatedElementPath.contains("Deductible")) {
            return read(deductibleFieldsets, apData, indices, defaultValue, associatedElementPath);
        } else {
            return super.read(apData, indices, defaultValue, associatedElementPath);
        }
    }

}
