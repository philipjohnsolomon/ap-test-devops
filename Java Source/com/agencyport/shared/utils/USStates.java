/*
 * Created on Apr 22, 2015 by cmartin AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * This class exposes Java constants for US State names and codes as well as
 * providing helper method to translate between them.
 * 
 */
public final class USStates {

    /**
     * The US State name Alabama
     */
    public static final String ALABAMA = "Alabama";
    /**
     * The US State name Alaska
     */
    public static final String ALASKA = "Alaska";
    /**
     * The US State name Arizona
     */
    public static final String ARIZONA = "Arizona";
    /**
     * The US State name Arkansas
     */
    public static final String ARKANSAS = "Arkansas";
    /**
     * The US State name California
     */
    public static final String CALIFORNIA = "California";
    /**
     * The US State name Colorado
     */
    public static final String COLORADO = "Colorado";
    /**
     * The US State name Connecticut
     */
    public static final String CONNECTICUT = "Connecticut";
    /**
     * The US State name Delaware
     */
    public static final String DELAWARE = "Delaware";
    /**
     * The US State name Florida
     */
    public static final String FLORIDA = "Florida";
    /**
     * The US State name Georgia
     */
    public static final String GEORGIA = "Georgia";
    /**
     * The US State name Hawaii
     */
    public static final String HAWAII = "Hawaii";
    /**
     * The US State name Idaho
     */
    public static final String IDAHO = "Idaho";
    /**
     * The US State name Illinois
     */
    public static final String ILLINOIS = "Illinois";
    /**
     * The US State name Indiana
     */
    public static final String INDIANA = "Indiana";
    /**
     * The US State name Iowa
     */
    public static final String IOWA = "Iowa";
    /**
     * The US State name Kansas
     */
    public static final String KANSAS = "Kansas";
    /**
     * The US State name Kentucky
     */
    public static final String KENTUCKY = "Kentucky";
    /**
     * The US State name Louisiana
     */
    public static final String LOUISIANA = "Louisiana";
    /**
     * The US State name Maine
     */
    public static final String MAINE = "Maine";
    /**
     * The US State name Maryland
     */
    public static final String MARYLAND = "Maryland";
    /**
     * The US State name Massachusetts
     */
    public static final String MASSACHUSETTS = "Massachusetts";
    /**
     * The US State name Michigan
     */
    public static final String MICHIGAN = "Michigan";
    /**
     * The US State name Minnesota
     */
    public static final String MINNESOTA = "Minnesota";
    /**
     * The US State name Mississippi
     */
    public static final String MISSISSIPPI = "Mississippi";
    /**
     * The US State name Missouri
     */
    public static final String MISSOURI = "Missouri";
    /**
     * The US State name Montana
     */
    public static final String MONTANA = "Montana";
    /**
     * The US State name Nebraska
     */
    public static final String NEBRASKA = "Nebraska";
    /**
     * The US State name Nevada
     */
    public static final String NEVADA = "Nevada";
    /**
     * The US State name New Hampshire
     */
    public static final String NEW_HAMPSHIRE = "New Hampshire";
    /**
     * The US State name New Jersey
     */
    public static final String NEW_JERSEY = "New Jersey";
    /**
     * The US State name New Mexico
     */
    public static final String NEW_MEXICO = "New Mexico";
    /**
     * The US State name New York
     */
    public static final String NEW_YORK = "New York";
    /**
     * The US State name North Carolina
     */
    public static final String NORTH_CAROLINA = "North Carolina";
    /**
     * The US State name North Dakota
     */
    public static final String NORTH_DAKOTA = "North Dakota";
    /**
     * The US State name Ohio
     */
    public static final String OHIO = "Ohio";
    /**
     * The US State name Oklahoma
     */
    public static final String OKLAHOMA = "Oklahoma";
    /**
     * The US State name Oregon
     */
    public static final String OREGON = "Oregon";
    /**
     * The US State name Pennsylvania
     */
    public static final String PENNSYLVANIA = "Pennsylvania";
    /**
     * The US State name Rhode Island
     */
    public static final String RHODE_ISLAND = "Rhode Island";
    /**
     * The US State name South Carolina
     */
    public static final String SOUTH_CAROLINA = "South Carolina";
    /**
     * The US State name South Dakota
     */
    public static final String SOUTH_DAKOTA = "South Dakota";
    /**
     * The US State name Tennessee
     */
    public static final String TENNESSEE = "Tennessee";
    /**
     * The US State name Texas
     */
    public static final String TEXAS = "Texas";
    /**
     * The US State name Utah
     */
    public static final String UTAH = "Utah";
    /**
     * The US State name Vermont
     */
    public static final String VERMONT = "Vermont";
    /**
     * The US State name Virginia
     */
    public static final String VIRGINIA = "Virginia";
    /**
     * The US State name Washington
     */
    public static final String WASHINGTON = "Washington";
    /**
     * The US State name West Virginia
     */
    public static final String WEST_VIRGINIA = "West Virginia";
    /**
     * The US State name Wisconsin
     */
    public static final String WISCONSIN = "Wisconsin";
    /**
     * The US State name Wyoming
     */
    public static final String WYOMING = "Wyoming";

