delete from report_params;
delete from report_results;
delete from report;
delete from report_sql;
delete from chart;
delete from t1;
delete from t500;
INSERT INTO t1 (id) VALUES(1); 

/* Create chart templates */
INSERT INTO chart
	(chart_id, chart_type, swf, settings_file, chart_path, output_format)    	 
	VALUES(1, 'pie', 'ampie.swf', 'pie_settings.xml', null, 'xml');  
INSERT INTO chart
	(chart_id, chart_type, swf, settings_file, chart_path, output_format)    	 
	VALUES(2, 'column', 'amcolumn.swf', 'column_settings.xml', null, 'xml');  
INSERT INTO chart
	(chart_id, chart_type, swf, settings_file, chart_path, output_format)    	 
	VALUES(3, 'line', 'amline.swf', 'line_settings.xml', null, 'xml');

/* Total submissions report - id 100 */
INSERT INTO report 
	(report_id, is_drill_down, sql_id, default_chart_id, default_list_id, drill_down_report_id, report_name, report_description, permission, rpt_engine_class_name, rpt_servlet, more_chart_settings)
    VALUES(100, 0, 100, 1, null, 104, 'Total Submissions', 'submissions by LOB', 'canViewTotalSubmissions', null, null, null);

INSERT INTO report_sql 
	(sql_id, report_sql)
    VALUES (100,
   	'SELECT w.LOB, COUNT(1) FROM ${db_table_prefix}work_item w 
	where w.effective_date >= ? and w.effective_date <= ? 
	and w.user_group_id in (${user_groups}) and w.status <> 55 
	and w.commit_flag <> 0 GROUP BY w.LOB'
   	);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (100, 1, 'start_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (100, 2, 'end_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (100, -1, 'user_groups', 'user_groups', null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (100, 1, 'LOB', null, 1, 0, null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (100, 2, 'numeric', null, 0, 1, null);

/* Monthly submissions report - id 101 */
INSERT INTO report 
	(report_id, is_drill_down, sql_id, default_chart_id, default_list_id, drill_down_report_id, report_name, report_description, permission, rpt_engine_class_name, rpt_servlet, more_chart_settings)
    VALUES(101, 0, 1000, 2, null, null, 'Monthly Submissions', 'submissions by LOB by month', 'canViewMonthlySubmissions', null, null, null); 
/* SQL is database specific */ 
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (101, 1, 'start_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (101, 2, 'end_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (101, -1, 'math_function', 'string', 'count');
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value,is_drill_down)
    VALUES (101, -1, 'GID', 'string', 'LOB',1);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (101, -1, 'VALUE', 'string', 'LOB');
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (101, -1, 'user_groups', 'user_groups', null);
    
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (101, 1, 'date', 1, 0, 0, null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (101, 2, 'LOB', 0, 1, 0, null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (101, 3, 'numeric', 0, 0, 1, '0.00');

/* Monthly premiums report - id 102 */
INSERT INTO report 
	(report_id, is_drill_down, sql_id, default_chart_id, default_list_id, drill_down_report_id, report_name, report_description, permission, rpt_engine_class_name, rpt_servlet, more_chart_settings)
    VALUES(102, 0, 1000, 3, null, null, 'Monthly Submissions Premium', 'Premium totals by LOB by month', 'canViewMonthlySubmissionsPremium', null, null, null);
/* SQL is database specific */ 
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (102, 1, 'start_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (102, 2, 'end_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (102, -1, 'math_function', 'string', 'sum');
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value,is_drill_down)
    VALUES (102, -1, 'GID', 'string', 'LOB',1);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (102, -1, 'VALUE', 'string', 'premium');
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (102, -1, 'user_groups', 'user_groups', null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (102, 1, 'date', 1, 0, 0, null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (102, 2, 'LOB', 0, 1, 0, null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (102, 3, 'numeric', 0, 0, 1, '0.00');
    
/* TOP broken rules report - id 103 */
INSERT INTO report 
	(report_id, is_drill_down, sql_id, default_chart_id, default_list_id, drill_down_report_id, report_name, report_description, permission, rpt_engine_class_name, rpt_servlet, more_chart_settings)
    VALUES(103, 0, 1001, 2, null, 107, 'Top Broken Underwriting Rules', 'top 10 broken underwriting rules', 'canViewTopTenUnderWritingRules', null, null, null);
/* SQL is database specific */ 
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (103, 1, 'start_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (103, 2, 'end_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (103, -1, 'user_groups', 'user_groups', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value,is_drill_down)
    VALUES (103, -1, 'LOB', 'LOB', null,1);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (103, 1, 'string', 1, 0, 0, null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (103, 2, 'numeric', 0, 1, 0, null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (103, 3, 'numeric', 0, 0, 1, null);
   		
	/* Total  premiums report - id 106 */
INSERT INTO report 
	(report_id, is_drill_down, sql_id, default_chart_id, default_list_id, drill_down_report_id, report_name, report_description, permission, rpt_engine_class_name, rpt_servlet, more_chart_settings)
    VALUES(106, 0, 1002, 3, null, null, 'Total Submissions Premium', 'Cumulative Premium totals by LOB by month', 'canViewTotalSubmissionsPremium', null, null, null);
/* SQL is database specific */ 
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (106, 1, 'start_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (106, 2, 'end_date', 'date', null);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (106, -1, 'math_function', 'string', 'sum');
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value,is_drill_down)
    VALUES (106, -1, 'GID', 'string', 'LOB',1);
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (106, -1, 'VALUE', 'string', 'premium');
INSERT INTO report_params 
	(report_id, param_num, param_name, param_type, default_value)
    VALUES (106, -1, 'user_groups', 'user_groups', null);
    
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (106, 1, 'date', 1, 0, 0, null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (106, 2, 'LOB', 0, 1, 0, null);
INSERT INTO report_results
	(report_id, result_num, result_type, is_series, is_gid, is_value, default_value)	  
    VALUES (106, 3, 'numeric', 0, 0, 1, '0.00');
    
    
/* Generic by month period report - id 1000 */
INSERT INTO report_sql 
	(sql_id, report_sql)
    VALUES (1000,
   	'select Concat(substr(MONTHNAME(IV.start_date),1,3) ,''-'',  substr(cast(YEAR( IV.start_date ) as char),3,2)) series,   ${GID} as gid,  ${math_function}(${VALUE}) as value 
from (	
	select ? start_date, 
					? end_date
	union all
	select date_add(x.start_date, INTERVAL t500.id MONTH) start_date, x.end_date from (select date_sub(date_add(last_day(date(''${start_date}'')), interval 1 day), interval 1 month) start_date, 
					date(''${end_date}'') end_date) as x,t500 t500
	where date_add(x.start_date, INTERVAL t500.id MONTH) <= x.end_date
) IV left join ${db_table_prefix}work_item w 
	  on (IV.start_date <=  w.effective_date and IV.end_date >= w.effective_date and last_day(IV.start_date) >= w.effective_date  
	  and w.user_group_id in (${user_groups}) and   w.status <> 55  and  w.commit_flag <> 0 )
	group by IV.start_date,${GID}
	order by IV.start_date, ${GID}'
   	);
   	

/* Top 10 broken underwriting rules query - id 1001 */
INSERT INTO report_sql 
	(sql_id, report_sql)
    VALUES (1001,
    'select r.rule_name as series, 
	''rules'' as gid, count(1) as value  
	from ${db_table_prefix}audit_core a,
	${db_table_prefix}work_item w, ${db_table_prefix}audit_rule r
	where a.audit_type = ''RULE'' 
	and w.work_item_id = a.work_item_id
	and DATE(a.create_time) >= ? and DATE(a.create_time) <= ?
	and cast(a.user_group_id as unsigned integer) in (${user_groups})
	and w.status <> 55 
    and w.commit_flag <> 0
	and w.LOB in (${LOB})
	and r.audit_id = a.audit_id
	group by r.rule_name
	order by value desc
	LIMIT 10
	'
	);
	
/* Total Submissions Premium report report id 106, sql id 1002 */

INSERT INTO report_sql 
	(sql_id, report_sql)
    VALUES (1002,
   	'select Concat(substr(MONTHNAME(a.start_date),1,3) ,''-'',  substr(cast(YEAR( a.start_date ) as char),3,2)) series , a.gid, sum(b.value) as value 
	from ( 
	   select IV.start_date start_date,   w.${GID} as gid,  ${math_function}(w.${VALUE}) as value 
	from (	
		select ''${start_date}'' start_date, 
					''${end_date}'' end_date
	union all
	select date_add(x.start_date, INTERVAL t500.id MONTH) start_date, x.end_date from (select date_sub(date_add(last_day(date(''${start_date}'')), interval 1 day), interval 1 month) start_date, 
					date(''${end_date}'') end_date) as x,t500 t500
	where date_add(x.start_date, INTERVAL t500.id MONTH) <= x.end_date
	) IV left join ${db_table_prefix}work_item w 
		  on (IV.start_date <=  w.effective_date and IV.end_date >= w.effective_date and last_day(IV.start_date) >= w.effective_date
		  and w.user_group_id in (${user_groups}) and   w.status <> 55  and  w.commit_flag <> 0 )
		group by IV.start_date, w.${GID}
		
	  ) a left join
	 ( 
	   select IV.start_date start_date,   w.${GID} as gid,  ${math_function}(w.${VALUE}) as value 
	from (	
		select ''${start_date}'' start_date, 
					''${end_date}'' end_date
	union all
	select date_add(x.start_date, INTERVAL t500.id MONTH) start_date, x.end_date from (select date_sub(date_add(last_day(date(''${start_date}'')), interval 1 day), interval 1 month) start_date, 
					date(''${end_date}'') end_date) as x,t500 t500
	where date_add(x.start_date, INTERVAL t500.id MONTH) <= x.end_date
	) IV left join ${db_table_prefix}work_item w 
		  on (IV.start_date <=  w.effective_date and IV.end_date >= w.effective_date and last_day(IV.start_date) >= w.effective_date 
		  and w.user_group_id in (${user_groups}) and   w.status <> 55  and  w.commit_flag <> 0 )
		group by IV.start_date, w.${GID}
		
	  ) b
	  on (a.start_date >= b.start_date and a.gid = b.gid)
	  group by a.start_date, a.gid
	  order by a.start_date, a.gid'
   	);
   	
update report_params set param_num = -1 where report_id = 106 and param_name = 'start_date';
update report_params set param_num = -1 where report_id = 106 and param_name = 'end_date';
   	   	
INSERT INTO t500 (id) VALUES(1); 
INSERT INTO t500 (id) VALUES(2);
INSERT INTO t500 (id) VALUES(3);
INSERT INTO t500 (id) VALUES(4);
INSERT INTO t500 (id) VALUES(5);
INSERT INTO t500 (id) VALUES(6);
INSERT INTO t500 (id) VALUES(7);
INSERT INTO t500 (id) VALUES(8);
INSERT INTO t500 (id) VALUES(9);
INSERT INTO t500 (id) VALUES(10);
INSERT INTO t500 (id) VALUES(11);
INSERT INTO t500 (id) VALUES(12);
INSERT INTO t500 (id) VALUES(13);
INSERT INTO t500 (id) VALUES(14);
INSERT INTO t500 (id) VALUES(15);
INSERT INTO t500 (id) VALUES(16);
INSERT INTO t500 (id) VALUES(17);
INSERT INTO t500 (id) VALUES(18);
INSERT INTO t500 (id) VALUES(19);

INSERT INTO t500 (id) VALUES(20); 
INSERT INTO t500 (id) VALUES(21);
INSERT INTO t500 (id) VALUES(22);
INSERT INTO t500 (id) VALUES(23);
INSERT INTO t500 (id) VALUES(24);
INSERT INTO t500 (id) VALUES(25);
INSERT INTO t500 (id) VALUES(26);
INSERT INTO t500 (id) VALUES(27);
INSERT INTO t500 (id) VALUES(28);
INSERT INTO t500 (id) VALUES(29);
INSERT INTO t500 (id) VALUES(30);
INSERT INTO t500 (id) VALUES(31);
INSERT INTO t500 (id) VALUES(32);
INSERT INTO t500 (id) VALUES(33);
INSERT INTO t500 (id) VALUES(34);
INSERT INTO t500 (id) VALUES(35);
INSERT INTO t500 (id) VALUES(36);
INSERT INTO t500 (id) VALUES(37);
INSERT INTO t500 (id) VALUES(38);

INSERT INTO t500 (id) VALUES(39);
INSERT INTO t500 (id) VALUES(40);

INSERT INTO t500 (id) VALUES(41); 
INSERT INTO t500 (id) VALUES(42);
INSERT INTO t500 (id) VALUES(43);
INSERT INTO t500 (id) VALUES(44);
INSERT INTO t500 (id) VALUES(45);
INSERT INTO t500 (id) VALUES(46);
INSERT INTO t500 (id) VALUES(47);
INSERT INTO t500 (id) VALUES(48);
INSERT INTO t500 (id) VALUES(49);
INSERT INTO t500 (id) VALUES(50);
   	
