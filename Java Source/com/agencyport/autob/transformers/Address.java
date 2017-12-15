/*
 * Created on Apr 8, 2015 by pnichols AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.transformers;//NOSONAR

import static org.apache.commons.lang.StringUtils.isEmpty;

import java.util.List;

import com.agencyport.domXML.APDataCollection;

/**
 * The Address class represents an address from an Acord document. It is used to compare, and find matches 
 * for addresses in different locations in the Acord (e.g. to find Location addreses that match CommlVeh 
 * addresses. Its key method is "match()" - which identifies two addresses which are "the same" - meaning,
 * which contain no conflicting elements.<p/>
 * 
 * A specific issue with the comparison is matching two addresses which may contain incomplete informaiton.
 * An address with just "10 Main St" should match with one contianing "10 Main St, Oz KY 11222". As long
 * as two addresses contain no conflicting address information, they will be considered a match. There
 * is no logic for finding the "best match" when several addresses are similar - in general the first possible
 * match is considered the correct one.
 * 
 * Right now this logic is used in transforming Turnstile Acord XML into Simplified Portal Acord XML, so the
 * matching logic is driven by this particular use case.
 * 
 */
public class Address {
	
		/**
		 * A flag, used to indicate a failure to find a match. See 
		 * {@link AutobTurnstileTransformer#findMatchingAddress} for usage.
		 */
		public static final Address NO_MATCH = new Address();
		
		/**
		 * The street address
		 */
		private String street;
		/**
		 * The street address line 2
		 */
		private String street2;
		/**
		 * The city
		 */
		private String city;
		/**
		 * The state
		 */
		private String state;
		/**
		 * The zip code
		 */
		private String zip;
		/**
		 * The id attribute of the address in the XML
		 */
		private String id;

		
		/**
		 * Private constructor - only used to create the NO_MATCH static object.
		 */
		private Address(){
			this.street = null;
			this.street2 = null;
			this.city = null;
			this.state = null;
			this.zip = null;
		}
		
		
		/**
		 * Create an address with the specified fields. Parameters can be null, or empty strings.
		 * @param street The street address
		 * @param street2 The other street address
		 * @param city the city
		 * @param state the state
		 * @param zip the zip
		 */
		public Address(String street, String street2, String city, String state, String zip) {
			this.street = street;
			this.street2 = street2;
			this.city = city;
			this.state = state;
			this.zip = zip;
		}

		
		/**
		 * Load the address information from the apData collection, using the specified root 
		 * prefix. To load the "Location.Addr" information, you would pass in "Location". The 
		 * ".Addr" root is implied.
		 * 
		 * @param apData The APDataCollection with the XML
		 * @param prefix The root prefix path - the Addr is assumed to be a direct child of 
		 * this element
		 * @param ids The indexes to look for the address in the prefix path.
		 */
		public Address(APDataCollection apData, String prefix, int[] ids) {
			this.street = apData.getFieldValue(prefix + ".Addr.Addr1", ids, "");
			this.street2 = apData.getFieldValue(prefix + ".Addr.Addr2", ids, "");
			this.city = apData.getFieldValue(prefix + ".Addr.City", ids, "");
			this.state = apData.getFieldValue(prefix + ".Addr.StateProvCd", ids, "");
			this.zip = apData.getFieldValue(prefix + ".Addr.PostalCode", ids, "");
		}

		
		/**
		 * Return whether this address is a match with the specified address. An address will 
		 * match as long as there are no conflicting elements - elements which have different, non-
		 * empty values for the same element. An empty element (i.e. state) in one address is considered
		 * a match with any non-empty value. So the following addresses would be considered matches:
		 * <ul>
		 * <li>	 "10 Main St, Oz KY 11211" and "10 Main St" </li>
		 * <li>	 "10 Main St, Oz KY 11211" and "OZ KY" </li>
		 * <li>	 "10 Main St, Oz KY 11211" and "KY" </li>
		 * <li>	 "KY" and "10 Main St" </li>
		 * <li>	 "" and "10 Main St" </li>
		 * <li>	" Oz KY 11211" and "Oz KY 11211-3333" </li>
		 * </ul>
		 * 
		 * All values are trimmed of excess whitespaces before the (caseless) comparison is performed
		 * 
		 * @param match the address to compare to
		 * @return true if the addresses match.
		 */
		public boolean matches(Address match) {

			boolean street1Matches = isCompatible(clean(street), clean(match.street));
			boolean street2Matches = isCompatible(clean(street2), clean(match.street2));
			boolean cityMatches = isCompatible(clean(city), clean(match.city));
			boolean stateMatches = isCompatible(clean(state), clean(match.state));

			boolean zipMatches = isCompatible(getZip5Code(clean(zip)), getZip5Code(clean(match.zip)));

			return street1Matches && street2Matches && cityMatches && stateMatches && zipMatches; //NOSONAR
		}

		
		/**
		 * Look for a an address "matching" a specified address in a list of addresses; if no match is 
		 * found return the special "Address.NO_MATCH" object. Address matching is not the same as 
		 * equality: "10 Main Street, Oz KY 11111" is considered a match of the address "10 Main Street," 
		 * and a match of the address "Oz KY". Basically two addresses "match" when they have no 
		 * conflicting elements - an address without a state can match with one that has a state, but
		 * two addresses with different states (or any different, non-empty components) will not match.
		 * One exception to this is in the Zip code: an address with a 9 digit zip code will match
		 * with a 5 digit zip code, as long as the first five digits match.
		 * 
		 * @param addressList a list of Address objects to search for a match
		 * @return a matching address, or the special marker Address.NO_MATCH if none is found.
		 */
		public Address findMatchingAddress(List<Address> addressList) {
			for (Address matchAddress : addressList) {
				if (matchAddress.matches(this)) {
					return matchAddress;
				}
			}
			return Address.NO_MATCH;
		}
		
		
		/**
		 * Return the first five digits of a zipcode. We want the 9 digit version of a zip 
		 * code to be matchable with the 5 digit one.
		 * 
		 * @param zip the zip code to trim. 
		 * @return the zip code, trimmed to no more than 5 characters. Null is returned as an empty string.
		 */
		private String getZip5Code(String zip) {
			if (isEmpty(zip)) {
				return "";
			} else if (zip.length() <=5 ){
				return zip;
			}else{
				return zip.substring(0, 5);
			}
		}

		
		/**
		 * Return true if the two strings do not have conflicting values.
		 * @param first 
		 * @param second
		 * @return true if the strings are either equals, or at least one is empty.
		 */
		private boolean isCompatible(String first, String second) {
			return first.equals(second) || isEmpty(first) || isEmpty(second);
		}

		/**
		 * @return the id attribute of this address in the acord
		 */
		public String getID() {
			return id;
		}
		
		/**
		 * Set the id attribute for this address.
		 * @param id
		 */
		public void setID(String id) {
			this.id = id;
		}
		
		
		/**
		 * Clean this string for comparison - trim excess whitespace, and convert to lowercase.
		 * @param addressComponent
		 * @return the cleaned string.
		 */
		private String clean(String addressComponent) {
			if (addressComponent == null) {
				return "";

			}
			return addressComponent.toLowerCase().trim();
		}

		/** 
		 * {@inheritDoc}
		 */ 
		@Override
		public String toString() {
			return "(" + id + ")" + street + ", " + street2 + ", " + city + " " + state + " " + zip;
		}


}