    /**
     * The US State abbreviation for Alabama
     */
    public static final String AL = "AL";
    /**
     * The US State abbreviation for Alaska
     */
    public static final String AK = "AK";
    /**
     * The US State abbreviation for Arizona
     */
    public static final String AZ = "AZ";
    /**
     * The US State abbreviation for Arkansas
     */
    public static final String AR = "AR";
    /**
     * The US State abbreviation for California
     */
    public static final String CA = "CA";
    /**
     * The US State abbreviation for Colorado
     */
    public static final String CO = "CO";
    /**
     * The US State abbreviation for Connecticut
     */
    public static final String CT = "CT";
    /**
     * The US State abbreviation for Deleware
     */
    public static final String DE = "DE";
    /**
     * The US State abbreviation for Florida
     */
    public static final String FL = "FL";
    /**
     * The US State abbreviation for Georgia
     */
    public static final String GA = "GA";
    /**
     * The US State abbreviation for Hawaii
     */
    public static final String HI = "HI";
    /**
     * The US State abbreviation for Idaho
     */
    public static final String ID = "ID";
    /**
     * The US State abbreviation for Illinios
     */
    public static final String IL = "IL";
    /**
     * The US State abbreviation for Indiana
     */
    public static final String IN = "IN";
    /**
     * The US State abbreviation for Iowa
     */
    public static final String IA = "IA";
    /**
     * The US State abbreviation for Kansas
     */
    public static final String KS = "KS";
    /**
     * The US State abbreviation for Kentucky
     */
    public static final String KY = "KY";
    /**
     * The US State abbreviation for Louisiana
     */
    public static final String LA = "LA";
    /**
     * The US State abbreviation for Maine
     */
    public static final String ME = "ME";
    /**
     * The US State abbreviation for Maryland
     */
    public static final String MD = "MD";
    /**
     * The US State abbreviation for Massachusetts
     */
    public static final String MA = "MA";
    /**
     * The US State abbreviation for Michigan
     */
    public static final String MI = "MI";
    /**
     * The US State abbreviation for Minnesota
     */
    public static final String MN = "MN";
    /**
     * The US State abbreviation for Mississippi
     */
    public static final String MS = "MS";
    /**
     * The US State abbreviation for Missouri
     */
    public static final String MO = "MO";
    /**
     * The US State abbreviation for Montana
     */
    public static final String MT = "MT";
    /**
     * The US State abbreviation for Nebraska
     */
    public static final String NE = "NE";
    /**
     * The US State abbreviation for Nevada
     */
    public static final String NV = "NV";
    /**
     * The US State abbreviation for New Hampshire
     */
    public static final String NH = "NH";
    /**
     * The US State abbreviation for New Jersey
     */
    public static final String NJ = "NJ";
    /**
     * The US State abbreviation for New Mexico
     */
    public static final String NM = "NM";
    /**
     * The US State abbreviation for New York
     */
    public static final String NY = "NY";
    /**
     * The US State abbreviation for North Carolina
     */
    public static final String NC = "NC";
    /**
     * The US State abbreviation for North Dakota
     */
    public static final String ND = "ND";
    /**
     * The US State abbreviation for Ohio
     */
    public static final String OH = "OH";
    /**
     * The US State abbreviation for Oklahoma
     */
    public static final String OK = "OK";
    /**
     * The US State abbreviation for Oregon
     */
    public static final String OR = "OR";
    /**
     * The US State abbreviation for Pennsylvania
     */
    public static final String PA = "PA";
    /**
     * The US State abbreviation for Rhode Island
     */
    public static final String RI = "RI";
    /**
     * The US State abbreviation for South Carolina
     */
    public static final String SC = "SC";
    /**
     * The US State abbreviation for South Dakota
     */
    public static final String SD = "SD";
    /**
     * The US State abbreviation for Tennesee
     */
    public static final String TN = "TN";
    /**
     * The US State abbreviation for Texas
     */
    public static final String TX = "TX";
    /**
     * The US State abbreviation for Utah
     */
    public static final String UT = "UT";
    /**
     * The US State abbreviation for Vermont
     */
    public static final String VT = "VT";
    /**
     * The US State abbreviation for Virginia
     */
    public static final String VA = "VA";
    /**
     * The US State abbreviation for Washington
     */
    public static final String WA = "WA";
    /**
     * The US State abbreviation for West Virginia
     */
    public static final String WV = "WV";
    /**
     * The US State abbreviation for Wisconsin
     */
    public static final String WI = "WI";
    /**
     * The US State abbreviation for Wyoming
     */
    public static final String WY = "WY";

