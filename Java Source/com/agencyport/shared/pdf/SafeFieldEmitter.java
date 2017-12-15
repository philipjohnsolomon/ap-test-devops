package com.agencyport.shared.pdf;

import java.util.logging.Logger;

import com.agencyport.logging.LoggingManager;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;

public class SafeFieldEmitter {
	
	private static final Logger logger = LoggingManager.getLogger(SafeFieldEmitter.class.getPackage().getName());

	
	public static boolean printFieldIfExists( PdfDocument pdfDocument, String data, String fieldDefinitionName) {
		
		boolean success = false;
		try {
			pdfDocument.printField(data, fieldDefinitionName);
			success = true;
		}
		catch( IllegalArgumentException ex ) {
			
			logger.info( ex.getMessage() );
		}
		
		return success;
	}

	public static boolean fieldExists( PdfDocument pdfDocument, String fieldDefinitionName ) {

		boolean exists = false;
		
		try {
			PdfBox box = pdfDocument.getBox( fieldDefinitionName );
			
			if( box != null )
				exists = true;
		}
		catch( IllegalArgumentException ex ) {
		
		}
			
		return exists;
	}
	
}