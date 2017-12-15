package com.agencyport.autob.custom;//NOSONAR

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.agencyport.customlists.OptionListCache;
import com.agencyport.customlists.OptionListCacheManager;
import com.agencyport.database.DatabaseAgent;
import com.agencyport.database.provider.BaseDBProvider;
import com.agencyport.html.optionutils.OptionEntry;
import com.agencyport.html.optionutils.OptionList;
import com.agencyport.logging.ExceptionLogger;
import com.agencyport.shared.APException;

/**
 * The StateSpcVehListManager class retrieves commercial auto class codes and
 * special commercial auto class codes from the database.
 */
public class StateSpcVehListManager extends BaseDBProvider {
    /**
     * The <code>RETRIEVE_STATE_CLASS_CODE_QUERY</code> is the query to retrieve
     * state class codes.
     */
    private static final String RETRIEVE_STATE_CLASS_CODE_QUERY =
            DatabaseAgent.databaseNormalizeSQLStatement(
                    "select display, codelist_value " +
                            "from ${db_table_prefix}commlauto_codelists " +
                            "where state_id = ? and codelist_id = ? ");

    /**
     * The <code>RETRIEVE_SPECIAL_VEHICLE_CLASS_CODE_QUERY</code> is the query
     * to retrieve special class codes.
     */
    private static final String RETRIEVE_SPECIAL_VEHICLE_CLASS_CODE_QUERY =
            DatabaseAgent.databaseNormalizeSQLStatement(
                    "select display, codelist_value " +
                            "from ${db_table_prefix}commlauto_codelists " +
                            "where special_vehicle_id = ? and codelist_id = ? ");

    /**
     * The <code>optionListCacheName</code> is the option list cache instance's
     * name.
     */
    private final String optionListCacheName;

    /**
     * Constructs an instance.
     * 
     * @param optionListCacheName
     *            see {@link #optionListCacheName}
     */
    public StateSpcVehListManager(String optionListCacheName) {
        this.optionListCacheName = optionListCacheName;
    }

    /**
     * Retrieves the state class codes.
     * 
     * @param state
     *            is the state in context.
     * @param target
     *            is the 3rd part of the OptionList.Key and identifies the type
     *            of class codes to retrieve.
     * @return an OptionList containing state class codes.
     * @throws APException
     *             propagated from
     *             {@link #getClassCodes(String, String, String)}
     */
    public OptionList getStateClassCodes(String state, String target) throws APException {
        return getClassCodes(state, target, RETRIEVE_STATE_CLASS_CODE_QUERY);
    }

    /**
     * Retrieves special vehicle class codes.
     * 
     * @param spvc
     *            is the special vehicle code.
     * @param target
     *            is the 3rd part of the OptionList.Key and identifies the type
     *            of class codes to retrieve.
     * @return an OptionList containing special vehicle class codes.
     * @throws APException
     *             propagated from
     *             {@link #getClassCodes(String, String, String)}
     */
    public OptionList getSpecialVehicleClassCodes(String spvc, String target) throws APException {
        return getClassCodes(spvc, target, RETRIEVE_SPECIAL_VEHICLE_CLASS_CODE_QUERY);
    }

    /**
     * Gets either state level commercial class codes or special vehicle class
     * codes.
     * 
     * @param identifier
     *            is a parameter used in the query to the database.
     * @param target
     *            is a parameter used in the query to the database. It is also
     *            the 3rd part of the OptionList.Key and is used in key for the
     *            memory cache optimization.
     * @param sqlQuery
     *            is the SQL to run.
     * @return an OptionList containing state level or special vehicle class
     *         codes.
     * @throws APException
     *             if a SQL/JDBC issue is encountered.
     */
    private OptionList getClassCodes(String identifier, String target, String sqlQuery) throws APException {
        OptionListCache optionListCache = OptionListCacheManager.getInstance().getOptionListCache(optionListCacheName);
        OptionListCache.Key key = new OptionListCache.Key(identifier, target);

        OptionList classCodes = optionListCache.get(key);
        if (classCodes != null) {
            return classCodes;
        }

        classCodes = new OptionList();

        try {
            this.dbResourceAgent.getConnection(true);
            PreparedStatement pstmt = this.dbResourceAgent.getPreparedStatement(sqlQuery);
            pstmt.setString(1, identifier);
            pstmt.setString(2, target);
            ResultSet rs = this.dbResourceAgent.executeQuery(pstmt);

            while (rs.next()) {
                String displayValue = rs.getString(1).trim();

                String dataValue = rs.getString(2);
                String trimmedValue = "";

                if (dataValue != null) {
                    trimmedValue = dataValue.trim();
                }

                OptionEntry fullEntry = new OptionEntry(trimmedValue, displayValue);
                classCodes.add(fullEntry);
            }
            optionListCache.put(key, classCodes);
            return classCodes;
        } catch (SQLException sqlex) {
            ExceptionLogger.log(sqlex, getClass(), "getClassCodes");
            throw new APException(sqlex);
        }finally{
        	close();
        }
    }
}