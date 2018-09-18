SELECT * FROM testdb.temperature_data
WHERE datetime LIKE '2018-06-12 10:18%';

SELECT *, TIMESTAMPDIFF(minute, datetime, NOW())
FROM testdb.temperature_data;

# 最近1小時
SELECT id, sensor_id, datetime, MAX(value)
FROM testdb.temperature_data
WHERE datetime LIKE '2018-06-12 15%';

# 最近5分鐘
SELECT id, sensor_id, datetime, MAX(value)
FROM testdb.temperature_data
WHERE datetime >= TIMESTAMPADD(minute, -5, NOW());

select *, NOW()
FROM testdb.temperature_data

def normal_alert(time_now):
    sql = (time_now - timedelta(hours = 0)).strftime('%Y-%m-%d %H') + '%'
    cur.execute("""SELECT id, sensor_id, datetime, MAX(value) FROM {} WHERE datetime LIKE '{}'""".format(tmp_tb, sql))
    
def unusual_alert(time_now, time_type, time_num):
    sql = time_now.strftime('%Y-%m-%d %H:%M:%S')
    cur.execute("""SELECT id, sensor_id, datetime, MAX(value) FROM {} WHERE datetime >= TIMESTAMPADD({}, -{}, '{}')""".format(tmp_tb, time_type, time_num, sql))
    
# 最近1小時
sql = time_now.strftime('%Y-%m-%d %H:%M:%S')
SELECT machineID, time, status
FROM towerlight_data as twl
WHERE EXISTS (
	SELECT *
    FROM towerlight_data
    WHERE datetime <= '2018-06-27 15:30:00'
	GROUP BY machineID
	HAVING twl.time = MAX(time));
    
# 最近1分鐘
sql = time_now.strftime('%Y-%m-%d %H:%M:%S')
SELECT machineID, time, status
FROM towerlight_data as temp
WHERE EXISTS (
	SELECT *
    FROM towerlight_data
    WHERE datetime <= '2018-06-27 15:30:00'
	GROUP BY machineID
	HAVING temp.time = MAX(time));