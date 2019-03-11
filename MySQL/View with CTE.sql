CREATE VIEW `three_longest` AS
WITH alarm_data_info AS (
	SELECT	ad.machine_id, ad.alarm_id, a.name, ad.start_date_time, ad.end_date_time, ad.cause, ad.solution
	FROM	alarm_data ad LEFT JOIN alarm a
	ON		ad.alarm_id = a.id
	WHERE	ad.end_date_time is Null
)	SELECT	ROW_NUMBER() OVER w AS 'id', adi.machine_id, m.name AS 'machine_name', adi.alarm_id, adi.name AS 'alarm_name', adi.start_date_time, adi.end_date_time, adi.cause, adi.solution
	FROM	alarm_data_info adi LEFT JOIN machine m
	ON		adi.machine_id = m.id
    WINDOW w AS (ORDER BY start_date_time);