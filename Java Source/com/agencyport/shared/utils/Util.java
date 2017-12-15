/*
 * Created on Oct 6, 2015 by pnichols AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.utils;

/**
 * The Util class contains a collection of static general-purpose utility classes.
 */
public class Util {

	// Developers note: the point of this class is to create methods that are truly of a 
	// general purpose utility. It should probably not reference other agencyport classes or other 
	// custom libraries (like jdom, jaxen, etc.
	
	
	/**
	 * @param 0 the object to be tested
	 * @return true if the object is "empty" - for strings, if it's null or the empty string.
	 */
	public static boolean empty(Object o){
	
		// DEVELOPER'S NOTE: this method is usually used for strings but I wanted to leave room
		// for it to take Lists, Maps, etc.
		if (o instanceof String){
			String s = (String)o;
			return s == null || "".equals(s);
		}else{
			throw new RuntimeException("Object of type " + o.getClass().getName() + " not supported by this method.");
		}
	}
	
	
	/**
	 * @param o an object to be tested.
	 * @return the inverse of the empty method. I think it's slightly easier to read "notEmpty" than !empty, hence the method.
	 */
	public static boolean notEmpty(Object o){
		return !empty(o);
	}
	
}
