insert into locale_entries (id, locale_id, language_code, country_code, variant, description) values (1, 1, 'en', 'US', '*', 'US English');
insert into locale_entries (id, locale_id, language_code, country_code, variant, description) values (2, 1, 'en', '*', '*', 'English');

delete from code_list;	

/* Transaction types */
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES(100, 1, 'ENDORSEMENT', 'Endorsement'); 	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES(100, 1, 'RENEWAL', 'Renewal'); 	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES(100, 1, 'REISSUE', 'Reissue'); 	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES(100, 1, 'NEW_BUSINESS', 'Full Application'); 	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES(100, 1, 'QUICK_QUOTE', 'Quick Quote'); 	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES(100, 1, 'INTERVIEW', 'Interview');
/* 4.5 Account Management */ 
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES(100, 1, 'ACCOUNT', 'Account');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES(100, 1, 'CLAIM', 'Claim');
	
	
/* LOB Codes */
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'AUTOB', 'Commercial Auto');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'AUTOP', 'Personal Auto');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'BANDM', 'Boiler and Machinery');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'BOAT', 'Watercraft');		
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'BOP', 'Business Owners');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'BOPGL', 'BOP Liability');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'BOPPR', 'BOP Property');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CAVN', 'Commercial Aviation');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CEQFL', 'Contractors Equipment Floater');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CFIRE', 'Commercial Fire');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CFRM', 'Farm Owners');				
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CGL', 'Liability');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'COMAR', 'Commercial Articles');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'COMR', 'Ocean Marine');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CONTR', 'Contract');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CPKGE', 'Commercial Package');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CPMP', 'Commercial Multi Peril');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CRIM', 'Crime');		
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'CRIME', 'Crime (includes Burglary)');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'DFIRE', 'Dwelling Fire');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'DISAB', 'Disability');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'DO', 'Directors And Officers');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'EDP', 'Computers');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'EL', 'Employers Liability');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'EO', 'Errors and Omissions');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'EPLI', 'Employment Practices Liability Insurance');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'EQ', 'Earthquake');		
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'EQPFL', 'Equipment Floater');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'EXLIA', 'Excess Liability');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'FIDTY', 'Fidelity');		
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'FINEA', 'Fine Arts');		
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'FLOOD', 'Flood');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'GARAG', 'Garage and Dealers');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'GL', 'General Liability');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'GLASS', 'Glass');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'HBB', 'Home Based Business');		
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'HOME', 'Homeowners');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'INBR', 'Installation/Builders Risk');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'INMAR', 'Inland Marine');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'INMRC', 'Inland Marine (commercial)');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'INMRP', 'Inland Marine (personal lines)');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'JUDCL', 'Judicial');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'LICPT', 'License and Permit');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'LSTIN', 'Lost Instrument');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'MHOME', 'Mobile Homeowners');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'MMAL', 'Medical Malpractice');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'MTRTK', 'Motor Truck Cargo');		
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'NWFGR', 'New Financial Guarantee');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'OLIB', 'Other Liability');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'PAPER', 'Valuable papers');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'PHYS', 'Physicians and Surgeons');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'PPKGE', 'Personal Package');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'PROP', 'Property (includes Dwelling and Fire)');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'PROPC', 'Commercial Property');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'PUBOF', 'Public Official');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'RECV', 'Recreational Vehicles');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'SCAP', 'Small Commercial Package');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'SCHPR', 'Scheduled Property');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'SFRNC', 'Small Farm/Ranch');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'SIGNS', 'Signs');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'SMP', 'Special Multi-Peril');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'TRANS', 'Transportation');			
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'TRUCK', 'Truckers');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'UMBRC', 'Umbrella - Commercial');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'UMBRL', 'Umbrella');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'UMBRP', 'Personal Umbrella');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'UN', 'Unknown');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'WCMA', 'Workers Comp Marine');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'WIND', 'Wind Policy');	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'WORK', 'Workers Comp');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'WORKP', 'Workers Comp Participating');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'Commercial', 'Commercial');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'Personal', 'Personal');
	
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'PROF', 'Professional Liability');
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES (200, 1, 'MROF', 'Management Liability');
	
	
/* 4.5 Account Management */ 
INSERT INTO code_list(code_list_id, locale_id, value, title)
	VALUES(200, 1, 'ACCOUNT', 'Account');
