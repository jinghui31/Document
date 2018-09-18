import redis
import sys

config_redis = {'host': 'localhost',
                'port': 6379,
                'db': 0,}

pool_redis = redis.ConnectionPool(**config_redis)
r = redis.StrictRedis(connection_pool = pool_redis)

def consumer(i):
    while r.llen('sensortype1') > i:
        r.rpop('sensortype1')
    
    while r.llen('sensortype2') > i:
        r.rpop('sensortype2')

    while r.llen('twl') > i:
        r.rpop('twl')


if __name__ == '__main__' :
    data_range = int(sys.argv[1])
    consumer(data_range)



"""
engine = create_engine("mysql+pymysql://root:test@localhost/testdb"
def consumer1(i):
    data = []
    while r.llen('Machine:SensorType') > i:
        pd_Dict = json.loads(r.rpop('Machine:SensorType'))
        data.append(pd_Dict)

    df = pd.DataFrame(data)
    df.to_sql('machine_sensortype', con = engine, if_exists = 'append', index = False)

if __name__ == '__main__' :
    data_range = int(sys.argv[1])
    consumer1(data_range)
    engine.execute("SELECT * FROM machine_sensortype").fetchall()
"""