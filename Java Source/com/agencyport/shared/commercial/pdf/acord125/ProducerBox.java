package com.agencyport.shared.commercial.pdf.acord125;

import com.agencyport.domXML.APDataCollection;
import com.agencyport.pdf.core.PdfBox;
import com.agencyport.pdf.core.PdfDocument;
import com.agencyport.shared.pdf.IAcordConstants;

/**
 * @author djenner
 *
 */
public final class ProducerBox {
	
	/**
	 * Default Constructor
	 */
	private ProducerBox(){
		
	}

	/**
	 * @param pdfDocument
	 * @param apData
	 */
	public static void process(PdfDocument pdfDocument, APDataCollection apData) {
		String producerName = apData.getFieldValue(
				"Producer.GeneralPartyInfo.NameInfo.CommlName.CommercialName", ""); 
		String addr1 = apData.getFieldValue( 
				"Producer.GeneralPartyInfo.Addr.Addr1", "");
		String addr2 = apData.getFieldValue(		
				"Producer.GeneralPartyInfo.Addr.Addr2", "");
		String city = apData.getFieldValue(		
				"Producer.GeneralPartyInfo.Addr.City", "");
		String state = apData.getFieldValue(
				"Producer.GeneralPartyInfo.Addr.StateProvCd", "");
		String zip = apData.getFieldValue("Producer.GeneralPartyInfo.Addr.PostalCode", "");

		PdfBox box = pdfDocument.getBox("AgencyInfo");

		box.addText(producerName);
		box.addText(addr1);
		if (addr2.length() > 0) {
			box.addText(addr2);
		}
		box.addText(city + " " + state  + " " + zip);
		box.print();

		pdfDocument.printField(apData.getFieldValue(
				"Producer.GeneralPartyInfo.Communications.PhoneInfo[PhoneTypeCd = \"" + IAcordConstants.PHONE_TYPE_PHONE + "\"].PhoneNumber", ""),
				"Form.Agency.Phone");
		pdfDocument.printField(apData.getFieldValue(
				"Producer.GeneralPartyInfo.Communications.PhoneInfo[PhoneTypeCd = \"" + IAcordConstants.PHONE_TYPE_FAX + "\"].PhoneNumber", ""),
				"Form.Agency.Fax");		

		pdfDocument.printField(apData.getFieldValue(
				"Producer.GeneralPartyInfo.Communications.EmailInfo.EmailAddr", ""),
				"Agency.Email");

		pdfDocument.printField(apData.getFieldValue(
				"Producer.ProducerInfo.ContractNumber", ""),
				"Code");

		pdfDocument.printField(apData.getFieldValue(
				"Producer.ProducerInfo.ProducerSubCode", ""),
				"SubCode");
		
		pdfDocument.printField(apData.getFieldValue(
				"InsuredOrPrincipal[InsuredOrPrincipalInfo.InsuredOrPrincipalRoleCd='Insured'].ItemIdInfo.AgencyId", ""),
				"AgencyCustomerId");
	}
}