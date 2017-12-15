/*Despite the name of this file, mysql doesnt have true sequence support so we create a table to track ids instead*/

create table NextKeyValue
(
	KeyName varchar(255) NOT NULL,
	KeyValue bigint NOT NULL
);
ALTER TABLE NextKeyValue ADD CONSTRAINT pk_NextKeyValue PRIMARY KEY (KeyName);


insert into NextKeyValue(KeyName, KeyValue) VALUES ('FileAttachmentId', 1);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('WorkItemId', 1000);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('audit', 0);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('rtrack', 0);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('WIAssistantFileAttachment', 1);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('WIAssistantComments', 1);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('audit_core', 0);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('audit_rule', 0);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('turnstileFiles', 1);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('view_search_info', 1);
insert into NextKeyValue(KeyName, KeyValue) VALUES ('snippetImageId', 1);

insert into NextKeyValue(KeyName, KeyValue) VALUES ('security',2000);