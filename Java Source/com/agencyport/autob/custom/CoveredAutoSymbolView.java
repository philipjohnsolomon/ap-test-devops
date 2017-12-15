/*
 * Created on Mar 31, 2014 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.custom;//NOSONAR

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Logger;

import org.jdom2.Element;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.view.Field;
import com.agencyport.domXML.view.FieldSet;
import com.agencyport.domXML.view.View;
import com.agencyport.html.optionutils.OptionEntry;
import com.agencyport.html.optionutils.OptionList;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.logging.LoggingManager;
import com.agencyport.shared.APException;
import com.agencyport.shared.custom.CustomViewParser;
import com.agencyport.utils.ArrayHelper;
import com.agencyport.utils.text.StringUtilities;

/**
 * The CoveredAutoSymbolView class handles the I/O for commercial auto covered
 * auto symbols.
 * 
 * @since 5.0 replacement for old SFH SymbolFieldHelper
 */
public class CoveredAutoSymbolView extends View {
    /**
     * The <code>serialVersionUID</code>
     */
    private static final long serialVersionUID = -1298476322818250534L;
    /**
     * The <code>LOGGER</code> is a reference to our logger.
     */
    private static final Logger LOGGER = LoggingManager.getLogger(CoveredAutoSymbolView.class.getPackage().getName());
    /**
     * The <code>CUSTOM_ARGUMENT_NAME</code> a constant for the custom argument
     * name attribute value this class requires. This should be the option list
     * key for the option list that supports this view.
     */
    private static final String CUSTOM_ARGUMENT_NAME = "optionList";
    /**
     * The <code>optionListKey</code> is the option list key to the covered auto
     * symbol. Used on the display side to match up with the correct symbol
     * list.
     */
    private OptionList.Key optionListKey;

    /**
     * Creates an instance.
     */
    public CoveredAutoSymbolView() {
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void init(Element viewElement) throws APException {
        super.init(viewElement);
        Map<String, String> customArguments = CustomViewParser.parseView(viewElement, false, CUSTOM_ARGUMENT_NAME);
        String optionListKeyValue = customArguments.get(CUSTOM_ARGUMENT_NAME);
        this.optionListKey = new OptionList.Key(optionListKeyValue);
    }

    /**
     * Derives the element paths for this view. If there is a field set in this
     * view's configuration then those XPaths will be used otherwise the
     * associated incoming element path argument is used.
     * 
     * @param associatedElementPath
     *            is the incoming element path argument.
     * @return the element paths for this view.
     */
    private List<String> deriveElementPaths(String associatedElementPath) {
        List<String> elementPaths = new ArrayList<>();
        if (this.fieldSets.length > 0) {
            for (FieldSet fieldset : this.fieldSets) {
                for (Field field : fieldset.getFieldSet()) {
                    elementPaths.add(field.getFieldId());
                }
            }
        } else {
            elementPaths.add(associatedElementPath);
        }
        return elementPaths;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void delete(APDataCollection apData, int[] indices, String associatedElementPath) {
        internalDelete(apData, this.deriveElementPaths(associatedElementPath));
    }

    /**
     * Deletes all of the occurrences of the elements designated by the element
     * path
     * 
     * @param apData
     *            is the data collection in context.
     * @param elementPaths
     *            are the element paths to delete.
     */
    private void internalDelete(APDataCollection apData, List<String> elementPaths) {
        for (String elementPath : elementPaths) {
            while (apData.exists(elementPath)) {
                apData.deleteElement(elementPath);
            }
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void update(APDataCollection apData, int[] indices, String value, String associatedElementPath) {
        if (StringUtilities.isEmpty(value)) {
            delete(apData, indices, associatedElementPath);
        }
        for (String elementPath : this.deriveElementPaths(associatedElementPath)) {
            internalUpdate(apData, value, elementPath);
        }
    }

    /**
     * Updates the elements designated by the element path.
     * 
     * @param apData
     *            is the data collection in context.
     * @param value
     *            is the updated value to apply.
     * @param elementPath
     *            is the element path to delete.
     * 
     */
    private void internalUpdate(APDataCollection apData, String value, String elementPath) {
        String[] symbols = value.split(",");
        Set<String> symbolSet = (Set<String>) ArrayHelper.copyToCollection(symbols, 0, new HashSet<String>());
        int updateIndex = 0;
        for (String symbol : symbols) {
            apData.setFieldValue(elementPath, updateIndex, symbol);
            updateIndex++;
        }

        // Clean out any symbols that are not currently represented by the
        // current request.
        Deque<int[]> deletePoints = new ArrayDeque<int[]>();
        for (int[] symbolIndex : apData.createIndexTraversalBasis(elementPath)) {
            String symbol = apData.getFieldValue(elementPath, symbolIndex, null);
            if (StringUtilities.isEmpty(symbol) || !symbolSet.contains(symbol)) {
                deletePoints.push(symbolIndex);
            }
        }

        while (!deletePoints.isEmpty()) {
            int[] symbolIndex = deletePoints.pop();
            apData.deleteElement(elementPath, symbolIndex);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String read(APDataCollection apData, int[] idArray, String defaultValue, String associatedElementPath)
            throws APException {
        List<String> elementPaths = this.deriveElementPaths(associatedElementPath);
        // We only read the first element path, since any multiples contain the
        // same set of values.
        String elementPath = elementPaths.get(0);
        // For under insured / uninsured we look for the first non null value.
        if (elementPaths.size() > 1 && StringUtilities.isEmpty(apData.getFieldValue(elementPath, null))) {
            elementPath = elementPaths.get(1);
        }
        OptionList symbolOptionList = OptionsMap.getSingleList(optionListKey);
        List<String> symbols = new ArrayList<>();
        for (int[] symbolIndex : apData.createIndexTraversalBasis(elementPath)) {
            String symbol = apData.getFieldValue(elementPath, symbolIndex, null);
            symbols.add(symbol);
        }
        if (symbols.isEmpty()) {
            return defaultValue;
        }
        String[] symbolArray = ArrayHelper.copyToArray(symbols, String.class);
        String combinedSymbolsValue = ArrayHelper.stringArrayAsString(symbolArray, ",");
        OptionEntry resolvedEntry = symbolOptionList.findFirstPrecise(combinedSymbolsValue);
        if (resolvedEntry == null) {
            String warning = String
                    .format("Unable to resolve symbol combination of: '%s' for element path: '%s' to the list with contents %s. Using the symbol combination found in XML.",
                            combinedSymbolsValue, elementPath, symbolOptionList.toString());
            LOGGER.warning(warning);
            return combinedSymbolsValue;
        } else {
            return resolvedEntry.getValue();
        }
    }
}
