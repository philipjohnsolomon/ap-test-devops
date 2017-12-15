package com.agencyport.shared.custom;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jdom2.Element;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.ElementPathExpression;
import com.agencyport.domXML.view.IView;
import com.agencyport.html.optionutils.OptionsMap;
import com.agencyport.service.text.StringUtilities;
import com.agencyport.shared.APException;

/**
 *  This View returns the display string for a selectlist's selected value, originally
 *    intended for displaying a roster entry data selection in the roster list.
 *    Supports multiple codelists, as can be assigned to a selectlist fieldElement. 
 *   
 *  This class expects the View to be defined in the XML *  
 *   and extracts the display string from whichever codelist first has a matching value.
 *
 */
public class SelectionValueAsDisplayStringView implements IView {

		/**
	 * The <code>serialVersionUID</code>is the serial version id.
	 */
	private static final long serialVersionUID = 2808202990183818810L;
		/*
		 * This is the view id of this instance.
		 */
		/**
		 * The <code>id</code>is a private string variable.
		 */
		private String id;
		/**
		 * The <code>optionlistKeys</code> is the list of optionlist keys.
		 */
		private List<String> optionlistKeys = new ArrayList<String>();
		/**
		 * The <code>title</code>is a private string variable.
		 */
		private String title;

		
		/* (non-Javadoc)
		 * @see com.agencyport.domXML.view.IView#init(org.jdom2.Element)
		 */
		@Override
		public void init(Element viewElement) throws APException {
			title = viewElement.getAttributeValue("title");
			if (title == null){
				title="";
			}
			
			// Get the id for this dynamic list template
			id = viewElement.getAttributeValue("id");
			if ( id == null ){
				throw new APException("Required 'id' attribute missing on view");
			}

			// Pull the option list reader:source:target keys from the fields
			Element fieldset = viewElement.getChild("fieldSet");
			if (fieldset==null){
				throw new APException("Required 'fieldSet' element missing on view");
			}			
			
		
			List<Element> childElements = fieldset.getChildren();
			Iterator<Element> iter = childElements.listIterator();
			initIterator(iter);
			
			if ( optionlistKeys.isEmpty()){
				throw new APException("Required 'field' element(s) missing on view's fieldSet");
			}
		}


		/**
		 * @param iter
		 */
		private void initIterator(Iterator<Element> iter) {
			while(iter.hasNext()){
				Object child = iter.next();
				if (child instanceof Element &&	(("field").equals(((Element)child).getName()))) {
					String optionlistKey = ((Element)child).getText();
					optionlistKeys.add(optionlistKey);
				}
			}
		}
		
		
		/* (non-Javadoc)
		 * @see com.agencyport.domXML.view.IView#update(com.agencyport.domXML.APDataCollection, int[], java.lang.String, java.lang.String)
		 */
		@Override
		public void update(APDataCollection apData, int[] idArray, String value, String associatedElementPath) {
			
			//left empty intentionally
		}
		
		
		/* (non-Javadoc)
		 * @see com.agencyport.domXML.view.IView#read(com.agencyport.domXML.APDataCollection, int[], java.lang.String, java.lang.String)
		 */
		@Override
		public String read(APDataCollection apData, int[] idArray, String defaultValue, String associatedElementPath)
							throws APException {
			String value = apData.getFieldValue(associatedElementPath, idArray, defaultValue);
			Iterator<String> listsIter = optionlistKeys.listIterator();
			// Loop through all the options in all the option lists, looking for a match.
			while (listsIter.hasNext()) {
				List<String> valuesList = OptionsMap.getOptionsList((String)listsIter.next(), null);
				Iterator<String> iter = valuesList.listIterator();
				while(iter.hasNext()){
					String listVal = (String)iter.next();
					String[] values = splitOptionListValue(listVal);
					if((values.length > 1) && values[0].equalsIgnoreCase(value)) {
							return values[1];
					}
				}
			}
			return value;
		}
		
		
		/* (non-Javadoc)
		 * @see com.agencyport.domXML.view.IView#delete(com.agencyport.domXML.APDataCollection, int[], java.lang.String)
		 */
		@Override
		public void delete(APDataCollection apData, int[] idArray, String associatedElementPath) {
			//left empty intentionally
		}

		/* (non-Javadoc)
		 * @see com.agencyport.domXML.view.IView#getId()
		 */
		@Override
		public String getId() {
			return id;
		}
		
		/* (non-Javadoc)
		 * @see com.agencyport.domXML.view.IView#getTitle()
		 */
		@Override
		public String getTitle(){
			return title; 
		}
		
		
		/*
		 * Encapsulate the call to String method split() in order to add handling for  
		 *   the following three special cases where either option tag contains no  
		 *   text and/or the value attribute contains no text:
		 *   
		 *       <option enabled="true" value="N"></option>   
		 *       <option enabled="true" value="">Select One</option>
		 *       <option enabled="true" value=""></option>
		 */
		/**
		 * @param listVal
		 * @return String array
		 */
		public String[] splitOptionListValue(String listVal) {
			String[] splitString = listVal.split("\\|");
			
			if (splitString.length>=2) {
				return splitString;
			}
			
			if (splitString.length==0) {
				// If listVal contained one or more | characters (and no other
				//   characters) it means the option looked something like:  
				//      <option enabled="true" value=""></option>
				//   otherwise something strange is going on.
				if (listVal.matches("^\\|+$")) {
					splitString = new String[2];
					splitString[0] = "";
					splitString[1] = "";
				}
				return splitString;				
			}
			
			/* We only get here if length of value is 1) */
			String tempstring = splitString[0];
			if (listVal.startsWith("|")) {
				splitString = new String[2];
				splitString[0] = "";
				splitString[1] = tempstring;
			}else if (listVal.endsWith("|")) {
				splitString = new String[2];
				splitString[0] = tempstring;
				splitString[1] = "";				
			}
			return splitString;
		}
		/* (non-Javadoc)
		 * @see com.agencyport.domXML.view.IView#getElementPath(com.agencyport.domXML.APDataCollection, java.lang.String)
		 */
		@Override
		public ElementPathExpression getElementPath(APDataCollection apData,
				String associatedElementPath) {
		
			return null;
		}


		/** 
		 * {@inheritDoc}
		 */ 
		@Override
		public boolean isEmptyValue(String value) {
			return StringUtilities.isEmpty(value);
		}
}
