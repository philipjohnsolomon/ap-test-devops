/*
 * Created on May 18, 2015 by cmartin AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.domXML.APDataCollection;
import com.agencyport.service.text.StringUtilities;
import com.agencyport.shared.custom.AlternateSearchIdView;
import com.agencyport.webshared.HTMLDataContainer;
import com.agencyport.workitem.context.WorkItemContextStore;

/**
 * Custom view to control the Stacking Option ACORD path based on the selected
 * UM limit option (CSL or Split). The stacking option itself resides under
 * either UMCSL or UMISP Coverage.
 */
public class VehicleUMStackingView extends AlternateSearchIdView {
    /**
     * The <code>serialVersionUID</code>
     */
    private static final long serialVersionUID = -4232925805285945026L;

    /**
     * {@inheritDoc}
     */
    @Override
    public void update(APDataCollection apData, int[] idArray, String valueIn, String associatedElementPath) {
        HTMLDataContainer htmlDC = WorkItemContextStore.get().getHtmlDataContainer();

        String value = valueIn;
        if (htmlDC == null) {

            String umOption = apData.getFieldValue("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMCSL'].CoverageCd", idArray, "");
            if (StringUtilities.isEmpty(umOption)) {
                umOption = apData.getFieldValue("CommlAutoLineBusiness.CommlRateState.CommlVeh.CommlCoverage[CoverageCd='UMISP'].CoverageCd", idArray, "");
            }

            /*
             * The stacking option is wholly dependent on the selected UM option
             * because the stacking option must reside on either the UMCSL
             * coverage or the UMISP coverage. If there is no UM Option selected
             * we need to pass and empty value to the base method to force this
             * view to perform a delete. Otherwise the view will write out the
             * OptionCd again to whatever Coverage aggregate it was previously
             * on; preventing full data cleanup. This occurs when toggling
             * coverage options.
             */
            if (StringUtilities.isEmpty(umOption)) {
                value = "";
            }

            super.update(apData, idArray, value, umOption, associatedElementPath);

        } else {
            super.update(apData, idArray, value, associatedElementPath);
        }
    }
}
