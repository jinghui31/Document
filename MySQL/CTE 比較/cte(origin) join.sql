WITH alarm_data_info AS ( SELECT a_t.machine_id, a_t.alarm_id, a.name, a_t.start_date_time, a_t.end_date_time, a_t.cause, a_t.solution
 FROM alarm_test a_t LEFT JOIN alarm a
 ON a_t.alarm_id = a.id
 WHERE a_t.end_date_time IS NULL
) SELECT adi.machine_id, m.name AS 'machine_name', adi.alarm_id, adi.name AS 'alarm_name', adi.start_date_time, adi.end_date_time, adi.cause, adi.solution
 FROM alarm_data_info adi LEFT JOIN machine m
 ON adi.machine_id = m.id
 ORDER BY start_date_time limit 100000;