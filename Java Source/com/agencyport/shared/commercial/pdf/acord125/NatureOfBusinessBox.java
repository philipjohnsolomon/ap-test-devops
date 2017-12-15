package com.agencyport.shared.commercial.pdf.acord125;


import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.pdf.AdditionalDataSupport;

/**<pre>
 * 
 * 		Spins through however many remarks are present (does NOT include
 * 		CommlPolicySupplement remarks) and prints them.
 * 
 * 		Uses a simple (crude) algorithm to not overfill the remarks box.
 * 
 * 		A remark is never split across pages - either all of the remark goes in
 * 		the box or it goes to the overflow page.
 * </pre>
 * @author djenner
 */
public class NatureOfBusinessBox extends AdditionalDataSupport {
	
	
	
	/**
	 * The <code>BOX_SIZE</code>
	 */
	public static final int BOX_SIZE = 105;
	
	/**
	 * Default Constructor
	 */
	public NatureOfBusinessBox() {
		super(0);
	}

	/**
	 * @param pdfDocument
	 * @param apData
	 */
	public void process(PdfDocument pdfDocument, APDataCollection apData) {
		String desc = apData.getFieldValue("InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].InsuredOrPrincipalInfo.BusinessInfo.OperationsDesc", "");
		
		if (desc.length() > BOX_SIZE) {
			additionalPageContent.add("NATURE OF BUSINESS : ");
			additionalPageContent.add(" ");
			additionalPageContent.add(desc);
			additionalPageContent.add(" ");
			desc = "SEE ADDITIONAL INFORMATION PAGE";
		}
		
		PdfBox box = pdfDocument.getBox("NatureOfBusiness");
		box.addText(desc);	
		box.print();
	}

}