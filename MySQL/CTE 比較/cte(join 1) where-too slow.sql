WITH am AS (
	SELECT a.name AS 'alarm_name', m.name AS 'machine_name'
	FROM alarm a
		LEFT JOIN machine m
		ON a.machine_id = m.id
)	SELECT a_t.machine_id, am.machine_name, a_t.alarm_id, am.alarm_name, a_t.start_date_time, a_t.end_date_time
	FROM alarm_test a_t, am
	WHERE end_date_time is NULL
	ORDER BY start_date_time limit 100000;