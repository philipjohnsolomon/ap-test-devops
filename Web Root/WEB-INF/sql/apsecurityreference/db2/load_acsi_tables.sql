/* database vendor target: db2 */


delete from permission;
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (150, 'canBind', 'Can bind policies', 'system', CURRENT TIMESTAMP);

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (200, 'accessAUTOP', 'Access to personal auto work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (201, 'accessUMBRP', 'Access to personal umbrella work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (202, 'accessHOME', 'Access to homeowners work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (203, 'accessDFIRE', 'Access to dwelling fire work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (204, 'accessPPKGE', 'Access to Personal Package work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (205, 'accessBOAT', 'Access to WaterCraft work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (206, 'accessINMRP', 'Access to Personal inland marine work items', 'system', CURRENT TIMESTAMP);

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (300, 'accessAUTOB', 'Access to commercial auto work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (301, 'accessINMRC', 'Access to commercial inland marine auto work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (302, 'accessCPKGE', 'Access to commercial package work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (303, 'accessCRIM', 'Access to commercial crime work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (304, 'accessPROPC', 'Access to commercial property work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (305, 'accessUMBRC', 'Access to commercial umbrella work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (306, 'accessWORK', 'Access to workers compensation work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (307, 'accessBOP', 'Access to business owners policy work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (308, 'accessCGL', 'Access to general liability work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (309, 'accessCFRM', 'Access to farmowners work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (310, 'accessCLACCOUNT', 'Can access to Commercial lines Account', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (311, 'accessPLACCOUNT', 'Can access to Personal lines Account', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (312, 'accessACCOUNT', 'Can access to Account', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (313, 'accessPROF', 'Can access to Professional Liability', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (314, 'accessMROF', 'Access to management liability work items', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (315, 'accessCanClaim', 'Can Claim', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (316, 'accessGARAG', 'Access to Commercial Garage Work Items', 'system', CURRENT TIMESTAMP);


insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (800, 'addSubject', 'Add a subject/user', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (801, 'getSubjects', 'Get subjects', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (802, 'getUserGroups', 'Get user groups', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (803, 'getPermissions', 'Get permissions', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (804, 'getRoles', 'Get roles', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (805, 'removeSubject', 'Remove a subject', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (806, 'modifySubject', 'Modify a subject', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (807, 'addUserGroup', 'Add a user group', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (808, 'removeUserGroup', 'Remove a user group', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (809, 'modifyUserGroup', 'Modify a user group', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (810, 'addMemberToUserGroup', 'Add a member to a user group', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (811, 'removeMemberFromUserGroup', 'Remove a member from a user group', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (812, 'addRole', 'Add a role', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (813, 'removeRole', 'Remove a role', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (814, 'modifyRole', 'Modify a role', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (815, 'addPrincipalToRole', 'Add a principal to role', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (816, 'removePrincipalFromRole', 'Remove a principal from a role', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (817, 'addPermissionToRole', 'Add a permission to a role', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (818, 'removePermissionFromRole', 'Remove a permission from a role', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (819, 'addPermission', 'Add a permission', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (820, 'removePermission', 'Remove a permission', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (821, 'modifyPermission', 'Modify a permission', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (822, 'accessAnalyticsReport', 'View analytics report', 'system', CURRENT TIMESTAMP);


delete from rolegroup;
insert into rolegroup(role_id, role_name, role_description, last_update_by, last_update) VALUES (800, 'admin', 'administrative role', 'system', CURRENT TIMESTAMP);
insert into rolegroup(role_id, role_name, role_description, last_update_by, last_update) VALUES (100, 'agent', 'agent role', 'system', CURRENT TIMESTAMP);
insert into rolegroup(role_id, role_name, role_description, last_update_by, last_update) VALUES (200, 'agentpl', 'agent role personal lines', 'system', CURRENT TIMESTAMP);
insert into rolegroup(role_id, role_name, role_description, last_update_by, last_update) VALUES (300, 'agentcl', 'agent role commercial lines', 'system', CURRENT TIMESTAMP);
insert into rolegroup(role_id, role_name, role_description, last_update_by, last_update) VALUES (400, 'underwriter', 'underwriter role', 'system', CURRENT TIMESTAMP);
insert into rolegroup(role_id, role_name, role_description, last_update_by, last_update) VALUES (401, 'underwriterpl', 'underwriter role personal lines', 'system', CURRENT TIMESTAMP);
insert into rolegroup(role_id, role_name, role_description, last_update_by, last_update) VALUES (402, 'underwritercl', 'underwriter role comml lines', 'system', CURRENT TIMESTAMP);

insert into rolegroup(role_id, role_name, role_description, last_update_by, last_update) VALUES (900, 'agent900', 'agent 900 role', 'system', CURRENT TIMESTAMP);
insert into rolegroup(role_id, role_name, role_description, last_update_by, last_update) VALUES (901, 'agent901', 'agent 901 role', 'system', CURRENT TIMESTAMP);

delete from role;
insert into role(role_id, principal_id, principal_type) VALUES (800, 800, 'group');
insert into role(role_id, principal_id, principal_type) VALUES (100, 100, 'group');
insert into role(role_id, principal_id, principal_type) VALUES (200, 200, 'group');
insert into role(role_id, principal_id, principal_type) VALUES (300, 300, 'group');
insert into role(role_id, principal_id, principal_type) VALUES (400, 400, 'group');
insert into role(role_id, principal_id, principal_type) VALUES (401, 401, 'group');
insert into role(role_id, principal_id, principal_type) VALUES (402, 402, 'group');

insert into role(role_id, principal_id, principal_type) VALUES (900, 900, 'group');
insert into role(role_id, principal_id, principal_type) VALUES (901, 901, 'group');


delete from rolepermission;
insert into rolepermission(role_id, permission_id) VALUES (100, 150);
insert into rolepermission(role_id, permission_id) VALUES (100, 200);
insert into rolepermission(role_id, permission_id) VALUES (100, 201);
insert into rolepermission(role_id, permission_id) VALUES (100, 202);
insert into rolepermission(role_id, permission_id) VALUES (100, 203);
insert into rolepermission(role_id, permission_id) VALUES (100, 204);
insert into rolepermission(role_id, permission_id) VALUES (100, 205);
insert into rolepermission(role_id, permission_id) VALUES (100, 206);
insert into rolepermission(role_id, permission_id) VALUES (100, 300);
insert into rolepermission(role_id, permission_id) VALUES (100, 301);
insert into rolepermission(role_id, permission_id) VALUES (100, 302);
insert into rolepermission(role_id, permission_id) VALUES (100, 303);
insert into rolepermission(role_id, permission_id) VALUES (100, 304);
insert into rolepermission(role_id, permission_id) VALUES (100, 305);
insert into rolepermission(role_id, permission_id) VALUES (100, 306);
insert into rolepermission(role_id, permission_id) VALUES (100, 307);
insert into rolepermission(role_id, permission_id) VALUES (100, 308);
insert into rolepermission(role_id, permission_id) VALUES (100, 309);
insert into rolepermission(role_id, permission_id) VALUES (100, 310);
insert into rolepermission(role_id, permission_id) VALUES (100, 311);
insert into rolepermission(role_id, permission_id) VALUES (100, 312);
insert into rolepermission(role_id, permission_id) VALUES (100, 313);
insert into rolepermission(role_id, permission_id) VALUES (100, 314);
insert into rolepermission(role_id, permission_id) VALUES (100, 315);
insert into rolepermission(role_id, permission_id) VALUES (100, 316);


insert into rolepermission(role_id, permission_id) VALUES (200, 150);
insert into rolepermission(role_id, permission_id) VALUES (200, 200);
insert into rolepermission(role_id, permission_id) VALUES (200, 201);
insert into rolepermission(role_id, permission_id) VALUES (200, 202);
insert into rolepermission(role_id, permission_id) VALUES (200, 203);
insert into rolepermission(role_id, permission_id) VALUES (200, 311);
insert into rolepermission(role_id, permission_id) VALUES (200, 312);
insert into rolepermission(role_id, permission_id) VALUES (200, 313);
insert into rolepermission(role_id, permission_id) VALUES (200, 314);
insert into rolepermission(role_id, permission_id) VALUES (200, 315);

insert into rolepermission(role_id, permission_id) VALUES (900, 150);
insert into rolepermission(role_id, permission_id) VALUES (900, 200);
insert into rolepermission(role_id, permission_id) VALUES (900, 201);
insert into rolepermission(role_id, permission_id) VALUES (900, 202);
insert into rolepermission(role_id, permission_id) VALUES (900, 203);
insert into rolepermission(role_id, permission_id) VALUES (900, 311);
insert into rolepermission(role_id, permission_id) VALUES (900, 312);
insert into rolepermission(role_id, permission_id) VALUES (900, 313);
insert into rolepermission(role_id, permission_id) VALUES (900, 314);
insert into rolepermission(role_id, permission_id) VALUES (900, 315);

insert into rolepermission(role_id, permission_id) VALUES (300, 150);
insert into rolepermission(role_id, permission_id) VALUES (300, 300);
insert into rolepermission(role_id, permission_id) VALUES (300, 301);
insert into rolepermission(role_id, permission_id) VALUES (300, 302);
insert into rolepermission(role_id, permission_id) VALUES (300, 303);
insert into rolepermission(role_id, permission_id) VALUES (300, 304);
insert into rolepermission(role_id, permission_id) VALUES (300, 305);
insert into rolepermission(role_id, permission_id) VALUES (300, 306);
insert into rolepermission(role_id, permission_id) VALUES (300, 307);
insert into rolepermission(role_id, permission_id) VALUES (300, 308);
insert into rolepermission(role_id, permission_id) VALUES (300, 309);
insert into rolepermission(role_id, permission_id) VALUES (300, 310);
insert into rolepermission(role_id, permission_id) VALUES (300, 311);
insert into rolepermission(role_id, permission_id) VALUES (300, 312);
insert into rolepermission(role_id, permission_id) VALUES (300, 313);
insert into rolepermission(role_id, permission_id) VALUES (300, 314);
insert into rolepermission(role_id, permission_id) VALUES (300, 315);


insert into rolepermission(role_id, permission_id) VALUES (400, 150);
insert into rolepermission(role_id, permission_id) VALUES (400, 200);
insert into rolepermission(role_id, permission_id) VALUES (400, 201);
insert into rolepermission(role_id, permission_id) VALUES (400, 202);
insert into rolepermission(role_id, permission_id) VALUES (400, 203);
insert into rolepermission(role_id, permission_id) VALUES (400, 300);
insert into rolepermission(role_id, permission_id) VALUES (400, 301);
insert into rolepermission(role_id, permission_id) VALUES (400, 302);
insert into rolepermission(role_id, permission_id) VALUES (400, 303);
insert into rolepermission(role_id, permission_id) VALUES (400, 304);
insert into rolepermission(role_id, permission_id) VALUES (400, 305);
insert into rolepermission(role_id, permission_id) VALUES (400, 306);
insert into rolepermission(role_id, permission_id) VALUES (400, 307);
insert into rolepermission(role_id, permission_id) VALUES (400, 308);
insert into rolepermission(role_id, permission_id) VALUES (400, 309);
insert into rolepermission(role_id, permission_id) VALUES (400, 310);
insert into rolepermission(role_id, permission_id) VALUES (400, 311);
insert into rolepermission(role_id, permission_id) VALUES (400, 312);
insert into rolepermission(role_id, permission_id) VALUES (400, 313);
insert into rolepermission(role_id, permission_id) VALUES (400, 314);
insert into rolepermission(role_id, permission_id) VALUES (400, 315);
insert into rolepermission(role_id, permission_id) VALUES (400, 822);


insert into rolepermission(role_id, permission_id) VALUES (401, 150);
insert into rolepermission(role_id, permission_id) VALUES (401, 200);
insert into rolepermission(role_id, permission_id) VALUES (401, 201);
insert into rolepermission(role_id, permission_id) VALUES (401, 202);
insert into rolepermission(role_id, permission_id) VALUES (401, 203);
insert into rolepermission(role_id, permission_id) VALUES (401, 311);
insert into rolepermission(role_id, permission_id) VALUES (401, 312);
insert into rolepermission(role_id, permission_id) VALUES (401, 313);
insert into rolepermission(role_id, permission_id) VALUES (401, 314);
insert into rolepermission(role_id, permission_id) VALUES (401, 315);
insert into rolepermission(role_id, permission_id) VALUES (401, 822);

insert into rolepermission(role_id, permission_id) VALUES (402, 150);
insert into rolepermission(role_id, permission_id) VALUES (402, 300);
insert into rolepermission(role_id, permission_id) VALUES (402, 301);
insert into rolepermission(role_id, permission_id) VALUES (402, 302);
insert into rolepermission(role_id, permission_id) VALUES (402, 303);
insert into rolepermission(role_id, permission_id) VALUES (402, 304);
insert into rolepermission(role_id, permission_id) VALUES (402, 305);
insert into rolepermission(role_id, permission_id) VALUES (402, 306);
insert into rolepermission(role_id, permission_id) VALUES (402, 307);
insert into rolepermission(role_id, permission_id) VALUES (402, 308);
insert into rolepermission(role_id, permission_id) VALUES (402, 310);
insert into rolepermission(role_id, permission_id) VALUES (402, 312);
insert into rolepermission(role_id, permission_id) VALUES (402, 313);
insert into rolepermission(role_id, permission_id) VALUES (402, 314);
insert into rolepermission(role_id, permission_id) VALUES (402, 315);
insert into rolepermission(role_id, permission_id) VALUES (402, 822);

insert into rolepermission(role_id, permission_id) VALUES (800, 800);
insert into rolepermission(role_id, permission_id) VALUES (800, 801);
insert into rolepermission(role_id, permission_id) VALUES (800, 802);
insert into rolepermission(role_id, permission_id) VALUES (800, 803);
insert into rolepermission(role_id, permission_id) VALUES (800, 804);
insert into rolepermission(role_id, permission_id) VALUES (800, 805);
insert into rolepermission(role_id, permission_id) VALUES (800, 806);
insert into rolepermission(role_id, permission_id) VALUES (800, 807);
insert into rolepermission(role_id, permission_id) VALUES (800, 808);
insert into rolepermission(role_id, permission_id) VALUES (800, 809);
insert into rolepermission(role_id, permission_id) VALUES (800, 810);
insert into rolepermission(role_id, permission_id) VALUES (800, 811);
insert into rolepermission(role_id, permission_id) VALUES (800, 812);
insert into rolepermission(role_id, permission_id) VALUES (800, 813);
insert into rolepermission(role_id, permission_id) VALUES (800, 814);
insert into rolepermission(role_id, permission_id) VALUES (800, 815);
insert into rolepermission(role_id, permission_id) VALUES (800, 816);
insert into rolepermission(role_id, permission_id) VALUES (800, 817);
insert into rolepermission(role_id, permission_id) VALUES (800, 818);
insert into rolepermission(role_id, permission_id) VALUES (800, 819);
insert into rolepermission(role_id, permission_id) VALUES (800, 820);
insert into rolepermission(role_id, permission_id) VALUES (800, 821);
insert into rolepermission(role_id, permission_id) VALUES (800, 822);

insert into rolepermission(role_id, permission_id) VALUES (800, 150);
insert into rolepermission(role_id, permission_id) VALUES (800, 200);
insert into rolepermission(role_id, permission_id) VALUES (800, 201);
insert into rolepermission(role_id, permission_id) VALUES (800, 202);
insert into rolepermission(role_id, permission_id) VALUES (800, 203);
insert into rolepermission(role_id, permission_id) VALUES (800, 300);
insert into rolepermission(role_id, permission_id) VALUES (800, 301);
insert into rolepermission(role_id, permission_id) VALUES (800, 302);
insert into rolepermission(role_id, permission_id) VALUES (800, 303);
insert into rolepermission(role_id, permission_id) VALUES (800, 304);
insert into rolepermission(role_id, permission_id) VALUES (800, 305);
insert into rolepermission(role_id, permission_id) VALUES (800, 306);
insert into rolepermission(role_id, permission_id) VALUES (800, 307);
insert into rolepermission(role_id, permission_id) VALUES (800, 308);
insert into rolepermission(role_id, permission_id) VALUES (800, 309);
insert into rolepermission(role_id, permission_id) VALUES (800, 310); 
insert into rolepermission(role_id, permission_id) VALUES (800, 311);
insert into rolepermission(role_id, permission_id) VALUES (800, 312);
insert into rolepermission(role_id, permission_id) VALUES (800, 313);
insert into rolepermission(role_id, permission_id) VALUES (800, 314);
insert into rolepermission(role_id, permission_id) VALUES (800, 315);



/*INSERT PERMISSIONS FOR MENU*/
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (899, 'accessMenu_My Reports', 'Access My Report Menu', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (900, 'accessMenu_Home', 'Access Home Menu', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (901, 'accessMenu_My Work', 'Access My Work Menu', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (902, 'accessMenu_My Accounts', 'Access My Accounts Menu', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (903, 'accessMenu_Toolkit', 'Access Toolkit Menu', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (904, 'accessMenu_Settings', 'Access Settings Menu', 'system', CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (905, 'accessMenu_Users', 'Access Users Menu', 'system', CURRENT TIMESTAMP);


/* PERMISSION TO ROLES */
insert into rolepermission(role_id, permission_id) VALUES (800, 899);
insert into rolepermission(role_id, permission_id) VALUES (800, 900);
insert into rolepermission(role_id, permission_id) VALUES (800, 901);
insert into rolepermission(role_id, permission_id) VALUES (800, 902);
insert into rolepermission(role_id, permission_id) VALUES (800, 903);
insert into rolepermission(role_id, permission_id) VALUES (800, 904);
insert into rolepermission(role_id, permission_id) VALUES (800, 905);

insert into rolepermission(role_id, permission_id) VALUES (100, 899);
insert into rolepermission(role_id, permission_id) VALUES (100, 900);
insert into rolepermission(role_id, permission_id) VALUES (100, 901);
insert into rolepermission(role_id, permission_id) VALUES (100, 902);

insert into rolepermission(role_id, permission_id) VALUES (200, 899);
insert into rolepermission(role_id, permission_id) VALUES (200, 900);
insert into rolepermission(role_id, permission_id) VALUES (200, 901);
insert into rolepermission(role_id, permission_id) VALUES (200, 902);

insert into rolepermission(role_id, permission_id) VALUES (900, 899);
insert into rolepermission(role_id, permission_id) VALUES (900, 900);
insert into rolepermission(role_id, permission_id) VALUES (900, 901);
insert into rolepermission(role_id, permission_id) VALUES (900, 902);

insert into rolepermission(role_id, permission_id) VALUES (300, 899);
insert into rolepermission(role_id, permission_id) VALUES (300, 900);
insert into rolepermission(role_id, permission_id) VALUES (300, 901);
insert into rolepermission(role_id, permission_id) VALUES (300, 902);

insert into rolepermission(role_id, permission_id) VALUES (400, 899);
insert into rolepermission(role_id, permission_id) VALUES (400, 900);
insert into rolepermission(role_id, permission_id) VALUES (400, 901);
insert into rolepermission(role_id, permission_id) VALUES (400, 902);

insert into rolepermission(role_id, permission_id) VALUES (401, 899);
insert into rolepermission(role_id, permission_id) VALUES (401, 900);
insert into rolepermission(role_id, permission_id) VALUES (401, 901);
insert into rolepermission(role_id, permission_id) VALUES (401, 902);

insert into rolepermission(role_id, permission_id) VALUES (402, 899);
insert into rolepermission(role_id, permission_id) VALUES (402, 900);
insert into rolepermission(role_id, permission_id) VALUES (402, 901);
insert into rolepermission(role_id, permission_id) VALUES (402, 902);

/* Work List
	Abiliy to view a particular work list is a permission.
		
*/
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (906, 'canViewAgentWorkItemsView', 'Can View Agent Work Items View', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (907, 'canViewUnderWriterWorkItemsView', 'Can View UnderWriter Work Items View', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (908, 'canViewAdminWorkItemsView', 'Can View Admin Work Items View', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (920, 'canViewUnderWriterPendingItemsView', 'Can View Admin/UW Pending Upload Work Items View', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (921, 'canViewAgentPendingItemsView', 'Can View Agent Pending Upload Work Items View', 'system',  CURRENT TIMESTAMP);
insert into rolepermission(role_id, permission_id) VALUES (100, 906); 
insert into rolepermission(role_id, permission_id) VALUES (200, 906); 
insert into rolepermission(role_id, permission_id) VALUES (300, 906); 
insert into rolepermission(role_id, permission_id) VALUES (400, 907); 
insert into rolepermission(role_id, permission_id) VALUES (401, 907); 
insert into rolepermission(role_id, permission_id) VALUES (402, 907); 
insert into rolepermission(role_id, permission_id) VALUES (800, 908); 
insert into rolepermission(role_id, permission_id) VALUES (400, 920); 
insert into rolepermission(role_id, permission_id) VALUES (401, 920); 
insert into rolepermission(role_id, permission_id) VALUES (402, 920); 
insert into rolepermission(role_id, permission_id) VALUES (800, 920);
insert into rolepermission(role_id, permission_id) VALUES (100, 921); 
insert into rolepermission(role_id, permission_id) VALUES (200, 921); 
insert into rolepermission(role_id, permission_id) VALUES (300, 921);

insert into rolepermission(role_id, permission_id) VALUES (900, 906); 
insert into rolepermission(role_id, permission_id) VALUES (900, 921);

/* 
	Action Permission
*/

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (909, 'accessCanDelete', 'Can Delete Work Item', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (911, 'accessCanCopy', 'Can Copy Work Item', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (930, 'accessCanViewAccount', 'Can View Account', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (931, 'accessCanMove', 'Can Move Work Item', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (932, 'accessCanMerge', 'Can Merge Account', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (933, 'accessCanOpen',  'Can Open', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (934, 'accessCanApprove',  'Can Approve', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (935, 'accessCanLink', 'Can Link Work Item', 'system',  CURRENT TIMESTAMP);

insert into rolepermission(role_id, permission_id) VALUES (100, 909); 
insert into rolepermission(role_id, permission_id) VALUES (100, 911); 
insert into rolepermission(role_id, permission_id) VALUES (100, 930);
insert into rolepermission(role_id, permission_id) VALUES (100, 931);
insert into rolepermission(role_id, permission_id) VALUES (100, 932);
insert into rolepermission(role_id, permission_id) VALUES (100, 933);
insert into rolepermission(role_id, permission_id) VALUES (100, 935);

insert into rolepermission(role_id, permission_id) VALUES (200, 909); 
insert into rolepermission(role_id, permission_id) VALUES (200, 911); 
insert into rolepermission(role_id, permission_id) VALUES (200, 930);
insert into rolepermission(role_id, permission_id) VALUES (200, 931);
insert into rolepermission(role_id, permission_id) VALUES (200, 932);
insert into rolepermission(role_id, permission_id) VALUES (200, 933);
insert into rolepermission(role_id, permission_id) VALUES (200, 935);

insert into rolepermission(role_id, permission_id) VALUES (900, 909); 
insert into rolepermission(role_id, permission_id) VALUES (900, 911); 
insert into rolepermission(role_id, permission_id) VALUES (900, 930);
insert into rolepermission(role_id, permission_id) VALUES (900, 931);
insert into rolepermission(role_id, permission_id) VALUES (900, 932);
insert into rolepermission(role_id, permission_id) VALUES (900, 933);
insert into rolepermission(role_id, permission_id) VALUES (900, 935);


insert into rolepermission(role_id, permission_id) VALUES (300, 909); 
insert into rolepermission(role_id, permission_id) VALUES (300, 911); 
insert into rolepermission(role_id, permission_id) VALUES (300, 930);
insert into rolepermission(role_id, permission_id) VALUES (300, 931);
insert into rolepermission(role_id, permission_id) VALUES (300, 932);
insert into rolepermission(role_id, permission_id) VALUES (300, 933);
insert into rolepermission(role_id, permission_id) VALUES (300, 935);

insert into rolepermission(role_id, permission_id) VALUES (400, 909); 
insert into rolepermission(role_id, permission_id) VALUES (400, 911); 
insert into rolepermission(role_id, permission_id) VALUES (400, 930);
insert into rolepermission(role_id, permission_id) VALUES (400, 931);
insert into rolepermission(role_id, permission_id) VALUES (400, 932);
insert into rolepermission(role_id, permission_id) VALUES (400, 933);
insert into rolepermission(role_id, permission_id) VALUES (400, 934);
insert into rolepermission(role_id, permission_id) VALUES (400, 935);

insert into rolepermission(role_id, permission_id) VALUES (401, 909); 
insert into rolepermission(role_id, permission_id) VALUES (401, 911); 
insert into rolepermission(role_id, permission_id) VALUES (401, 930);
insert into rolepermission(role_id, permission_id) VALUES (401, 931);
insert into rolepermission(role_id, permission_id) VALUES (401, 932);
insert into rolepermission(role_id, permission_id) VALUES (401, 933);
insert into rolepermission(role_id, permission_id) VALUES (401, 934);
insert into rolepermission(role_id, permission_id) VALUES (401, 935);

insert into rolepermission(role_id, permission_id) VALUES (402, 909);
insert into rolepermission(role_id, permission_id) VALUES (402, 911); 
insert into rolepermission(role_id, permission_id) VALUES (402, 930); 
insert into rolepermission(role_id, permission_id) VALUES (402, 931); 
insert into rolepermission(role_id, permission_id) VALUES (402, 932);
insert into rolepermission(role_id, permission_id) VALUES (402, 933); 
insert into rolepermission(role_id, permission_id) VALUES (402, 934);
insert into rolepermission(role_id, permission_id) VALUES (402, 935);

insert into rolepermission(role_id, permission_id) VALUES (800, 909); 
insert into rolepermission(role_id, permission_id) VALUES (800, 911); 
insert into rolepermission(role_id, permission_id) VALUES (800, 930); 
insert into rolepermission(role_id, permission_id) VALUES (800, 931); 
insert into rolepermission(role_id, permission_id) VALUES (800, 932);
insert into rolepermission(role_id, permission_id) VALUES (800, 933);
insert into rolepermission(role_id, permission_id) VALUES (800, 935);

/*
* Dashboard report permission
*/

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (912, 'canViewTotalSubmissions', 'Can View Total Submissions', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (913, 'canViewMonthlySubmissions', 'Can View Monthly Submissions', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (914, 'canViewMonthlySubmissionsPremium', 'Can View Monthly Submissions Premium', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (915, 'canViewTopTenUnderWritingRules', 'Can View Top Ten Under Writing Rules', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (916, 'canViewLOBSubmissionsByStatus', 'Can View LOB Submissions By Status', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (917, 'canViewTransactionAudit', 'Can View Transaction Audit', 'system',  CURRENT TIMESTAMP);
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (918, 'canViewTotalSubmissionsPremium', 'Can View TotalSubmissions Premium', 'system',  CURRENT TIMESTAMP);

insert into rolepermission(role_id, permission_id) VALUES (100, 912); 
insert into rolepermission(role_id, permission_id) VALUES (100, 913); 
insert into rolepermission(role_id, permission_id) VALUES (100, 914); 
insert into rolepermission(role_id, permission_id) VALUES (100, 916); 
insert into rolepermission(role_id, permission_id) VALUES (100, 918); 

insert into rolepermission(role_id, permission_id) VALUES (200, 912); 
insert into rolepermission(role_id, permission_id) VALUES (200, 913); 
insert into rolepermission(role_id, permission_id) VALUES (200, 914); 
insert into rolepermission(role_id, permission_id) VALUES (200, 916); 
insert into rolepermission(role_id, permission_id) VALUES (200, 918); 

insert into rolepermission(role_id, permission_id) VALUES (900, 912); 
insert into rolepermission(role_id, permission_id) VALUES (900, 913); 
insert into rolepermission(role_id, permission_id) VALUES (900, 914); 
insert into rolepermission(role_id, permission_id) VALUES (900, 916); 
insert into rolepermission(role_id, permission_id) VALUES (900, 918); 


insert into rolepermission(role_id, permission_id) VALUES (300, 912); 
insert into rolepermission(role_id, permission_id) VALUES (300, 913); 
insert into rolepermission(role_id, permission_id) VALUES (300, 914); 
insert into rolepermission(role_id, permission_id) VALUES (300, 916); 
insert into rolepermission(role_id, permission_id) VALUES (300, 918); 

insert into rolepermission(role_id, permission_id) VALUES (400, 912); 
insert into rolepermission(role_id, permission_id) VALUES (400, 913); 
insert into rolepermission(role_id, permission_id) VALUES (400, 914); 
insert into rolepermission(role_id, permission_id) VALUES (400, 915);
insert into rolepermission(role_id, permission_id) VALUES (400, 916);
insert into rolepermission(role_id, permission_id) VALUES (400, 917); 
insert into rolepermission(role_id, permission_id) VALUES (400, 918); 

insert into rolepermission(role_id, permission_id) VALUES (401, 912); 
insert into rolepermission(role_id, permission_id) VALUES (401, 913); 
insert into rolepermission(role_id, permission_id) VALUES (401, 914); 
insert into rolepermission(role_id, permission_id) VALUES (401, 915);
insert into rolepermission(role_id, permission_id) VALUES (401, 916);
insert into rolepermission(role_id, permission_id) VALUES (401, 917); 
insert into rolepermission(role_id, permission_id) VALUES (401, 918);

insert into rolepermission(role_id, permission_id) VALUES (402, 912); 
insert into rolepermission(role_id, permission_id) VALUES (402, 913); 
insert into rolepermission(role_id, permission_id) VALUES (402, 914); 
insert into rolepermission(role_id, permission_id) VALUES (402, 915);
insert into rolepermission(role_id, permission_id) VALUES (402, 916);
insert into rolepermission(role_id, permission_id) VALUES (402, 917); 
insert into rolepermission(role_id, permission_id) VALUES (402, 918);

insert into rolepermission(role_id, permission_id) VALUES (800, 912); 
insert into rolepermission(role_id, permission_id) VALUES (800, 913); 
insert into rolepermission(role_id, permission_id) VALUES (800, 914); 
insert into rolepermission(role_id, permission_id) VALUES (800, 915);
insert into rolepermission(role_id, permission_id) VALUES (800, 916);
insert into rolepermission(role_id, permission_id) VALUES (800, 917); 
insert into rolepermission(role_id, permission_id) VALUES (800, 918); 
 

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (919, 'canAccessTimeline', 'Can access to Timeline', 'system',  CURRENT TIMESTAMP);
insert into rolepermission(role_id, permission_id) VALUES (100, 919); 
insert into rolepermission(role_id, permission_id) VALUES (200, 919); 
insert into rolepermission(role_id, permission_id) VALUES (300, 919); 
insert into rolepermission(role_id, permission_id) VALUES (400, 919); 
insert into rolepermission(role_id, permission_id) VALUES (401, 919); 
insert into rolepermission(role_id, permission_id) VALUES (402, 919); 
insert into rolepermission(role_id, permission_id) VALUES (800, 919); 
insert into rolepermission(role_id, permission_id) VALUES (900, 919); 

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (950, 'canViewAdminAccountsView', 'Can View Admin Account Items View', 'system',  CURRENT TIMESTAMP);
insert into rolepermission(role_id, permission_id) VALUES (400, 950); 
insert into rolepermission(role_id, permission_id) VALUES (401, 950); 
insert into rolepermission(role_id, permission_id) VALUES (402, 950); 
insert into rolepermission(role_id, permission_id) VALUES (800, 950); 

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (960, 'canViewAccountItemsView', 'Can View Admin and Underwriter Account Work Items View', 'system',  CURRENT TIMESTAMP); 
insert into rolepermission(role_id, permission_id) VALUES (400, 960); 
insert into rolepermission(role_id, permission_id) VALUES (401, 960); 
insert into rolepermission(role_id, permission_id) VALUES (402, 960); 
insert into rolepermission(role_id, permission_id) VALUES (800, 960); 

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (970, 'canViewAgentAccountItemsView', 'Can View Agent Account Work Items View', 'system',  CURRENT TIMESTAMP); 
insert into rolepermission(role_id, permission_id) VALUES (100, 970); 
insert into rolepermission(role_id, permission_id) VALUES (200, 970); 
insert into rolepermission(role_id, permission_id) VALUES (300, 970);

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (980, 'canViewAgentAccountsView', 'Can View Admin Account Work Items View', 'system',  CURRENT TIMESTAMP);
insert into rolepermission(role_id, permission_id) VALUES (100, 980); 
insert into rolepermission(role_id, permission_id) VALUES (200, 980); 
insert into rolepermission(role_id, permission_id) VALUES (300, 980); 
insert into rolepermission(role_id, permission_id) VALUES (900, 980); 

insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (1100, 'canAccessActivityTracker', 'View event update', 'system', CURRENT TIMESTAMP);
insert into rolepermission(role_id, permission_id) VALUES (100, 1100); 
insert into rolepermission(role_id, permission_id) VALUES (200, 1100); 
insert into rolepermission(role_id, permission_id) VALUES (300, 1100); 
insert into rolepermission(role_id, permission_id) VALUES (400, 1100); 
insert into rolepermission(role_id, permission_id) VALUES (401, 1100); 
insert into rolepermission(role_id, permission_id) VALUES (402, 1100); 
insert into rolepermission(role_id, permission_id) VALUES (800, 1100); 
insert into rolepermission(role_id, permission_id) VALUES (900, 1100); 
/*
* WORK ITEM ASSISTANT: delete attached file  permission
*/
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES (1110, 'canDeleteWorkItemAssistantAttachedFile', 'permision to delete attached files', 'system', CURRENT TIMESTAMP);
insert into rolepermission(role_id, permission_id) VALUES (400, 1110); 
insert into rolepermission(role_id, permission_id) VALUES (401, 1110); 
insert into rolepermission(role_id, permission_id) VALUES (402, 1110); 

/*
* Underwriter ability to view secure field data
*/
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) VALUES(1200, 'canReadSecureData', 'Can read the raw values of a work items TDF fields which have an enabled SecureDataEntryMode', 'system', CURRENT TIMESTAMP);
insert into rolepermission VALUES(400, 1200);
insert into rolepermission VALUES(800, 1200);


/*
* Solr administration
*/
insert into permission (permission_id, permission_name, permission_description, last_update_by, last_update) values (937, 'accessMenu_Solr_Admin', 'Access Solr Administration link in main menu', 'system', CURRENT TIMESTAMP);
insert into rolepermission (role_id, permission_id) values (800, 937);

/* Endorse Work Item Permissions */
insert into permission (permission_id, permission_name, permission_description, last_update_by, last_update) 
values (938, 'accessCanEndorse', 'Can Endorse Work Item', 'system', CURRENT TIMESTAMP);

insert into rolepermission (role_id, permission_id) values (100, 938);
insert into rolepermission (role_id, permission_id) values (200, 938);
insert into rolepermission (role_id, permission_id) values (300, 938);
insert into rolepermission (role_id, permission_id) values (400, 938);
insert into rolepermission (role_id, permission_id) values (401, 938);
insert into rolepermission (role_id, permission_id) values (402, 938);
insert into rolepermission (role_id, permission_id) values (800, 938);
insert into rolepermission (role_id, permission_id) values (900, 938);
insert into rolepermission (role_id, permission_id) values (901, 938);

/* Allocate fine grained permission for authority to execute inbound SOAP web services whose intent is to update accounts, work items or other database tables */
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) 
VALUES (10001, 'canExecuteSynchronizationServices', 'Authorization to execute incoming web service traffic for the synchronizing database with external system', 'system', CURRENT TIMESTAMP);

insert into rolepermission (role_id, permission_id) values (100, 10001);
insert into rolepermission (role_id, permission_id) values (200, 10001);
insert into rolepermission (role_id, permission_id) values (300, 10001);
insert into rolepermission (role_id, permission_id) values (400, 10001);
insert into rolepermission (role_id, permission_id) values (401, 10001);
insert into rolepermission (role_id, permission_id) values (402, 10001);
insert into rolepermission (role_id, permission_id) values (800, 10001);
insert into rolepermission (role_id, permission_id) values (900, 10001);
insert into rolepermission (role_id, permission_id) values (901, 10001);

/* 
* DebugProvider (debug console) permission
*/
insert into permission(permission_id, permission_name, permission_description, last_update_by, last_update) 
VALUES (11001, 'canExecuteDebugProvider', 'Authorization to execute the debug provider (debug console)', 'system', CURRENT TIMESTAMP);
insert into rolepermission (role_id, permission_id) values (800, 11001);
