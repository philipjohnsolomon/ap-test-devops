/**
 * Created on February 6, 2012 /  Agencyport Software
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.view.AggregateExistsBooleanView;
import com.agencyport.logging.ExceptionLogger;
import com.agencyport.xpath.XPathException;

/**
 * The CustomOBELView class
 */
public class OBELCoverageView extends AggregateExistsBooleanView {

    /**
     * The <code>serialVersionUID</code>
     */
    private static final long serialVersionUID = -7686516900997161367L;
    /**
     * The <code>STATE_LEVEL_OBEL_LIMIT</code> is the XPath for the state level
     * OBEL coverage.
     */
    private static final String STATE_LEVEL_OBEL_LIMIT_XPATH = ICommlAutoConstants.COMML_RATE_STATE_OPTIONAL_COVERAGES_XPATH
            + ".CommlCoverage[CoverageCd='OBEL']";

    /**
     * Constructs an instance.
     */
    public OBELCoverageView() {
        super();
    }

    /**
     * {@inheritDoc} Extend the base class's update method. Check to see if this
     * is the last OBEL coverage for the vehicles under this state.
     */
    @Override
    public void update(APDataCollection apData, int[] indices, String value, String associatedElementPath) {
        super.update(apData, indices, value, associatedElementPath);
        if (!isTrueValue(value)) {
            try {
                String searchOBELOnAllVehiclesInStateXPath = "CommlAutoLineBusiness/CommlRateState[position()=" + (indices[0] + 1)
                        + "]/CommlVeh/CommlCoverage[CoverageCd='OBEL']";
                // If this is the last OBEL limit on this vehicle then we will
                // delete the one at the state level.
                if (apData.selectSingleNode(searchOBELOnAllVehiclesInStateXPath) == null && apData.exists(STATE_LEVEL_OBEL_LIMIT_XPATH, indices)) {
                    apData.deleteElement(STATE_LEVEL_OBEL_LIMIT_XPATH, indices);
                }
            } catch (XPathException e) {
                ExceptionLogger.log(e, this.getClass(), "update");
                throw new IllegalStateException(e);
            }
        }
    }

}