    /**
     * A map of State codes keyed by state name
     */
    public static final Map<String, String> STATE_CODES = new HashMap<String, String>();
    static {
        STATE_CODES.put(ALABAMA, AL);
        STATE_CODES.put(ALASKA, AK);
        STATE_CODES.put(ARIZONA, AZ);
        STATE_CODES.put(ARKANSAS, AR);
        STATE_CODES.put(CALIFORNIA, CA);
        STATE_CODES.put(COLORADO, CO);
        STATE_CODES.put(CONNECTICUT, CT);
        STATE_CODES.put(DELAWARE, DE);
        STATE_CODES.put(FLORIDA, FL);
        STATE_CODES.put(GEORGIA, GA);
        STATE_CODES.put(HAWAII, HI);
        STATE_CODES.put(IDAHO, ID);
        STATE_CODES.put(ILLINOIS, IL);
        STATE_CODES.put(INDIANA, IN);
        STATE_CODES.put(IOWA, IA);
        STATE_CODES.put(KANSAS, KS);
        STATE_CODES.put(KENTUCKY, KY);
        STATE_CODES.put(LOUISIANA, LA);
        STATE_CODES.put(MAINE, ME);
        STATE_CODES.put(MARYLAND, MD);
        STATE_CODES.put(MASSACHUSETTS, MA);
        STATE_CODES.put(MICHIGAN, MI);
        STATE_CODES.put(MINNESOTA, MN);
        STATE_CODES.put(MISSISSIPPI, MS);
        STATE_CODES.put(MISSOURI, MI);
        STATE_CODES.put(MONTANA, MT);
        STATE_CODES.put(NEBRASKA, NE);
        STATE_CODES.put(NEVADA, NV);
        STATE_CODES.put(NEW_HAMPSHIRE, NH);
        STATE_CODES.put(NEW_JERSEY, NJ);
        STATE_CODES.put(NEW_MEXICO, NM);
        STATE_CODES.put(NEW_YORK, NY);
        STATE_CODES.put(NORTH_CAROLINA, NC);
        STATE_CODES.put(NORTH_DAKOTA, ND);
        STATE_CODES.put(OHIO, OH);
        STATE_CODES.put(OKLAHOMA, OK);
        STATE_CODES.put(OREGON, OR);
        STATE_CODES.put(PENNSYLVANIA, PA);
        STATE_CODES.put(RHODE_ISLAND, RI);
        STATE_CODES.put(SOUTH_CAROLINA, SC);
        STATE_CODES.put(SOUTH_DAKOTA, SD);
        STATE_CODES.put(TENNESSEE, TN);
        STATE_CODES.put(TEXAS, TX);
        STATE_CODES.put(UTAH, UT);
        STATE_CODES.put(VERMONT, VT);
        STATE_CODES.put(VIRGINIA, VA);
        STATE_CODES.put(WASHINGTON, WA);
        STATE_CODES.put(WEST_VIRGINIA, WV);
        STATE_CODES.put(WISCONSIN, WI);
        STATE_CODES.put(WYOMING, WY);
    }

