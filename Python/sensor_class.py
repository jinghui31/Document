""" 說明
    作者: 
        Jason

    建立日期: 
        2018/06/12

    相依性:
        pip install redis
        pip install mysql-connector-python

    如何使用: 
        command line: python sensor_class.py

    程式幹嘛用的:
        1. 每當程式重新執行，刪除Redis和MySQL原本的 [list] 資料
        2. 之後把 [lists] 裡的資料 {sensor_id, machine_id, type} 重新載入
            Redis: Hash-sensor, sensor_id: type (key: value)
            MySQL: Table-sensor, tuple(sensor_id, machine_id, type)
        3. 隨機取 <Sensor> 塞資料，依 <type> 判斷塞資料的欄位和內容

    資料格式如下:
    sensor:                              記載所有Sensor的清單列表
        {
            'sensor_id': <varchar>,     Sensor ID
            'machine_id': <varchar>,    Sensor 所屬的機台
            'type': <varchar>           Sensor Type，目前有Counter, Temperature, Towerlight
        }
            sensor_id	machine_id	type
            t_001		    t		counter
            t_002		    t		towerlight
            s_001		    s		temperature
    
    counter_data:
        {
            'sensor_id': <varchar>,     Sensor ID
            'wo_id': <varchar>,         Work_Order_Id   工單編號
            'pd_id': <varchar>,         Product_Id      產品編號
            'time': <datetime>,         資料來源時間 <ISODate>
            'v': <int>                  流量加總
        }
            id	sensor_id	work_order_id	product_id	        datetime            value
            1	t_001		    w001		    p001		2018-05-28 14:45:30	    0
            2	t_001		    w001		    p001		2018-05-28 14:45:32	    5
            3	t_001		    w001		    p001		2018-05-28 14:45:33	    9
 
    temperature_data:
        {
            'id': <varchar>,            Sensor ID
            'time': <datetime>,         資料來源時間 <ISODate>
            'v': <decimal>              資料數值
        }
            id	sensor_id	    datetime	    value
            1	s_001		2018-5-28 14:45:30	40.00
            2	s_001		2018-5-28 14:45:32	39.76
            3	s_001		2018-5-28 14:45:33	41.43
    
    towerlight_data:
        {
            'id': <varchar>,            Sensor ID
            'time': <datetime>,         資料來源時間 <ISODate>
            'v': <char>                 資料數值
        }
            id	sensor_id	    datetime	    value
            1	t_002		2018-5-28 14:45:30	'000'
            2	t_002		2018-5-28 14:45:32	'010'
            3	t_002		2018-5-28 14:45:33	'200'

    參考:
        

    問題:
"""

import redis
import mysql.connector
import json
from datetime import datetime
import time
import random
import abc

mysql_db = 'testdb'         # MySQL DB_Name
sensor_tb = 'sensor'        # Sensor 清單列表
ctr_tb = 'counter_data'     # Counter 資料表
tmp_tb = 'temperature_data' # temperature 資料表
twl_tb = 'towerlight_data'  # towerlight 資料表

redis_config = {
    'host': 'localhost',
    'port': 6379,
    'db': 0,
    'decode_responses': True
}

mysql_config = {
    'user': 'root',
    'password': 'test',
    'host': 'localhost',
    'database': mysql_db,
    'raise_on_warnings': True
}

ctr = 0     # Counter 初始值
tpt = 40    # 溫度初始值
p = 0.2     # 溫度發生變化的機率
x = 2       # 溫度變化的異動範圍區間
twl = '000' # 燈號初始值
lx = 0.1    # 燈號發生變化的機率

redis_pool = redis.ConnectionPool(**redis_config)
r = redis.StrictRedis(connection_pool = redis_pool)

conn = mysql.connector.connect(**mysql_config)
conn.autocommit = True
cur = conn.cursor()

class Sensor(abc.ABC):
    def __init__(self, sensor_id, datetime, value):
        self._dict = {'s_id': sensor_id,
                      'time': datetime,
                      'v': value}

    @abc.abstractmethod
    def insert_data(self):
        pass

class Counter(Sensor):
    def __init__(self, sensor_id, work_order_id, product_id, datetime, value):
        self._dict = {'s_id': sensor_id,
                      'wo_id': work_order_id,
                      'pd_id': product_id,
                      'time': datetime,
                      'v': value}

    def insert_data(self):
        r.lpush(ctr_tb, json.dumps(self._dict))

        sql = """INSERT INTO {} (sensor_id, work_order_id, product_id, datetime, value) VALUES (%s, %s, %s, %s, %s)""".format(ctr_tb)
        cur.execute(sql, (tuple(self._dict.values())))

