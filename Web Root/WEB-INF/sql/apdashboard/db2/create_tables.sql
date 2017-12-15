CREATE TABLE report
(
    report_id	        	integer NOT NULL,
    is_drill_down			smallint NOT NULL,
    sql_id					integer NOT NULL,
    default_chart_id		integer,
    default_list_id			integer,
    drill_down_report_id	integer,
    report_name             varchar(64) NOT NULL,
    report_description		varchar(256),
    permission 				varchar(50),
    rpt_engine_class_name 	varchar(128),
    rpt_servlet				varchar(32),
    more_chart_settings		long varchar
);
ALTER TABLE report ADD CONSTRAINT pk_report PRIMARY KEY (report_id);

CREATE TABLE report_sql
(
    sql_id	        		integer NOT NULL,
    report_sql             	long varchar NOT NULL
);
ALTER TABLE report_sql ADD CONSTRAINT pk_report_sql PRIMARY KEY (sql_id);

CREATE TABLE report_params
(
    report_id	        	integer NOT NULL,
    param_num				integer NOT NULL,
    param_name				varchar(32) NOT NULL,
    param_type				varchar(32) NOT NULL,
    default_value			varchar(32),
	is_drill_down			integer
);
ALTER TABLE report_params ADD CONSTRAINT pk_report_params PRIMARY KEY (report_id, param_name);

CREATE TABLE report_results
(
    report_id	        	integer NOT NULL,
    result_num				integer NOT NULL,
  	result_type				varchar(32) NOT NULL,
  	is_series				smallint,
  	is_gid					smallint NOT NULL,
  	is_value				smallint NOT NULL,
    default_value			varchar(32)
);
ALTER TABLE report_results ADD CONSTRAINT pk_report_results PRIMARY KEY (report_id, result_num);

CREATE TABLE chart
(
   	chart_id	        	integer NOT NULL,
    chart_type				varchar(10) NOT NULL,
    swf						varchar(64) NOT NULL,
    settings_file			varchar(64) NOT NULL,
    chart_path				varchar(32),
	output_format			varchar(5)
);
ALTER TABLE chart ADD CONSTRAINT pk_chart PRIMARY KEY (chart_id);

CREATE TABLE t1
(
	id			int
);

CREATE TABLE t500
(
	id			int
);

ALTER TABLE report_params   ADD  CONSTRAINT fk_rp_param_rep_id  FOREIGN KEY  ( report_id )  REFERENCES report ( report_id );
ALTER TABLE report_results   ADD  CONSTRAINT fk_rp_res_rep_id  FOREIGN KEY  ( report_id )  REFERENCES report ( report_id );
ALTER TABLE report   ADD  CONSTRAINT fk_report_chart_id  FOREIGN KEY  ( default_chart_id )  REFERENCES chart ( chart_id );