    /**
     * A map of State names keyed by state code
     */
    public static final Map<String, String> STATE_NAMES = new HashMap<String, String>();
    static {
        STATE_NAMES.put(AL, ALABAMA);
        STATE_NAMES.put(AK, ALASKA);
        STATE_NAMES.put(AZ, ARIZONA);
        STATE_NAMES.put(AR, ARKANSAS);
        STATE_NAMES.put(CA, CALIFORNIA);
        STATE_NAMES.put(CO, COLORADO);
        STATE_NAMES.put(CT, CONNECTICUT);
        STATE_NAMES.put(DE, DELAWARE);
        STATE_NAMES.put(FL, FLORIDA);
        STATE_NAMES.put(GA, GEORGIA);
        STATE_NAMES.put(HI, HAWAII);
        STATE_NAMES.put(ID, IDAHO);
        STATE_NAMES.put(IL, ILLINOIS);
        STATE_NAMES.put(IN, INDIANA);
        STATE_NAMES.put(IA, IOWA);
        STATE_NAMES.put(KS, KANSAS);
        STATE_NAMES.put(KY, KENTUCKY);
        STATE_NAMES.put(LA, LOUISIANA);
        STATE_NAMES.put(ME, MAINE);
        STATE_NAMES.put(MD, MARYLAND);
        STATE_NAMES.put(MA, MASSACHUSETTS);
        STATE_NAMES.put(MI, MICHIGAN);
        STATE_NAMES.put(MN, MINNESOTA);
        STATE_NAMES.put(MS, MISSISSIPPI);
        STATE_NAMES.put(MO, MISSOURI);
        STATE_NAMES.put(MT, MONTANA);
        STATE_NAMES.put(NE, NEBRASKA);
        STATE_NAMES.put(NV, NEVADA);
        STATE_NAMES.put(NH, NEW_HAMPSHIRE);
        STATE_NAMES.put(NJ, NEW_JERSEY);
        STATE_NAMES.put(NM, NEW_MEXICO);
        STATE_NAMES.put(NY, NEW_YORK);
        STATE_NAMES.put(NC, NORTH_CAROLINA);
        STATE_NAMES.put(ND, NORTH_DAKOTA);
        STATE_NAMES.put(OH, OHIO);
        STATE_NAMES.put(OK, OKLAHOMA);
        STATE_NAMES.put(OR, OREGON);
        STATE_NAMES.put(PA, PENNSYLVANIA);
        STATE_NAMES.put(RI, RHODE_ISLAND);
        STATE_NAMES.put(SC, SOUTH_CAROLINA);
        STATE_NAMES.put(SD, SOUTH_DAKOTA);
        STATE_NAMES.put(TN, TENNESSEE);
        STATE_NAMES.put(TX, TEXAS);
        STATE_NAMES.put(UT, UTAH);
        STATE_NAMES.put(VT, VERMONT);
        STATE_NAMES.put(VA, VIRGINIA);
        STATE_NAMES.put(WA, WASHINGTON);
        STATE_NAMES.put(WV, WEST_VIRGINIA);
        STATE_NAMES.put(WI, WISCONSIN);
        STATE_NAMES.put(WY, WYOMING);
    }

    /**
     * private default constructor to prevent instantiation
     *
     */
    private USStates() {
        // This class should not be instantiated
    }

}
