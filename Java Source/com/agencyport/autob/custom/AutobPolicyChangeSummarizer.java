/**
 * Created on Oct 17, 2007 by Sathish / AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.data.DataManager;
import com.agencyport.domXML.changemanagement.MergeManager;
import com.agencyport.domXML.changemanagement.ModInfoGroup;
import com.agencyport.pagebuilder.Page;
import com.agencyport.policysummary.changemanagement.PolicyChangeSummarizer;
import com.agencyport.shared.APException;
import com.agencyport.trandef.Transaction;
import com.agencyport.trandef.TransactionDefinitionManager;

/**
 * The ComercialAutoPolicyChangeSummarizer class provides a few special handlers
 * for the aggregate description portion for a couple of the aggregate eye
 * catchers.
 */
public class AutobPolicyChangeSummarizer extends PolicyChangeSummarizer {

    /**
     * Constructs an instance. You cannot and should not share an instance
     * across threads.
     * 
     * @param mergeManager
     *            is the merge manager for this data collection. This can be
     *            null and if it is null an assumption is made that this
     *            framework is being used to render a policy summary view of a
     *            new business transaction.
     * @param dataManager
     *            is the data manager.
     * @param defaultReturnValueWhenNotPresent
     *            is the default value to use when the XML value is not
     *            available.
     * @param defaultDisplayDateFormat
     *            is the default display date format.
     * @param defaultXMLStorageDateFormat
     *            is the default date format for who dates are stored.
     * @param policyAggregateName
     *            is the policy XML aggregate name
     * @throws APException
     *             propagated base class.
     */
    public AutobPolicyChangeSummarizer(MergeManager mergeManager,
            DataManager dataManager, String defaultReturnValueWhenNotPresent,
            String defaultDisplayDateFormat,
            String defaultXMLStorageDateFormat, String policyAggregateName) throws APException {
        super(mergeManager, dataManager, defaultReturnValueWhenNotPresent,
                defaultDisplayDateFormat, defaultXMLStorageDateFormat,
                policyAggregateName);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getAggregateDescription(ModInfoGroup group) {
        String lastElementName = super.getAggregateDescription(group);
        if (ICommlAutoConstants.COMML_RATE_STATE_OPTIONAL_COVERAGES_XPATH.endsWith(lastElementName)) {
            return getAggregateDescription(ICommlAutoConstants.POLICY_COV_PAGE);
        } else if (ICommlAutoConstants.COMML_RATE_STATE_PREMIUM_MODIFICATION_XPATH.endsWith(lastElementName)) {
            return getAggregateDescription(ICommlAutoConstants.PREM_MOD_PAGE);
        } else {
            return lastElementName;
        }
    }

    /**
     * Gets the description of the aggregate by using the related page
     * configuration in the TDF.
     * 
     * @param pageId
     *            is the page id.
     * @return the description of the aggregate.
     */
    private String getAggregateDescription(String pageId) {
        Transaction transaction = TransactionDefinitionManager.getTransaction(this.workItem.getTransactionId(), this.workItem.getVersion());
        Page page = transaction.getPage(pageId);
        return page.getTitle();
    }
}
