/*
 * Created on Mar 3, 2011 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.locale;

import com.agencyport.locale.ILocaleConstants;
import com.agencyport.locale.ResourceBundleName;

/**
 * The ISharedLocaleConstants class interface contains the full inventory of all of the resource bundle 
 * names for the Personal Auto template.
 */
public interface ISharedLocaleConstants extends ILocaleConstants {
	/**
	 * The <code>SHARED_BUNDLE</code> is the resource bundle base name that contains the prompts,
	 * text, labels and messaging that are shared across and not specific to an LOB.
	 */
	ResourceBundleName SHARED_BUNDLE = new ResourceBundleName("shared_rb");

}
