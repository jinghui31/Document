WITH alarm_data_info AS ( SELECT *
 FROM alarm_test
 WHERE end_date_time IS NULL
) SELECT adi.machine_id, m.name AS 'machine_name', adi.alarm_id, a.name AS 'alarm_name', adi.start_date_time, adi.end_date_time, adi.cause, adi.solution
 FROM alarm_data_info adi 
	LEFT JOIN machine m
	ON adi.machine_id = m.id 
	LEFT JOIN alarm a
	ON adi.alarm_id = a.id
 ORDER BY start_date_time limit 100000;