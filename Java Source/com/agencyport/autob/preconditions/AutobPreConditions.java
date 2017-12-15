/*
 * Created on May 10, 2007 by Sathish AgencyPort Insurance Services, Inc.
 */
package com.agencyport.autob.preconditions;//NOSONAR

import com.agencyport.domXML.APDataCollection;
import com.agencyport.preconditions.PreConditions;
import com.agencyport.preconditions.SynchronizationInfo;
import com.agencyport.preconditions.SynchronizationMode;
import com.agencyport.shared.version.IVersionInfo;
import com.agencyport.trandef.LOBSupported;
import com.agencyport.version.Version;

/**
 * The CommlAutoPreConditions class is the core class implementing the
 * precondition logic. This will be used in the monoline and CPP applications.
 */
@LOBSupported(lob = "AUTOB", version = @Version({ IVersionInfo.DEFAULT_MAJOR_MAJOR_VERSION, IVersionInfo.DEFAULT_MAJOR_MINOR_VERSION,
        IVersionInfo.DEFAULT_MINOR_MAJOR_VERSION, IVersionInfo.DEFAULT_MINOR_MINOR_VERSION }))
@SynchronizationInfo(mode = SynchronizationMode.USE_DEFAULT)
public class AutobPreConditions extends PreConditions {

	/**
	 * Creates an "empty" precondition based upon the the precondition collection name.
	 * @param preConditionDataCollection should match the <code>[Element:<i>data collection name</i>]</code> parameter
	 * in application properties for the associated xml schema.
	 */
	public AutobPreConditions(String preConditionDataCollection) {
		super(preConditionDataCollection);
		
	}
	
	/**
	 * Creates an instance based on the data values associated with the precondition data collection passed.
	 * @param preConditionDataCollection is the precondition data collection instance to associate with the
	 * new instance.
	 */
	public AutobPreConditions(APDataCollection preConditionDataCollection) {
		super(preConditionDataCollection);
	}
}