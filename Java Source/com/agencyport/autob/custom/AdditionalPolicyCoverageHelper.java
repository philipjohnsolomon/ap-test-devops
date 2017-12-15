/**
 * July 1, 2007  @author Sathish, Agencyport Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import com.agencyport.domXML.APDataCollection;
import com.agencyport.utils.ArrayHelper;

/**
 * The AdditionalPolicyCoverageHelper class centralizes how optional coverages
 * are determined to be present.
 */
public final class AdditionalPolicyCoverageHelper {

    /**
     * The <code>OPTIONAL_COVERAGE_AGGREGATES</code> contains the XPaths for all
     * of the supplemental coverages.
     */
    private static final String[] OPTIONAL_COVERAGE_AGGREGATES = buildOptionalCoveragesFields(ICommlAutoConstants.COMML_RATE_STATE_OPTIONAL_COVERAGES_XPATH);

    /**
     * The <code>PREMIUM_MODIFICATION_COVERAGE_FIELDS</code> contains the list
     * of coverage fields on the premium modification page.
     */
    private static final String[] PREMIUM_MODIFICATION_COVERAGE_FIELDS = buildPremiumModificationFields(ICommlAutoConstants.COMML_RATE_STATE_PREMIUM_MODIFICATION_XPATH);

    /**
     * The <code>SUPPLEMENTAL_COVERAGE_FIELDS</code> contains the XPaths for all
     * of the supplemental coverages.
     */
    private static final String[] SUPPLEMENTAL_COVERAGE_FIELDS = buildSupplementalCoveragesFields(ICommlAutoConstants.COMML_RATE_STATE_OPTIONAL_COVERAGES_XPATH);

    /**
     * Prevent accidental construction.
     */
    private AdditionalPolicyCoverageHelper() {

    }

    /**
     * Builds the supplemental coverages field xpath table.
     * 
     * @param prependValue
     *            is the common initial XPath portion.
     * @return the supplemental coverages field xpath table.
     */
    private static String[] buildSupplementalCoveragesFields(String prependValue) {
        final String[] supplementalCoverageFields = {
                ".CommlCoverage[CoverageCd='BPIP']",
                ".CommlCoverage[CoverageCd='OBEL']",
                ".CommlCoverage[CoverageCd='MEXCO']",
                ".CommlCoverage[CoverageCd='INLW']",
                ".CommlCoverage[CoverageCd='POLUT']",
                ".CommlCoverage[CoverageCd='FELIA']",
                ".CommlCoverage[CoverageCd='LUSE']"
        };
        return ArrayHelper.createStringTable(prependValue, supplementalCoverageFields);
    }

    /**
     * Builds the optional coverages field xpath table.
     * 
     * @param prependValue
     *            is the common initial XPath portion.
     * @return the optional coverages field xpath table.
     */
    private static String[] buildOptionalCoveragesFields(String prependValue) {
        final String[] supplementalCoverageFields = {
                ".CommlAutoHiredInfo",
                ".CommlAutoNonOwnedInfo",
                ".CommlAutoDriveOtherCarInfo"
        };
        return ArrayHelper.createStringTable(prependValue, supplementalCoverageFields);

    }

    /**
     * Builds the premium modification field xpath table.
     * 
     * @param prependValue
     *            is the common initial XPath portion.
     * @return the premium modification field xpath table.
     */
    private static String[] buildPremiumModificationFields(String prependValue) {
        final String[] supplementalCoverageFields = {
                ".CommlCoverage[CoverageCd='LIEXP']",
                ".CommlCoverage[CoverageCd='PDEXP']",
                ".CommlCoverage[CoverageCd='LISCH']",
                ".CommlCoverage[CoverageCd='PDSCH']"
        };
        return ArrayHelper.createStringTable(prependValue, supplementalCoverageFields);
    }

    /**
     * Return true if any optional or supplemental coverages exist.
     * 
     * @param data
     *            is the data collection for the work item.
     * @param index
     *            is the index for the comml rate state.
     * @return true if any optional or supplemental coverages exist.
     */
    public static boolean hasAdditionalCovDataAvailable(APDataCollection data, int[] index) {
        // Checking for only aggregate existing or not.
        for (String optionalCoverageXPath : OPTIONAL_COVERAGE_AGGREGATES) {
            if (data.exists(optionalCoverageXPath, index)) {
                return true;
            }
        }

        if (hasSupplementalCoverageDataAvailable(data, index)) {
            return true;
        }

        return false;
    }

    /**
     * Returns true if at least one supplemental coverage has been selected
     * 
     * @param data
     *            is the data collection for the work item.
     * @param index
     *            is the index for the comml rate state.
     * @return true if at least one supplemental coverage has been selected
     */
    private static boolean hasSupplementalCoverageDataAvailable(APDataCollection data, int[] index) {
        for (String supplementalCoverageXPath : SUPPLEMENTAL_COVERAGE_FIELDS) {
            if (data.exists(supplementalCoverageXPath, index)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Return the true if one or more coverages on the premium modification page
     * are present.
     * 
     * @param data
     *            is the data collection for the work item.
     * @param index
     *            is the index for the comml rate state.
     * @return the true if one or more coverages on the premium modification
     *         page are present.
     */
    public static boolean isPremiumModDataAvailable(APDataCollection data, int[] index) {
        for (String coverageXPath : PREMIUM_MODIFICATION_COVERAGE_FIELDS) {
            if (data.exists(coverageXPath, index)) {
                return true;
            }
        }

        return false;
    }

}
