package com.agencyport.shared.pdf;


import com.agencyport.domXML.APDataCollection;
import com.agencyport.domXML.IXMLConstants;
import com.agencyport.pdf.core.PdfDocument;
/**
 * @author djenner
 *
 */
public class OverflowPageHeadingBox {
	String formType ="";

	public OverflowPageHeadingBox() {
		formType ="Commercial";
	}

	public OverflowPageHeadingBox(String formName) {
		if (formName != null) {
			if (formName.equalsIgnoreCase("HomeOwners")
				|| formName.equalsIgnoreCase("PersAuto")
				|| formName.equalsIgnoreCase("PersUmbrella")
				|| formName.equalsIgnoreCase("DwellingFire")
			) {
				formType ="Personal";
			}
		} else {
			formType ="Commercial";
		}
	}

	public void process(PdfDocument pdfDocument, APDataCollection apData) {
		int insuredCount = apData.getCount("InsuredOrPrincipal");
		int searchIndex = -1;
		for (int i=0; i < insuredCount; i++) {
			int insuredInfoCount = apData.getCount("InsuredOrPrincipal.InsuredOrPrincipalInfo[InsuredOrPrincipalRoleCd=\"Insured\"]", i);
			if (insuredInfoCount > 0) {
				searchIndex =i;
			}
		}
		String name="";
		if (formType.equalsIgnoreCase("Commercial")) {
	    	name = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.NameInfo.CommlName.CommercialName", searchIndex, "");
		} else if (formType.equalsIgnoreCase("Personal")) {
	    	String firstName = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.NameInfo.PersonName.GivenName", searchIndex, "");
	    	String lastName = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.NameInfo.PersonName.Surname", searchIndex, "");
	    	name = firstName + " " + lastName;
		}
        String addr1 = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.Addr.Addr1", "");
        String addr2 = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.Addr.Addr2", "");
        String city = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.Addr.City", "");
        String stateProvCd = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.Addr.StateProvCd", "");
        String postalCode = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.Addr.PostalCode", "");

        String address = addr1 + "\n";
        if (addr2 == null || "".equals(addr2)) {
        } else {
            address += addr2 + "\n";
        }
        address += city + "\n"
                + stateProvCd + " "
                + postalCode  + "\n";

        pdfDocument.printField(name, "InsuredName");
        pdfDocument.printField(address, "Address");
    }

	public String setCommlName(APDataCollection apData) {
        String name = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.NameInfo.CommlName.CommercialName", IXMLConstants.ID_BASE, "");
        return name;
	}

	public String setPersonalName(APDataCollection apData) {
        String name = apData.getFieldValue("InsuredOrPrincipal.GeneralPartyInfo.NameInfo.PersonName.Surname", IXMLConstants.ID_BASE, "");
        return name;
	}
}
