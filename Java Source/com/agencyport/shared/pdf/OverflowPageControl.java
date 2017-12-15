package com.agencyport.shared.pdf;


import java.util.ArrayList;
import java.util.List;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.APException;

/**
 * @author djenner
 *
 * 
 * 		Without a class like this, currentPage and currentLine have to go
 * 		in the main Acord130Manager, and then all the logic for any kind of
 * 		overflow has to go there as well.
 */
public class OverflowPageControl {

	public static final int MAX_LINES_7_FONT = 69;
	
		// This needs to match the maxwidth given in the xml layout file.
	public static final int MAX_WIDTH_7_FONT = 125;
 
 	private PdfDocument pdfDocument;
 	private APDataCollection apData;
 	private PdfBox pdfBox;
	private int currentPage;
	private int currentLine;
	private int layoutPageNum = -1;
	private String lineOfBusiness;
	
	/**
	 * Method OverflowPageControl.
	 * @param currentPage_in 	The CURRENT page.  I.e. the LAST page of
	 * 							the ACORD PDF.  NOT what MIGHT be the
	 * 							first overflow page.
	 * @param pdfDocument_in	Needed to aquire more pages
	 * @param apData_in			Needed for headings
	 * @param carrierId_in		Needed to tailor certain sections of overflow 
	 */
	public OverflowPageControl(int currentPage_in,
								PdfDocument pdfDocument_in,
								APDataCollection apData_in) {									

		currentPage = currentPage_in;
		pdfDocument = pdfDocument_in;
		apData = apData_in;			
	}	
	
	public OverflowPageControl(int currentPage_in,
			PdfDocument pdfDocument_in,
			APDataCollection apData_in,
			String lineOfBusiness_in) {									

		currentPage = currentPage_in;
		pdfDocument = pdfDocument_in;
		apData = apData_in;
		lineOfBusiness = lineOfBusiness_in;
	}
	
	public int getCurrentLine() {
		return currentLine;
	}	

	public void printLine(String line) throws APException {
		
		@SuppressWarnings("unchecked")
		List<String> lines = splitStringIntoLines(line, MAX_WIDTH_7_FONT);
		
		for(int i = 0; i < lines.size(); i++) {
			
			if (currentLine == 0 && pdfBox == null) {
				
				pdfDocument.addPDFpageSet(IPdfConstants.ACORD_OVERFLOW);
				pdfDocument.positionPdfOnPage(++currentPage);
				pdfDocument.positionLayoutOnPage(getLayoutPage());
				if(pdfBox != null){
					pdfBox.flush();
				}
				OverflowPageHeadingBox overflowPageHeadingBox = new OverflowPageHeadingBox(lineOfBusiness);
				overflowPageHeadingBox.process(pdfDocument, apData);
				pdfBox = pdfDocument.getBox("AdditionalInformation");
			}
									
			if ( currentLine == MAX_LINES_7_FONT) {

				pdfDocument.addPDFpageSet(IPdfConstants.ACORD_OVERFLOW);
				pdfDocument.positionPdfOnPage(++currentPage);
				if(pdfBox != null){
					pdfBox.flush();
				}
				OverflowPageHeadingBox overflowPageHeadingBox = new OverflowPageHeadingBox(lineOfBusiness);
				overflowPageHeadingBox.process(pdfDocument, apData);
				pdfBox = pdfDocument.getBox("AdditionalInformation");
				currentLine = 0;
			}
			
			pdfBox.addLine((String)lines.get(i));
			currentLine++;			
		}
	}
	
	public void flush() {
		
		if (currentLine == 0) {
			return;
		}
		
		if(null != pdfBox){
			pdfBox.flush();
			pdfBox = null;
		}
	}
	
	public void setFont() {		
	}
	
	public void setLayoutPage() {
		// The current layout page to PDF page assignment makes a lot of
		// assumptions.  Even activating this method might not do it.
		// It needs to take in an int param of "which layout page".  That's
		// not there now to make Eclipse happier.	
	}
	
	public void setLayoutPage(int layout_pageNum) {
		layoutPageNum = layout_pageNum;
	}
	
	public int getLayoutPage(){
		if(layoutPageNum == -1){
			return currentPage;
		}
		else{
			return layoutPageNum;
		}
				
	}
	
	
	/**
	 * Method insurePageFit	If there are multiple lines to be printed that
	 * 						should not break across a page, call this
	 * 						prior to printLine(), with the number of lines
	 * 						that are about to be printed.
	 * @param linesToPrint	Number of lines about to be printed
	 */
	public void insurePageFit(int linesToPrint) {
		
		if (currentLine  + linesToPrint	> MAX_LINES_7_FONT) {
			currentLine = MAX_LINES_7_FONT;
		}	
	}	
	
	/**
	 * Because the pagination is controlled by the number of lines that can print on
	 * a page, we need to split up long strings into lines.  This method will 
	 * accomplish this task.  If the input string is shorter than a line length, the
	 * input string will be passed back.
	 * @param input
	 * @return string array
	 */
	public static List splitStringIntoLines(String input, int maxWidth) {
		List output = new ArrayList();
		int inputLength = input.length();
		
		if (inputLength <= maxWidth) {
			output.add(input);
		}
		else {			
			int begin = 0;
			while(begin < inputLength ){ // more lines
				String line = "";
				if( (begin + maxWidth) >= inputLength){ //lastline
					line = input.substring(begin).trim();
					begin += maxWidth;
				}else
				{
					line = input.substring(begin, begin + maxWidth);				
					int breakPoint = getBestEOLSpot(line);  
					line = input.substring(begin, begin + breakPoint).trim();
					begin += breakPoint;	
				}
				output.add(line);
			}				
		}		
		return output;
	}
	
	/*
	 * Get the best end of line 
	 */
	private static int getBestEOLSpot(String line){	
		int lineLength = line.length();
		int length75 = (int)(lineLength * 3/4) ;		
		int breakpoint = line.lastIndexOf(" ");
		// if I did not find the end of the word, after 3/4 quarter of the line
		// we will cut the line, other wise, we will find the word end
		if(breakpoint == -1 || breakpoint <= length75){
			return lineLength;
		}else{
			return breakpoint;
		}		
		
	}
	
	public void process(List stringList) throws APException {
		
		for (int i =0; i< stringList.size(); i++) {
			printLine((String) stringList.get(i));
		}
		flush();
	}
}