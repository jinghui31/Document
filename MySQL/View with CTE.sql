CREATE VIEW `machine_alarm` AS
WITH alarm_data_info AS (
	SELECT machine_id, alarm_id, start_date_time, end_date_time
	FROM alarm_data
	WHERE end_date_time is NULL
)	SELECT ROW_NUMBER() OVER w AS 'id', adi.machine_id, m.name AS 'machine_name', adi.alarm_id, a.name AS 'alarm_name', adi.start_date_time, adi.end_date_time
	FROM alarm_data_info adi 
		LEFT JOIN machine m
		ON adi.machine_id = m.id 
		LEFT JOIN alarm a
		ON adi.alarm_id = a.id
	WINDOW w AS (ORDER BY start_date_time);