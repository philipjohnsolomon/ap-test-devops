/* database vendor target: mysql */

create table commlauto_codelists (
	state_id				varchar (2),
	codelist_id 			varchar (150) not null,
	display					varchar (150) not null,
	codelist_value			varchar (150),
	special_vehicle_id		varchar (5)
);

create index idx_commlauto_codelists_state on commlauto_codelists (state_id, codelist_id);
create index idx_commlauto_codelists_veh on commlauto_codelists (special_vehicle_id, codelist_id);
