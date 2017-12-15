/* database vendor target: mysql */

delete from subject where subject_id = 1000;
delete from subject where subject_id = 1010;
delete from subject where subject_id = 1020;
delete from subject where subject_id = 1021;
delete from subject where subject_id = 1022;
delete from subject where subject_id = 1023;

insert into subject values(1000, 'agent', '8S1AUtuOHF4ZRsekmr94YGCul0d/59+yYkME8jPdPUQ=', 'Great', null, 'Salesman', 'Mr.', null,  0, 0, null,null, 'agent@agencyport.com', 'system', CURRENT_TIMESTAMP);
insert into subject values(1010, 'agent900', 'zeaydEm1UEa3ipZp+0xrPnLNbzUcNdJ49L+onaO7YPk=', 'Great', null, 'Salesman', 'Mr.', null,  0, 0, null,null, 'agent@agencyport.com', 'system', CURRENT_TIMESTAMP);
insert into subject values(1020, 'agentpl1', 'GKdQXrfNfda3ipZp+0xrPnLNbzUcNdJ49L+onaO7YPk=', 'Great', null, 'PL1 Salesman', 'Mr.', null,  0, 0, null,null, 'agent@agencyport.com', 'system', CURRENT_TIMESTAMP);
insert into subject values(1021, 'agentpl2', '4Ao04BhftQa3ipZp+0xrPnLNbzUcNdJ49L+onaO7YPk=', 'Great', null, 'PL2 Salesman', 'Mr.', null,  0, 0, null,null, 'agent@agencyport.com', 'system', CURRENT_TIMESTAMP);
insert into subject values(1022, 'agentcl1', 'Wk39MkR+dei3ipZp+0xrPnLNbzUcNdJ49L+onaO7YPk=', 'Great', null, 'CL1 Salesman', 'Mr.', null,  0, 0, null,null, 'agent@agencyport.com', 'system', CURRENT_TIMESTAMP);
insert into subject values(1023, 'agentcl2', 'tOQAF6OQwJa3ipZp+0xrPnLNbzUcNdJ49L+onaO7YPk=', 'Great', null, 'CL2 Salesman', 'Mr.', null,  0, 0, null,null, 'agent@agencyport.com', 'system', CURRENT_TIMESTAMP);

/* USER GROUPS */
delete from usergroup;
insert into usergroup(usergroup_id, usergroup_name, usergroup_description, last_update_by, last_update) 
values(100, 'Example Carrier', 'This is the work group established for the carrier. It is the highest level group in the system, and has the ability to see the work of all child work groups. All work groups will be set up as children of this group.', 'system', CURRENT_TIMESTAMP);

insert into usergroup(usergroup_id, usergroup_name, usergroup_description, last_update_by, last_update) 
values(200, 'Example Agency', 'This is an example agency automatically added by the system. It is safe to delete.', 'system', CURRENT_TIMESTAMP);

insert into usergroup(usergroup_id, usergroup_name, usergroup_description, last_update_by, last_update) 
values(900, 'Example Agency 900', 'This is an example agency automatically added by the system. It is safe to delete.', 'system', CURRENT_TIMESTAMP);

insert into usergroup(usergroup_id, usergroup_name, usergroup_description, last_update_by, last_update) 
values(901, 'Example Agency 901', 'This is an example agency automatically added by the system. It is safe to delete.', 'system', CURRENT_TIMESTAMP);


delete from usergroupmember;
insert into usergroupmember values(100, 200, 'group');
insert into usergroupmember values(200, 1000, 'user');
insert into usergroupmember values(200, 1020, 'user');
insert into usergroupmember values(200, 1021, 'user');
insert into usergroupmember values(200, 1022, 'user');
insert into usergroupmember values(200, 1023, 'user');


insert into usergroupmember values(100, 900, 'group');
insert into usergroupmember values(100, 901, 'group');
insert into usergroupmember values(900, 1010, 'user');
insert into usergroupmember values(901, 1010, 'user');

delete from role where  principal_id = 1000;
delete from role where  principal_id = 1020;
delete from role where  principal_id = 1021;
delete from role where  principal_id = 1022;
delete from role where  principal_id = 1023;
delete from role where  principal_id = 1010;

