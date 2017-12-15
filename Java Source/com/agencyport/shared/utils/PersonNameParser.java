package com.agencyport.shared.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.agencyport.domXML.APDataCollection;

/**
 * Parse text containing a person's name into its constituent components.
 * 
 * Name is assumed to follow one of these formats:
 * 
 * (TITLE) FIRST_NAME (MIDDLE_NAME) (INFIX) (LAST_NAME) (SUFFIX)
 * 
 * (INFIX) (LAST_NAME), FIRST_NAME (MIDDLE_NAME)
 * 
 * The basic algorithm for parsing names it to first remove any known strings
 * from the text - e.g. "mr" is a title, so it can be removed from the name
 * string and assigned to the "title" variable. Once any titles, suffixes, and
 * infixes have been removed, there should be one or more words remaining.
 * 
 * If there is only one, it is considered to be a first name. If there are only
 * two, they are considered first and last names If there are three, they are
 * considered first, middle and last names If there are more than three, all
 * remaining words become part of the last name.
 * 
 * @author pnichols Aug 15, 2011
 */
public class PersonNameParser {

	/**
	 * A list of possible suffixes for a person name.
	 */
	private final static String[] suffixes = { "Esq", "Esquire", "Jr", "Sr", "2", "II", "III", "IV" };

	/**
	 * Infixes are components of names that are part of, but commonly separated from a last name by a space. 
	 */
	private final static String[] infixes = { "bar", "ben", "bin", "da", "dal", "de la", "de", "del", "der", "di", "ibn", "la", "le", "san", "st",
			"ste", "van", "van der", "van den", "vel", "von" };

	/**
	 * The typical set of titles found before a name
	 */
	private final static String[] titles = { "mr", "ms", "mrs", "miss", "dr" };

	/**
	 * The <code>GIVEN_NAME</code>
	 */
	public static final String GIVEN_NAME = "GivenName";
	/**
	 * The <code>OTHER_GIVEN_NAME</code>
	 */
	public static final String OTHER_GIVEN_NAME = "OtherGivenName";
	/**
	 * The <code>SURNAME</code>
	 */
	public static final String SURNAME = "Surname";
	/**
	 * The <code>TITLE_PREFIX</code>
	 */
	public static final String TITLE_PREFIX = "TitlePrefix";
	/**
	 * The <code>NAME_SUFFIX</code>
	 */
	public static final String NAME_SUFFIX = "NameSuffix";

	/**
	 * See main constructor.
	 */
	public PersonNameParser() {
	}

