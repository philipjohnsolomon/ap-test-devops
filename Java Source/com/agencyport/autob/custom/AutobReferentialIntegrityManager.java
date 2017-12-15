/*
 * Created on Jan 6, 2010 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.data.ComprehensiveReferentialIntegrityManager;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.ElementPathExpression;
import com.agencyport.fieldvalidation.validators.BaseValidator;
import com.agencyport.shared.APException;
import com.agencyport.webshared.IWebsharedConstants;
import com.agencyport.xpath.XPathException;

/**
 * The CommlAutoReferentialIntegrityManager class supports the invalidation of
 * CommlVeh.@LocationRefs which point to existing Location aggregates whose
 * state codes have changed.
 */
public class AutobReferentialIntegrityManager extends ComprehensiveReferentialIntegrityManager {
    /**
     * The <code>COMMLVEH_PATH</code> is the complied XPath for
     * CommlAutoLineBusiness.CommlRateState
     */
    private static final ElementPathExpression COMMLVEH_PATH = new ElementPathExpression(ICommlAutoConstants.COMML_RATE_STATE_XPATH);

    /**
     * {@inheritDoc}
     */
    @Override
    protected void runPreApplyProcessing(APDataCollection dataCollection) throws APException {
        if (!this.maintainDependentIndices()) {
            int dataAccessType = getVariables().getDataAccessType();
            if (dataAccessType == IWebsharedConstants.DATA_ACCESS_TYPE_UPDATE) {
                invalidateInvalidLocationRefs(dataCollection);
            }
        }
        super.runPreApplyProcessing(dataCollection);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected void runPostApplyProcessing(APDataCollection dataCollection) throws APException {
        maintainSymbolIntegrity(dataCollection);
        super.runPostApplyProcessing(dataCollection);
    }

    /**
     * Symbols are selected on the Policy Coverage page, but live under a
     * foreign CommlPolicy aggregate. Because of this foreign aggregate
     * relationship they are not automatically cleaned up when deleting
     * CommlRateState aggregates. This method cleans up any orphaned symbols
     * based on changes to the underlying ACORD data.
     * <p>
     * This logic must match any include/exclude symbol field behaviors
     * 
     * @param dataCollection
     *            - The data collection to update
     */
    protected void maintainSymbolIntegrity(APDataCollection dataCollection) throws APException {

        // Clean up the symbols if all CommlRateState aggregates are deleted
        if (dataCollection.getCount("CommlAutoLineBusiness.CommlRateState") == 0) {
            dataCollection.deleteElementIfExists("CommlAutoLineBusiness.CoveredAutoSymbol");
        } else {

            // Run State specific logic
            //maintainPIPNoFaultSymbolCd(dataCollection);
            maintainMassCommlAutoSymbolIntegrity(dataCollection);
            maintainMichiganCommlAutoSymbolIntegrity(dataCollection);
            maintainNewYorkCommlAutoSymbolIntegrity(dataCollection);
            maintainPennsylvaniaCommlAutoSymbolIntegrity(dataCollection);
        }
    }

    /**
     * Cleans up the data collection in the event a CommlRateState aggregate is
     * deleted. The (basic) PIP symbol only applies to some states. When these
     * State(s) are deleted the symbol must be cleaned up.
     * 
     * @param dataCollection
     *            - The data collection to update
     */
    protected void maintainPIPNoFaultSymbolCd(APDataCollection dataCollection) throws APException {

        try {
            if (dataCollection.selectNodes(
                    "CommlAutoLineBusiness/CommlRateState[contains('AK:DC:FL:HI:KS:KY:MD:MI:MN:NJ:NY:ND:OR:TX:UT:WA', StateProvCd)]").isEmpty()) {
                deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.PIPNoFaultSymbolCd");
            }
        } catch (XPathException xpathEx) {
            throw new APException("Failure executing xpath durign PIPNoFaultSymbolCd cleanup routine", xpathEx);
        }
    }

    /**
     * Cleans up the data collection in the event a MA CommlRateState aggregate
     * is deleted. There are two Mass State specific symbols which must be
     * removed from the data collection in this event.
     * 
     * @param dataCollection
     *            - The data collection to update
     */
    protected void maintainMassCommlAutoSymbolIntegrity(APDataCollection dataCollection) {

        if (dataCollection.getCount("CommlAutoLineBusiness.CommlRateState[StateProvCd='MA']") == 0) {
            // Clean up the symbols which only display when Mass is included
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.DamageToSomeoneElsesPropertySymbolCd");
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.OptionalBodilyInjuryToOthersSymbolCd");
        }
    }

    /**
     * Cleans up the data collection in the event a MI CommlRateState aggregate
     * is deleted. There are two Michigan State specific symbols which must be
     * removed from the data collection in this event.
     * 
     * @param dataCollection
     *            - The data collection to update
     */
    protected void maintainMichiganCommlAutoSymbolIntegrity(APDataCollection dataCollection) {

        if (dataCollection.getCount("CommlAutoLineBusiness.CommlRateState[StateProvCd='MI']") == 0) {
            // Clean up the symbols which only display when PA is included
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.LimitedPropertyDamageLiabilitySymbolCd");
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.PropertyProtectionCoverageSymbolCd");
        }
    }

    /**
     * Cleans up the data collection in the event a NY CommlRateState aggregate
     * is deleted. There are four New York State specific symbols which must be
     * removed from the data collection in this event.
     * 
     * @param dataCollection
     *            - The data collection to update
     */
    protected void maintainNewYorkCommlAutoSymbolIntegrity(APDataCollection dataCollection) {

        if (dataCollection.getCount("CommlAutoLineBusiness.CommlRateState[StateProvCd='NY']") == 0) {
            // Clean up the symbols which only display when PA is included
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.OBELSymbolCd");
            //deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.APIPSymbolCd");
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.WorkLossCoordinationSymbolCd");
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.MedicalExpenseEliminationSymbolCd");
        }
    }

    /**
     * Cleans up the data collection in the event a PA CommlRateState aggregate
     * is deleted. There are three Pennsylvania State specific symbols which
     * must be removed from the data collection in this event.
     * 
     * @param dataCollection
     *            - The data collection to update
     */
    protected void maintainPennsylvaniaCommlAutoSymbolIntegrity(APDataCollection dataCollection) {

        if (dataCollection.getCount("CommlAutoLineBusiness.CommlRateState[StateProvCd='PA']") == 0) {
            // Clean up the symbols which only display when PA is included
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.FirstPartyBenefitsSymbolCd");
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.CombinationFirstPartyBenefitsSymbolCd");
            deleteAllSymbols(dataCollection, "CommlAutoLineBusiness.CoveredAutoSymbol.ExtraordinaryMedicalBenefitsSymbolCd");
        }
    }

    /**
     * Removes all instances of a particular symbol code. In ACORD, if a user
     * chooses a multi-symbol option such as "1, 3 and 7" there will be multiple
     * instances of the same symbol code element under the
     * CommlAutoLineBusiness.CoveredAutoSymbol aggregate. This method will
     * iterate over the provided path, and remove ALL occurrences.
     * <p>
     * Example Schema:
     * <p>
     * &lt;CommlAutoLineBusiness&gt; <br>
     * &nbsp;&nbsp;&lt;CoveredAutoSymbol&gt; <br>
     * &nbsp;&nbsp;&nbsp;&nbsp;&lt;DamageToSomeoneElsesPropertySymbolCd&gt;1&lt;
     * /DamageToSomeoneElsesPropertySymbolCd&gt; <br>
     * &nbsp;&nbsp;&nbsp;&nbsp;&lt;DamageToSomeoneElsesPropertySymbolCd&gt;3&lt;
     * /DamageToSomeoneElsesPropertySymbolCd&gt; <br>
     * &nbsp;&nbsp;&nbsp;&nbsp;&lt;DamageToSomeoneElsesPropertySymbolCd&gt;7&lt;
     * /DamageToSomeoneElsesPropertySymbolCd&gt; <br>
     * &nbsp;&nbsp;&lt;CoveredAutoSymbol&gt; <br>
     * &lt;/CommlAutoLineBusiness&gt;
     * 
     * @param dataCollection
     *            - The data collection to update
     * @param path
     *            - The full symbol path
     */
    protected void deleteAllSymbols(APDataCollection dataCollection, String path) {

        while (dataCollection.exists(path)) {
            dataCollection.deleteElementIfExists(path);
        }
    }

    /**
     * Removes location ref attributes on the CommlVeh whose rate states don't
     * match the state codes on related location Location aggregate.
     * 
     * @param dataCollection
     *            is the work item XML data collection.
     */
    private void invalidateInvalidLocationRefs(APDataCollection dataCollection) {
        for (int[] indices : dataCollection.createIndexTraversalBasis(COMMLVEH_PATH)) {

            String locationRef = dataCollection.getAttributeText(COMMLVEH_PATH, indices, "LocationRef");
            if (BaseValidator.checkIsEmpty(locationRef)) {
                continue;
            }

            String parentStateCode = dataCollection.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH, indices, null);
            if (!BaseValidator.checkIsEmpty(parentStateCode)) {
                String relatedStateCode = dataCollection.getFieldValue("Location[@id='" + locationRef + "'].Addr.StateProvCd", null);
                if (!parentStateCode.equals(relatedStateCode)) {
                    dataCollection.deleteAttribute(COMMLVEH_PATH.getExpressionWithOnlyElementHierarchy(), indices, "LocationRef");
                }
            }

        }
    }

}
