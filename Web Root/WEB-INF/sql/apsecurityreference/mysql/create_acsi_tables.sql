/* database vendor target: mysql */
CREATE TABLE subject
(   
	subject_id				int NOT NULL,			/* The identity of the subject */
	login_id				varchar(128) NOT NULL,	/* The subject's login id a.k.a. user id - this is not the same as identity */ 
	epassword				varchar(128) NOT NULL,    			/* Passwords should be stored encrypted */      
    first_name              varchar(30),
    middle_name             varchar(20),
    last_name               varchar(40),
    prefix                  varchar(10),
    suffix                  varchar(10),
    invalid_logon_attempts	int NOT NULL,			/* Tracks the number of invalid logon attempts */
    account_locked_status	int NOT NULL,			/* 1 for locked, 0 for unlocked */
    password_expiration		timestamp null,		/* If null, then no expiration is implied */
	account_expiration		timestamp null,		/* If null, then no expiration is implied */
	email_address			varchar(128),			/* The subject's email address */ 
    last_update_by	    	varchar(128) NOT NULL,	/* Should be the login id of the admin which updated this subject */ 
    last_update		    	timestamp NOT NULL
);
ALTER TABLE subject ADD CONSTRAINT pk_subject PRIMARY KEY (subject_id);
CREATE UNIQUE INDEX idx_subject_login_id ON subject ( login_id ASC );

CREATE TABLE usergroup
(   
	usergroup_id			int NOT NULL,
	usergroup_name			varchar(80)  NOT NULL,
	usergroup_description	varchar(256),
    last_update_by	    	varchar(128) NOT NULL,
    last_update		    	timestamp NOT NULL
);
ALTER TABLE usergroup ADD CONSTRAINT pk_usergroup PRIMARY KEY (usergroup_id);
CREATE UNIQUE INDEX idx_usrgroup_name ON usergroup ( usergroup_name ASC );

CREATE TABLE usergroupmember
(   
	usergroup_id			int NOT NULL,    /* Foreign key is usergroup.id */
	member_id				int NOT NULL,	 /* Can be a key to the subject table or to user group table */
	member_type				varchar(8) NOT NULL /* 'user' or 'group' depending on whether the member_id is a user group (recursive) or a subject id */ 
);
ALTER TABLE usergroupmember ADD CONSTRAINT pk_usergroupmember PRIMARY KEY (usergroup_id, member_id);
CREATE INDEX idx_usergroupmember_id ON usergroupmember ( usergroup_id ASC );

CREATE TABLE permission
(   
	permission_id  			int NOT NULL,
	permission_name			varchar(80) NOT NULL,
	permission_description	varchar(256),
    last_update_by	    	varchar(128) NOT NULL,
    last_update		    	timestamp NOT NULL
);
ALTER TABLE permission ADD CONSTRAINT pk_permission PRIMARY KEY (permission_id);
CREATE UNIQUE INDEX idx_permission_name ON permission ( permission_name ASC );

CREATE TABLE rolegroup
(   
	role_id					int NOT NULL,		/* There should always be one role record whose principal_id value matches this */
	role_name   			varchar(80) NOT NULL,
	role_description		varchar(256),
    last_update_by	    	varchar(128) NOT NULL,
    last_update		    	timestamp NOT NULL
);
ALTER TABLE rolegroup ADD CONSTRAINT pk_rolegroup PRIMARY KEY (role_id);
CREATE UNIQUE INDEX idx_rolegroup_name ON rolegroup ( role_name ASC );

CREATE TABLE role
(   
	role_id					int NOT NULL,	    
	principal_id			int not null,		/* This can relate to a rolegroup record or a subject depending on the type field */
	principal_type			varchar(8) NOT NULL 	/* 'user' or 'group' depending on whether the principal is a subject id (most likely) or a role group */ 
);
ALTER TABLE role ADD CONSTRAINT pk_role PRIMARY KEY (role_id, principal_id);
CREATE INDEX idx_role_principal_id ON role ( principal_id ASC );

CREATE TABLE rolepermission
(   
	role_id					int NOT NULL,	
	permission_id			int NOT NULL
);
ALTER TABLE rolepermission ADD CONSTRAINT pk_rolepermission PRIMARY KEY (role_id, permission_id);
CREATE INDEX idx_role_permission_id ON rolepermission ( role_id ASC );
CREATE INDEX idx_permission_id ON rolepermission ( permission_id ASC );