	/**
	 * Parse a string containing a person's name into its constituent parts.
	 * Some sample names supported by the algorithm:
	 * <ul>
	 * <li>Mr. Richard Jones</li>
	 * <li>Bob Jones II</li>
	 * <li>Jones, Bob E</li>
	 * <li>Dr. R Edward Jones</li>
	 * <li>Richard Van Jones</li>
	 * </ul>
	 * 
	 * @param text The String containgin
	 * @return a Map with each name component separated out (keys are the static strings in this class). 
	 */
	public static Map<String, String> parse(String text) {
		if (text == null) {
			text = "";
		}

		String title = "";
		String infix = "";
		String suffix = "";
		String firstName = "";
		String middleName = "";
		String lastName = "";

		text = text.replaceAll("(?i)c\\\\o |c/o ", "");

		// Find and remove any title (mr, ms)
		int position = contains(text, titles);
		if (position > -1) {
			// title = titles[position];
			title = extractAffix("(?i)\\b" + titles[position] + "\\b[.]?", text);
			text = text.replaceFirst("(?i)\\b" + titles[position] + "\\b[.]?", "");
		}

		// Find and remove any suffix (jr, ii, iii)
		position = contains(text, suffixes);
		if (position > -1) {
			suffix = extractAffix("(?i)\\b" + suffixes[position] + "\\b[.]?", text);
			text = text.replaceAll("(?i)\\b" + suffixes[position] + "\\b[.]?", "");
		}

		// Find and remove any infixes (bin, von, st )
		position = contains(text, infixes);
		if (position > -1) {
			// infix = infixes[position];
			infix = extractAffix("(?i)\\b" + infixes[position] + "\\b[.]?", text);
			text = text.replaceFirst("(?i)\\b" + infixes[position] + "\\b[.]?", "");
		}

		// Replace a period preceded by more than one character with a comma
		// (commas are sometimes
		// read in as periods by OCR
		text = text.replaceAll("(\\w\\w)[.]", "$1,");

		// Replace text like "Smith, Robert R." with "Robert R. Smith"
		text = text.replaceAll("(.+),(.+)", "$2 $1");

		text = text.trim();
		// Get rid of double space
		text = text.replaceAll("  ", " ");

		// Split the text into a list of words
		List<String> words = new ArrayList<String>(Arrays.asList(text.split(" ")));

		// The first word is always the first name - even if there are no
		// other
		// names. Name
		// could be an initial.
		firstName = words.get(0);
		words.remove(0);

		// If there is only one word, it is assumed to be a first name
		if (words.size() != 0) {

			// If there are more than two words, the second one is the
			// middle
			// name
			if (words.size() > 1) {
				middleName = words.get(0);
				words.remove(0);
			}

			// All remaining words are considered to be a last name.
			for (int i = 0; i < words.size(); i++) {
				lastName = lastName + words.get(i) + " ";
			}

		}

		if (infix.trim().length() > 0) {
			infix = infix.trim() + " ";
		}
		Map<String, String> name = new HashMap<String, String>();
		name.put(GIVEN_NAME, firstName);
		name.put(OTHER_GIVEN_NAME, middleName);
		name.put(SURNAME, infix + lastName.trim());
		name.put(TITLE_PREFIX, title);
		name.put(NAME_SUFFIX, suffix);
		return name;

	}

	
	/**
	 * Given the map resulting from the parse() method, this will copy the values into an APDataCollection, using the specified Acord xpath prefix.
	 * 
	 * @param prefix The prefix to use when saving each name component, e.g. "PersUmbrellaLineBusiness.BasicDriverInfo.GeneralPartyInfo.NameInfo.PersonName"
	 * @param apData The apdata collection
	 * @param index the index to use for this aggregate
	 * @param parsedValues the Map returned from this class' parse() method.
	 */
	public static void applyTo(String prefix, APDataCollection apData, int[] index, Map<String, String> parsedValues){

		String firstName = parsedValues.get(GIVEN_NAME);
		String middleName = parsedValues.get(OTHER_GIVEN_NAME);
		String lastName = parsedValues.get(SURNAME);
		
		if (firstName.length() > 0){
			apData.setFieldValue(prefix + "." + GIVEN_NAME, index, firstName);
		}
		if (middleName.length() > 0){
			apData.setFieldValue(prefix + "." + OTHER_GIVEN_NAME,index, middleName);
		}
		if (firstName.length() > 0){
			apData.setFieldValue(prefix + "." + SURNAME, index, lastName);
		}
		
	}
	
	/**
	 * @param text the text to search
	 * @param choices the list of options to look for
	 * @return true if the text contains any of the strings in choices"
	 */
	private static int contains(String text, String[] choices) {
		text = text.toLowerCase();
		for (int i = 0; i < choices.length; i++) {
			String regex = "(?i).*\\b" + choices[i] + "[.]?\\b.*";
			if (text.matches(regex)) {
				return i;
			}
		}
		return -1;
	}

	/**
	 * Custom method to remove affixes.
	 * @param regex the regular expression to use
	 * @param text the text to search
	 * @return the text after removal.
	 */
	private static String extractAffix(String regex, String text) {
		Pattern pt = Pattern.compile(regex);
		Matcher mt = pt.matcher(text);
		if (mt.find()) {
			return text.substring(mt.start(), mt.end());
		}

		return "";
	}
}
