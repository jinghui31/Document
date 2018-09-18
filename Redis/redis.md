# Python-Redis
### 系統變數
- 設定redis-cli變數
- 將redis-cli加到Path裡

### Connection
```py
redis_config = {
    'host': 'localhost',
    'port': 6379,
    'db': 0,
    'decode_responses': True
}

redis_pool = redis.ConnectionPool(**redis_config)
r = redis.StrictRedis(connection_pool = redis_pool)
```

### Create key
```py
r.lpush(key, value)
```

### Delete key
```py
r.delete(key1, key2, key3...)
```

### Serach keys
```sh
keys *
```

# String, Set
### 比較少用，暫時不講

# List
### LPUSH
```sh
# LPUSH key value
LPUSH Machine:SensorType '{s_id:2,dt:20180403,value:3}'
LPUSH Machine:SensorType '{s_id:3,dt:20180503,value:5}'
LPUSH Machine:SensorType '{s_id:2,dt:20180520,value:8}'
```

### RPOP
```sh
# RPOP key
RPOP Machine:SensorType
```

### RPOPLPUSH
```sh
# RPOPLPUSH key(-1) other_key
RPOPLPUSH Machine:SensorType Expired
```

### LRANGE
```sh
LRANGE Machine:SensorType 0 -1
```

### LLEN
```sh
LLEN Machine:SensorType
```

# Hset
### 新增/修改
```sh
HSET, HMSET, HSETNX
```
```py
# for loop use hmset
sensors = {sl['sensor_id']: sl['type'] for sl in lists}
r.hmset(key, sensors)
```

### 查詢
```sh
HGET, HGETALL, HMGET
```
```py
for list_value in lists:
    varible = r.hget(key, list_value[0])
```

### 刪除
```sh
HDEL, HEXISTS
```

### 其他
```sh
HKEYS, HLEN, HSTRLEN, SCAN
```

# Zset (Sorted Set)
### 新增
```sh
ZADD
```

### 查詢
```sh
# General
ZSCORE
ZRANGE, ZREVRANGE

# Advance
ZRANGEBYSCORE, ZREVRANGEBYSCORE
ZRANK, ZREVRANK
```

### 移除
```sh
ZREMRANGEBYSCORE, ZREMRANGEBYRANK
```

### Time Series with Expired
```py
import time
# r.zadd(key, score(total_seconds()), value)
r.zadd('temperature', time.time() + 60, '540')
r.zadd('temperature', time.time() + 120, '200')

# r.zremrangebyscore(key, '-inf', now().total_seconds())
r.zremrangebyscore('temperature', '-inf', time.time())
```

# Secondary index: List + Hash (could be Set)
### PUSH
```sh
LPUSH SensorType 1 2 3
HMSET timeZone:1 s_id 1 dt 20150101 value 8
HMSET timeZone:2 s_id 5 dt 20160516 value 3
HMSET timeZone:3 s_id 1 dt 20180305 value 59
```

### GET
```py
HGET timeZone:1 s_id
HMGET timeZone:1 s_id dt value
HGETALL person:1
```

### Group by
```py
SORT SensorType by timeZone:*->dt GET timeZone:*->s_id
SORT SensorType by timeZone:*->dt GET timeZone:*->s_id GET timeZone:*->dt GET timeZone:*->value
```