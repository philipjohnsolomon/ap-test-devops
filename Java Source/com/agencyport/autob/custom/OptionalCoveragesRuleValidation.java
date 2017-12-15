package com.agencyport.autob.custom;//NOSONAR

import java.util.Properties;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.domXML.Index;
import com.agencyport.domXML.index.IIndexManager;
import com.agencyport.domXML.index.IndexStore;
import com.agencyport.utils.text.CoreVariableSubstitutor;
import com.agencyport.xarc.evaluate.ICustomCondition;
import com.agencyport.xarc.evaluate.ResultNode;

/**
 * The OptionalCoveragesRuleValidation class checks to see if the optional
 * coverages or premium modification aggregate for comml rate state in context
 * is already on the previous document. If so, this means the user is attempting
 * to add one of these aggregates to a state that already has it.
 */
public class OptionalCoveragesRuleValidation implements ICustomCondition {

    /**
     * The <code>STATE</code> a constant used in the related Xarc rule markup.
     */
    private static final String STATE = "state";

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean evaluate(ResultNode aggregateResult) {
        APDataCollection apData = aggregateResult.getOriginalApdata();
        String ruleState = aggregateResult.getVariableValue(STATE, null);
        IIndexManager indexMgr = IndexStore.getIndexManager();
        Index index = indexMgr.getCurrentIndex(ICommlAutoConstants.COMML_RATE_STATE_XPATH);
        String state = apData.getFieldValue(ICommlAutoConstants.COMML_RATE_STATE_PROV_CD_XPATH, index.getIdArray(), null);
        if (ruleState.equals(state)) {
            int restoreView = apData.changeViewType(IXMLConstants.VIEW_PREVIOUS_DOCUMENT);
            try {
                CoreVariableSubstitutor variableSubstitutor = CoreVariableSubstitutor.getStandardVariableSubstitor();
                Properties props = new Properties();
                props.put(STATE, ruleState);
                String aggregateToCheck = aggregateResult.getVariableValue("aggregateToCheck", null);
                aggregateToCheck = variableSubstitutor.applyVariableSubstitutions(aggregateToCheck, props);
                return apData.exists(aggregateToCheck);
            } finally {
                apData.changeViewType(restoreView);
            }
        } else {
            return false;
        }
    }

}