class Temperature(Sensor):
    def insert_data(self):
        r.lpush(tmp_tb, json.dumps(self._dict))

        sql = """INSERT INTO {} (sensor_id, datetime, value) VALUES (%s, %s, %s)""".format(tmp_tb)
        cur.execute(sql, (tuple(self._dict.values())))

class Towerlight(Sensor):
    def insert_data(self):
        r.lpush(twl_tb, json.dumps(self._dict))

        sql = """INSERT INTO {} (sensor_id, datetime, value) VALUES (%s, %s, %s)""".format(twl_tb)
        cur.execute(sql, (tuple(self._dict.values())))

# 每個Sensor的列表清單
# sensor_id, 在哪台機器上, type是做什麼處理的
def sensor_list():
    lists = [{'sensor_id': 't_001', 'machine_id': 't', 'type': 'counter'},
             {'sensor_id': 't_002', 'machine_id': 't', 'type': 'towerlight'},
             {'sensor_id': 's_001', 'machine_id': 's', 'type': 'temperature'},
             {'sensor_id': 's_002', 'machine_id': 's', 'type': 'counter'}]
    
    sensors = {sl['sensor_id']: sl['type'] for sl in lists}
    r.delete(sensor_tb)
    r.hmset(sensor_tb, sensors)

    cur.execute("""USE {}""".format(mysql_db))
    cur.execute("""DROP TABLE IF EXISTS {}""".format(sensor_tb))
    cur.execute("""CREATE TABLE {} (sensor_id VARCHAR(32), machine_id VARCHAR(32), type VARCHAR(16) NOT NULL)""".format(sensor_tb))
    sql = """INSERT INTO {} VALUES (%s, %s, %s)""".format(sensor_tb)
    for l in lists:
        cur.execute(sql, (tuple(l.values())))

# 初始化所有報表
def initialize_table():
    r.delete(ctr_tb, tmp_tb, twl_tb)

    cur.execute("""DROP TABLE IF EXISTS {}""".format(ctr_tb))
    cur.execute("""CREATE TABLE {} (id INT AUTO_INCREMENT PRIMARY KEY, sensor_id VARCHAR(32) NOT NULL,
                work_order_id VARCHAR(32) NOT NULL, product_id VARCHAR(32) NOT NULL, datetime DATETIME NOT NULL,
                value INT NOT NULL)""".format(ctr_tb))

    cur.execute("""DROP TABLE IF EXISTS {}""".format(tmp_tb))
    cur.execute("""CREATE TABLE {} (id INT AUTO_INCREMENT PRIMARY KEY, sensor_id VARCHAR(32) NOT NULL,
                datetime DATETIME NOT NULL, value decimal(5,2) NOT NULL)""".format(tmp_tb))

    cur.execute("""DROP TABLE IF EXISTS {}""".format(twl_tb))
    cur.execute("""CREATE TABLE {} (id INT AUTO_INCREMENT PRIMARY KEY, sensor_id VARCHAR(32) NOT NULL,
                datetime DATETIME NOT NULL, value char(3) NOT NULL)""".format(twl_tb))


# 亂數取 0 ~ 5 的數值進行累加
def ctr_random():
    global ctr
    ctr += random.randint(0, 5)
    return ctr
    """
        回傳累加後的ctr數值, ex: 3
    """

# 當亂數機率高於 80% (1-p) 時，則改變溫度範圍在 +-2 度c內
def tmp_random():
    global tpt
    rnd = 0 if random.random() < (1 - p) else random.random() * x * 2 - x
    tpt = round(tpt + rnd, 2)
    return tpt
    """
        回傳溫度數值, ex: 22
    """

# 當亂數機率高於 90% (1-lx) 時，則改變燈號
def twl_random():
    global twl
    twl = twl if random.random() < (1 - lx) else ''.join(map(str, random.choices([0, 1, 2], k = 3)))
    return twl
    """
        回傳燈號, ex: '001'
    """

def produce():
    while True:
        time_now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        data_lists = [('t_001', 'w001', 'p001', time_now, ctr_random()),
                      ('s_001', time_now, tmp_random()),
                      ('t_002', time_now, twl_random())]

        for input_data in data_lists:
            sensor_type = r.hget(sensor_tb, input_data[0])
            print(sensor_type)

            if sensor_type == 'counter':
                Counter(*input_data).insert_data()
            elif sensor_type == 'temperature':
                Temperature(*input_data).insert_data()
            elif sensor_type == 'towerlight':
                Towerlight(*input_data).insert_data()
            else:
                print('You must update sensor lists, and push RESET button')

        time.sleep(1)

if __name__ == '__main__':
    sensor_list()
    initialize_table()
    produce()