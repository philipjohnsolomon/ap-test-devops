/*
 * Created on May 23, 2016 by nbaker AgencyPort Insurance Services, Inc.
 */
package com.agencyport.shared.preconditions;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;

import com.agencyport.data.IndexManager;
import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.widgets.LOBCode;
import com.agencyport.logging.LoggingManager;
import com.agencyport.preconditions.IPreConditionsFactory;
import com.agencyport.preconditions.PreConditions;
import com.agencyport.preconditions.PreConditionsFactoryDispenser;
import com.agencyport.preconditions.SynchronizationMode;
import com.agencyport.product.Product;
import com.agencyport.product.ProductDefinitionsManager;
import com.agencyport.product.VersionKey;
import com.agencyport.resource.ResourceException;
import com.agencyport.security.profile.ISecurityProfile;
import com.agencyport.service.text.EqualityChecker;
import com.agencyport.shared.APException;
import com.agencyport.trandef.Transaction;
import com.agencyport.trandef.TransactionDefinitionManager;
import com.agencyport.trandef.behavior.WhereClause;
import com.agencyport.webshared.APSession;
import com.agencyport.webshared.ControlData;

/**
 * The DelegatingPackagePreConditions class provides an implementation for package type preconditions where multiple LOB
 * precondition instances are delegated to for various function points. Commercial Package and Personal Package
 * lines of business are the use cases that this class should well serve. This only supports a synchronization
 * mode of DIRECT which is the same as USE_DEFAULT, the 5.x default. 
 * @since 5.2
 */
public abstract class DelegatingPackagePreConditions extends PreConditions {
	/**
	 * The <code>LOGGER</code> is a reference to our logger.
	 */
	private static final Logger LOGGER = LoggingManager.getLogger(DelegatingPackagePreConditions.class.getPackage().getName());
	/**
	 * The <code>monoLinePreConditions</code> contains all of the precondition class instances supporting the underlying mono-lines.
	 */
	private Map<String, PreConditions> monoLinePreConditions;

	/**
	 * Constructs an instance.
	 * @param preconditionCollectionName
	 * @param preConditionVersionInfo is the list of version keys for each mono line precondition class.
	 */
	protected DelegatingPackagePreConditions(String preconditionCollectionName, List<VersionKey> preConditionVersionInfo) {
		super(preconditionCollectionName);
		monoLinePreConditions = createLOBPreCondtions(this.data, preConditionVersionInfo);
	}

	/**
	 * Constructs an instance.
	 * @param preConditionDataCollection
	 * @param preConditionVersionInfo is the list of version keys for each mono line precondition class.
	 */
	protected DelegatingPackagePreConditions(APDataCollection preConditionDataCollection, List<VersionKey> preConditionVersionInfo) {
		super(preConditionDataCollection);
		monoLinePreConditions = createLOBPreCondtions(preConditionDataCollection, preConditionVersionInfo);
	}
	/**
	 * Accesses the product database and retrieves the version key for each product for each LOB code being passed.
	 * Please note that this method cannot be called from a precondition class level initializer.
	 * @param lobCodes is the list of LOB codes to retrieve the version key information for.
	 * @param transactionType is the transaction type for the discreet transaction instance to inflate.
	 * @return the list of precondition version keys for this package policy. 
	 */
	protected static List<VersionKey> getPreConditionVersionInformation(List<LOBCode> lobCodes, String transactionType){
		List<VersionKey> versionKeys = new ArrayList<>();
		ProductDefinitionsManager pdm = ProductDefinitionsManager.get();
		for (LOBCode lobCode : lobCodes){
			try {
				Product lobProduct = pdm.getProductByType(lobCode.getCode(), true);
				if (lobProduct != null){
					Transaction tran = TransactionDefinitionManager.getTransaction(lobCode, transactionType);
					versionKeys.add(tran.getVersionKey());
				} 
			} catch (ResourceException e) {
				LOGGER.warning(String.format("Unable to access product for LOB code = '%s'. Skipping this LOB.", lobCode));
			}
		}
		return versionKeys;
	}

	/**
	 * Creates the individual LOB preconditions using the BuiltinPreConditionsFactory.
	 * @param preConditionDataCollection is an XML precondition collection
	 * @param preConditionVersionInfo is the list of version keys for each mono line precondition class.
	 * @return a map of supporting mono-line precondition instances keyed by LOB code.
	 */
	private Map<String, PreConditions> createLOBPreCondtions(APDataCollection preConditionDataCollection, List<VersionKey> preConditionVersionInfo) {
		Map<String, PreConditions> lobPreConditions = new HashMap<>();
		IPreConditionsFactory factory = PreConditionsFactoryDispenser.getPreConditionsFactoryInstance();
		for (VersionKey preConditionVersionKey : preConditionVersionInfo){
			PreConditions pc = factory.create(preConditionVersionKey, preConditionDataCollection);
			SynchronizationMode mode = pc.getSynchronizationMode();
			if (!mode.equals(SynchronizationMode.DIRECT)){
				throw new IllegalStateException(String.format("%s only permits using a synchronization mode = %s. %s precondition class has a synchronization mode of %s", DelegatingPackagePreConditions.class.getName(), SynchronizationMode.DIRECT, pc.getClass().getName(), mode));
			}
			Transaction tran = TransactionDefinitionManager.getTransaction(preConditionVersionKey.getKey(), preConditionVersionKey.getVersion());
			lobPreConditions.put(tran.getLob(), pc);
		}
		return Collections.unmodifiableMap(lobPreConditions);
	}
	
