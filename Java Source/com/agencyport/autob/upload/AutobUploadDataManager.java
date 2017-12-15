/*
 * Created on Mar 27, 2006 by norm AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.upload;//NOSONAR

import com.agencyport.agencyconnect.ImportDataBundle;
import com.agencyport.autob.custom.ICommlAutoConstants;
import com.agencyport.connect.conversion.distributed.AgencyConnectConversionStepData;
import com.agencyport.data.DataManager;
import com.agencyport.data.containers.AggregateDataContainer;
import com.agencyport.data.containers.PageDataContainer;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.shared.APException;
import com.agencyport.upload.UploadDataManager;
import com.agencyport.utils.text.StringUtilities;

/**
 * The CAUploadDataManager class extends the normal upload data manager
 * processing for the purposes of special handling on the vehicle page. This
 * extension ensures that the CommlRateState.StateProvCd is transferred
 * correctly regardless of whether the LocationRef is present or absent on the
 * CommlVeh. It also circumvents the use of the TDF index element for target
 * roster index calculation.
 */
public class AutobUploadDataManager extends UploadDataManager {
    /**
     * The <code>VEHICLE_PAGE_ID</code> is the id of the vehicle page.
     */
    private static final String VEHICLE_PAGE_ID = "vehicle";

    /**
     * The <code>COMML_XPath</code> is the XPath to the CommlVeh.
     */
    private static final String COMML_XPATH = "CommlAutoLineBusiness";

    /**
     * Constructs an instance. Instances cannot be shared across threads.
     * 
     * @param dataManager
     *            is the data manager to use.
     * @param input
     *            is the input data collection to use on the read side of this
     *            process.
     * @throws APException
     *             propagated from super class.
     */
    public AutobUploadDataManager(DataManager dataManager, APDataCollection input) throws APException {
        super(dataManager, input);
        this.input = input;
    }

    /**
     * Constructs an instance. Instances cannot be shared across threads. This
     * is the preferred constructor.
     * 
     * @param dataManager
     *            is the data manager to use.
     * @param input
     *            is the input data collection to use on the read side of this
     *            process.
     * @param stepData
     *            is the step data as passed from AgencyConnect.
     * @param importData 
     * @throws APException
     *             propagated from super class.
     */
    public AutobUploadDataManager(DataManager dataManager, APDataCollection input, AgencyConnectConversionStepData stepData, ImportDataBundle importData) throws APException {
        super(dataManager, input, stepData, importData);
        this.input = input;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected void update(APDataCollection output, PageDataContainer pageDataContainer) throws APException {
        if (pageDataContainer == null) {
            return;
        }
       String pageId = pageDataContainer.getPage().getId();
        if (pageId.equals(VEHICLE_PAGE_ID)) {
            // Pre-create CommlRateState aggregates so that the upcoming roster
            // update
            // will find the right aggregate. We have to do this because the TDF
            // index element
            // presumes that the CommlVeh.@LocationRef is required and always
            // present.
            // This is a faulty assumption for uploads because many vehicles on
            // AUTOB PDFs do not
            // have an explicit LocationRef established.
            for (int[] indices : input.createIndexTraversalBasis(ICommlAutoConstants.COMML_RATE_STATE_XPATH)) {
                String id = input.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_XPATH + ".@id", indices, "");
                String stateCd = input.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH, indices, "");
                if (!StringUtilities.isEmpty(stateCd)) {
                    output.setFieldValue(ICommlAutoConstants.COMML_RATE_STATE_XPATH + "[StateProvCd='" + stateCd + "'].@id", indices, id);
                
                
                String stateId = input.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH + ".@id" , indices, "");
                if (!StringUtilities.isEmpty(stateId)) {
                    output.setFieldValue(ICommlAutoConstants.COMML_RATE_STATE_XPATH + "[StateProvCd='" + stateCd + "'].StateProvCd.@id", indices, stateId);
                }
                }
                
            }

            int count = input.getCount(COMML_XPATH);
            for (int i = 0; i < count; i++) {
                String commlId = input.getFieldValue(COMML_XPATH + ".@id", i, "");
                if (!StringUtilities.isEmpty(commlId)) {
                    output.setFieldValue(COMML_XPATH + ".@id", i, commlId);
                }
            }
        }

        // delegate the rest of work to the super
        super.update(output, pageDataContainer);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected boolean useIndexElementForIndexCalculation(APDataCollection target, PageDataContainer pageDataContainer,
            AggregateDataContainer aggregateDataContainer) {
        String pageId = pageDataContainer.getPage().getId();
        if (pageId.equals(VEHICLE_PAGE_ID)) {
            // If the LocationRef is not there then we tell the framework that
            // we don't want to use the index element for target roster index
            // calculation because
            // this index element since it presumes that the location reference
            // is always present which is a false assumption on some uploaded
            // CommlVeh aggregates.
            String locationRef = aggregateDataContainer.getHTMLDataContainer().getStringValue("CommlAutoLineBusiness.CommlRateState.CommlVeh.@LocationRef",
                    null);
            if (StringUtilities.isEmptyOnTrim(locationRef)) {
                return false;
            }
        }
        return super.useIndexElementForIndexCalculation(target, pageDataContainer, aggregateDataContainer);
    }
}
