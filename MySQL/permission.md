# MySQL User Permission (使用者權限)

- 2018/01/23

# Create User
```sql
> CREATE USER '<帳號>'@'<HOST>' IDENTIFIED BY '<密碼>';
# <HOST> 只能用 'localhost', 無法使用'127.0.0.1'...

> GRANT ALL ON <Database>.<Table> TO '<帳號>'@'<HOST>';
```

# 更改密碼
```sql
> ALTER USER '<帳號>'@'<HOST>' IDENTIFIED BY '<新密碼>';
```

# 查詢使用者資訊
```sql
> SELECT User, Host FROM mysql.user;
```

# 移除使用者
```sql
DROP USER '<帳號>'@'<HOST>';
```

# 登入資料庫
```sql
mysql -u root -p
password

SHOW DATABASES;
USE notify;
SHOW TABLES;
```

# 範例
```sql
DROP DATABASE notify;

CREATE DATABASE notify CHARACTER SET utf8;
USE notify;

create table alert (
  id        int         auto_increment,
  datetime  datetime    NOT NULL,
  value     varchar(5)  NOT NULL,
  source    varchar(20) NOT NULL,
  PRIMARY KEY (id)
);

DELETE FROM alert WHERE `source` = 'tl01';

INSERT INTO alert (`datetime`, `value`, `source`) VALUES
  (CURRENT_TIMESTAMP + 0, '001', 't01'),
  (CURRENT_TIMESTAMP + 1, '001', 't01'),
  (CURRENT_TIMESTAMP + 2, '001', 't01'),
  (CURRENT_TIMESTAMP + 3, '011', 't01'),
  (CURRENT_TIMESTAMP + 4, '011', 't01'),
  (CURRENT_TIMESTAMP + 5, '011', 't01'),
  (CURRENT_TIMESTAMP + 6, '001', 't01');

SELECT * FROM alert;
```