	/**
	 * Returns the list of mono-line precondition instances.
	 * @return the list of mono-line precondition instances.
	 */
	private Collection<PreConditions> getMonolinePreConditions(){
		return monoLinePreConditions.values();
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public Object getFieldValue(String preConditionFieldName,
			String defaultValueIfNotPresent, WhereClause whereClause) {
		Object returnValue = null;
		RuntimeException allFailedException = null;
		try {
			returnValue = super.getFieldValue(preConditionFieldName, defaultValueIfNotPresent, whereClause);
			if (returnValue != null && !EqualityChecker.areEqual(returnValue, defaultValueIfNotPresent)){
				return returnValue;
			}
		} catch (RuntimeException unknownFieldException){ 
			allFailedException = unknownFieldException;
		}
		for (PreConditions pc : getMonolinePreConditions()){
			try {
				returnValue = pc.getFieldValue(preConditionFieldName, defaultValueIfNotPresent, whereClause);
				if (returnValue != null && !EqualityChecker.areEqual(returnValue, defaultValueIfNotPresent)){
					return returnValue;
				}
			} catch (RuntimeException unknownFieldException){ 
				allFailedException = unknownFieldException;
			}
		}
		// If the return value is still null by this point 
		// and there is an exception then we need to throw the runtime exception
		// because it is most likely a bad field name in the behavior file.
		if ( returnValue == null && allFailedException != null){
			throw allFailedException;
		} else {
			return returnValue;
		}
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void attach(APDataCollection workItemXML, boolean synchronize) throws APException {
		super.attach(workItemXML, synchronize);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.attach(workItemXML, synchronize);
		}
	}
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void synchronize(APDataCollection workItemXML) throws APException {
		super.synchronize(workItemXML);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.synchronize(workItemXML);
		}
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public APDataCollection detach() {
		for (PreConditions pc : getMonolinePreConditions()){
			pc.detach();
		}
		return super.detach();
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void clone(APDataCollection from) {
		super.clone(from);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.setDataCollection(getDataCollection());
		}
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void setDataCollection(APDataCollection data){
		super.setDataCollection(data);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.setDataCollection(getDataCollection());
		}
	}


	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void clearCache(){
		super.clearCache();
		for (PreConditions pc : getMonolinePreConditions()){
			pc.clearCache();
		}
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void setControlData(ControlData controlData) {
		super.setControlData(controlData);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.setControlData(controlData);
		}
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public Object clone() throws CloneNotSupportedException {
		DelegatingPackagePreConditions self = (DelegatingPackagePreConditions) super.clone();
		Map<String, PreConditions> lobPreConditions = new HashMap<>();
		for (Map.Entry<String, PreConditions> entry : this.monoLinePreConditions.entrySet()){
			PreConditions copy = (PreConditions) entry.getValue().clone();
			copy.setDataCollection(self.data);
			lobPreConditions.put(entry.getKey(), copy);
		}
		self.monoLinePreConditions = Collections.unmodifiableMap(lobPreConditions);
		return self;
	}
	
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void setIndexManager(IndexManager indexManager){
		super.setIndexManager(indexManager);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.setIndexManager(indexManager);
		}
	}

	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void updateTransientState(HttpServletRequest request, APSession apSession){
		super.updateTransientState(request, apSession);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.updateTransientState(request, apSession);
		}
	}
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void setSecurityProfile(ISecurityProfile securityProfile) {
		super.setSecurityProfile(securityProfile);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.setSecurityProfile(securityProfile);
		}
	}
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void setInUploadWriterMode(Boolean inUploadWriterMode) {
		super.setInUploadWriterMode(inUploadWriterMode);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.setInUploadWriterMode(inUploadWriterMode);
		}
	}

	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void setUploadWriterOperationType(String uploadWriterOperationType) {
		super.setUploadWriterOperationType(uploadWriterOperationType);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.setUploadWriterOperationType(uploadWriterOperationType);
		}
	}
	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void setEngageViews(boolean engageViews) {
		super.setEngageViews(engageViews);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.setEngageViews(engageViews);
		}
	}

	/** 
	 * {@inheritDoc}
	 */ 
	@Override
	public void setUserId(String newUserId){
		super.setUserId(newUserId);
		for (PreConditions pc : getMonolinePreConditions()){
			pc.setUserId(newUserId);
		}
	}
	

}