/* Add this subject as a participant in the binder role 
insert into role(role_id, principal_id, principal_type) VALUES (150, 1000, 'user'); */
/* Add this subject as a participant in the personal lines role  */
insert into role(role_id, principal_id, principal_type) VALUES (200, 1000, 'user');
insert into role(role_id, principal_id, principal_type) VALUES (200, 1020, 'user');
insert into role(role_id, principal_id, principal_type) VALUES (200, 1021, 'user');
insert into role(role_id, principal_id, principal_type) VALUES (200, 1010, 'user');

/* Add this subject as a participant in the commerical lines role */
insert into role(role_id, principal_id, principal_type) VALUES (300, 1000, 'user'); 
insert into role(role_id, principal_id, principal_type) VALUES (300, 1022, 'user'); 
insert into role(role_id, principal_id, principal_type) VALUES (300, 1023, 'user');
insert into role(role_id, principal_id, principal_type) VALUES (300, 1010, 'user');

 
/* Add this subject as a participant in the agent role that contains both agentpl and agentcl */ 
insert into role(role_id, principal_id, principal_type) VALUES (100, 1000, 'user');

delete from subject where subject_id = 1001;
delete from subject where subject_id = 1030;
delete from subject where subject_id = 1031;
delete from subject where subject_id = 1011;

insert into subject values(1001, 'underwriter', 'X+TvWMfTK7XKUbm5F9h5ZhKQ5tnnGp6RGRFm1iGmL5gp0DyPeWigvA==', 'Great', null, 'Underwriter', 'Mr.', null,  0, 0, null,null, 'underwriter@agencyport.com', 'system', CURRENT_TIMESTAMP);
insert into subject values(1011, 'underwriter900', 'X+TvWMfTK7Wb6t8mNJEaHMkFxQg7HYcBHwdd49cRuCJNAL4ARIH2zw==', 'Great', null, 'Underwriter', 'Mr.', null,  0, 0, null,null, 'underwriter@agencyport.com', 'system', CURRENT_TIMESTAMP);
insert into subject values(1030, 'underwriterpl', 'X+TvWMfTK7WhW8XGAtSJBRlGx6Sav3hgYK6XR3/n37JiQwTyM909RA==', 'Great', null, 'PL Underwriter', 'Mr.', null,  0, 0, null,null, 'underwriter@agencyport.com', 'system', CURRENT_TIMESTAMP);
insert into subject values(1031, 'underwritercl', 'X+TvWMfTK7VBcYYfw4JmKBlGx6Sav3hgYK6XR3/n37JiQwTyM909RA==', 'Great', null, 'CL Underwriter', 'Mr.', null,  0, 0, null,null, 'underwriter@agencyport.com', 'system', CURRENT_TIMESTAMP);

insert into usergroupmember values(200, 1001, 'user');
insert into usergroupmember values(200, 1030, 'user');
insert into usergroupmember values(200, 1031, 'user');
insert into usergroupmember values(900, 1011, 'user');
insert into usergroupmember values(901, 1011, 'user');

delete from role where  principal_id = 1001;
delete from role where  principal_id = 1030;
delete from role where  principal_id = 1031;
delete from role where  principal_id = 1011;

/* Add this subject as a participant in the binder role
insert into role(role_id, principal_id, principal_type) VALUES (150, 1001, 'user'); */
/* Add this subject as a participant in the agent role that contains both agentpl and agentcl
insert into role(role_id, principal_id, principal_type) VALUES (100, 1001, 'user'); */
/* Add this subject as a participant in the underwriter role */
insert into role(role_id, principal_id, principal_type) VALUES (400, 1001, 'user');
insert into role(role_id, principal_id, principal_type) VALUES (401, 1030, 'user');
insert into role(role_id, principal_id, principal_type) VALUES (402, 1031, 'user');
insert into role(role_id, principal_id, principal_type) VALUES (400, 1011, 'user');

delete from subject where subject_id = 1002;
insert into subject values(1002, 'administrator', '5XpjDTsKPt7wsZGizkglyRlGx6Sav3hgYK6XR3/n37JiQwTyM909RA==', 'Super', null, 'Administrator', 'Mr.', null,  0, 0, null,null, 'admin@agencyport.com', 'system', CURRENT_TIMESTAMP);
insert into usergroupmember values(100, 1002, 'user');
delete from role where  principal_id = 1002;
/* Add this subject as a participant in the adminr role */
insert into role(role_id, principal_id, principal_type) VALUES (800, 1002, 'user');
