package com.agencyport.shared.pdf;

import java.util.ArrayList;
import java.util.List;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.view.IView;
import com.agencyport.domXML.view.ViewRepository;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.APException;

/*
 * Created on May 17, 2006 by Pradeep, AgencyPort Insurance
 */

public class RemarksBox extends AdditionalDataSupport {
		//	Some factor lower than the defined box size (460) minus the overflow
		//  blurb (35). Because line breaks eat space. 3 line breaks at
		//  10 letter words would be about 30. This is 395. Bump down a
		//  bit more for to increase safety margin.
		//  Note the current "standard" remark size in a jsp is 240.
	
	public RemarksBox() {
		super(0);
	}
	public RemarksBox(int maxsize, List addData) {
		super(maxsize, (ArrayList)addData);
	}
	public void process(PdfDocument pdfDocument, APDataCollection apData,
		String view, String desc, String formField)	throws APException{
			
		IView aView = ViewRepository.getView(view);
		String remark = aView.read(apData,null,"",null);
		String sb = "";
		if(formField != null){
			if(remark.length() > maxSizeAllowed ){
				sb  = desc + " - SEE ADDITIONAL INFORMATION PAGE";
				additionalPageContent.add(desc + " : ");
				additionalPageContent.add(" ");				
				additionalPageContent.add(remark);
				additionalPageContent.add(" ");						
			}else{
				sb = "  \n" + remark;			
			}
			PdfBox box = pdfDocument.getBox(formField);
			box.addText(sb);	
			box.print();
		}else{
			additionalPageContent.add(desc + " : ");
			additionalPageContent.add(" ");				
			additionalPageContent.add(remark);
			additionalPageContent.add(" ");							
		}
	}

}