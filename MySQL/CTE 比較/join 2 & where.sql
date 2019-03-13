SELECT a_t.machine_id, m.name AS 'machine_name', a_t.alarm_id, a.name AS 'alarm_name', a_t.start_date_time, a_t.end_date_time, a_t.cause, a_t.solution
FROM alarm_test a_t 
	LEFT JOIN alarm a 
    ON a_t.alarm_id = a.id 
    LEFT JOIN machine m 
    ON a_t.machine_id = m.id 
WHERE a_t.end_date_time is NULL 
ORDER BY start_date_time LIMIT 100000;