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
   	'with date_initial as (select start_date, end_date
	from (
		select ? start_date,
		 ? end_date from ${db_table_prefix}t1
		)
	  ),
	  date_ending as (select add_months(add_months(trunc(start_date) - (to_number(to_char(start_date,''DD'')) - 1), 1), level - 1) as start_date, end_date
	    from date_initial where add_months(start_date, 1) <= end_date
	    connect by level <= round(months_between(add_months(trunc(end_date) - (to_number(to_char(end_date,''DD'')) - 1), 1) -1, add_months(trunc(start_date) - (to_number(to_char(start_date,''DD'')) - 1), 1)))
	    ),
	  date_range as (  
	    select start_date, end_date from date_initial
	    union all
	    select start_date, end_date from date_ending
	    )
	select to_char(date_range.start_date, ''Mon'') || ''-'' ||
    		to_char(date_range.start_date, ''yy'') as series, 
	   ${GID} as gid, 
       ${math_function}(${VALUE}) as value 
	from date_range left join ${db_table_prefix}work_item w
	  on (date_range.start_date <= w.effective_date and date_range.end_date >= w.effective_date and w.effective_date <= add_months(trunc(date_range.start_date) - (to_number(to_char(date_range.start_date,''DD'')) - 1), 1) -1
		  and w.user_group_id in (${user_groups}) and w.status <> 55 
		  and w.commit_flag <> 0)
	group by date_range.start_date, ${GID}
	order by date_range.start_date, ${GID}'
	);
	
/* Top 10 broken underwriting rules query - id 1001 */
INSERT INTO report_sql 
	(sql_id, report_sql)
    VALUES (1001,
    'select * from (select r.rule_name as series, 
	''rules'' as gid, count(1) as value  
	from ${db_table_prefix}audit_core a,
	${db_table_prefix}work_item w, ${db_table_prefix}audit_rule r
	where a.audit_type = ''RULE'' 
	and w.work_item_id = a.work_item_id
	and trunc(a.create_time) >= ? and trunc(a.create_time) <= ?
	and to_number(a.user_group_id) in (${user_groups})	and w.status <> 55 
    and w.commit_flag <> 0
	and w.LOB in (${LOB})
	and r.audit_id = a.audit_id
	group by r.rule_name
	order by value desc) where rownum < 11'
	);
	
/* Total Submissions Premium report report id 106, sql id 1002 */
INSERT INTO report_sql 
	(sql_id, report_sql)
    VALUES (1002,
   	'with date_initial as (select start_date, end_date 
	from ( 
		select ? start_date, 
		? end_date from ${db_table_prefix}t1 
		)
	  ),
	  date_ending as (select add_months(add_months(trunc(start_date) - (to_number(to_char(start_date,''DD'')) - 1), 1), level - 1) as start_date, end_date
	    from date_initial where add_months(start_date, 1) <= end_date
	    connect by level <= round(months_between(add_months(trunc(end_date) - (to_number(to_char(end_date,''DD'')) - 1), 1) -1, add_months(trunc(start_date) - (to_number(to_char(start_date,''DD'')) - 1), 1)))
	   ),
	  date_range as (  
	    select start_date, end_date from date_initial
	    union all
	    select start_date, end_date from date_ending
	   )
  	select to_char(a.start_date, ''Mon'') || ''-'' ||
    	to_char(a.start_date, ''yy'') as series,  
	  a.gid,  sum(b.value) as value from  
    (
     select 
          date_range.start_date, 
          w.${GID} as gid, 
          ${math_function}(w.${VALUE}) as value 
	    from 
        date_range left join ${db_table_prefix}work_item w 
        on (date_range.start_date <= w.effective_date and date_range.end_date >= w.effective_date and w.effective_date <= add_months(trunc(date_range.start_date) - (to_number(to_char(date_range.start_date,''DD'')) - 1), 1) -1
		    and w.user_group_id in (${user_groups}) and w.status <> 55  
		    and w.commit_flag <> 0)
     group by 
        date_range.start_date, 
        w.${GID}
  )a left join
  ( 
    select date_range.start_date, 
            w.${GID} as gid, 
            ${math_function}(w.${VALUE}) as value 
    from 
        date_range left join ${db_table_prefix}work_item w 
        on (date_range.start_date <= w.effective_date and date_range.end_date >= w.effective_date and w.effective_date <= add_months(trunc(date_range.start_date) - (to_number(to_char(date_range.start_date,''DD'')) - 1), 1) -1
        and w.user_group_id in (100,200) and w.status <> 55  
        and w.commit_flag <> 0) 
    group by 
        date_range.start_date,
        w.${GID}   
   )b
   on(a.start_date >= b.start_date and a.gid = b.gid)
    group by a.start_date, a.gid 
    order by a.start_date, a.gid'
   	);

 
   	
 
   	