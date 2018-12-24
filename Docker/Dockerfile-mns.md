# 打包並確認好專案資料夾內容
```sh
[lvmh@localhost]$ mkdir ~/Desktop/flask
# 複製 project 資料夾到 flask 下面
[Windows]$ scp -r /mns/project lvmh@192.168.220.130:/lvmh/home/Desktop/flask
[lvmh@localhost]$ cd ~/Desktop/flask/project
# 刪除 .git 資料夾, __pycache__資料夾, .gitignore
[lvmh@localhost]$ rm -r .git/
[lvmh@localhost]$ rm -r __pycache__/
[lvmh@localhost]$ rm .gitignore
[lvmh@localhost]$ cd ..
[lvmh@localhost]$ tar -zcvf mns-1.0.0.tar.gz project
```

# 設定 Python 版 Dockerfile (Build快，但是檔案 1G)
```sh
[lvmh@localhost]$ vi Dockerfile
FROM python:3
MAINTAINER Jason jason.wang@pomerobotservice.com
ADD mns-1.0.0.tar.gz /home
WORKDIR /home/project
RUN pip install --no-cache-dir -r requirements.txt
ENTRYPOINT ["python"]
CMD ["manage.py"]

[lvmh@localhost]$ docker build -t mns .
[lvmh@localhost]$ docker run --name m1 -d -p 5000:8080 mns
[lvmh@localhost]$ vi test.py
```
```py
import requests
import json

port = 5000
url = 'http://localhost:' + str(port) + '/api/mns/email'
data = {
    'server': 'officemail.cloudmax.com.tw',
    'sendUser': 'swrd@pomerobotservice.com',
    'sendPswd': 'pomeswrd2018$%^',
    'sendTag': 'POME Robot Service',
    'email': ['jason.wang@pomerobotservice.com', 'howard.mei@pomerobotservice.com', 'yk.chang@pomerobotservice.com'],
    'msgs': ['API test1', 'API test2', 'API test3'],
    'title': '系統訊息',
    'stringTag': ['訊息']
}

print(requests.post(url, data = json.dumps(data, ensure_ascii = False).encode('utf-8')).json())
```
```sh
[lvmh@localhost]$ python3 test.py
```

# 設定 Ubuntu 版 Dockerfile (Build 要 15 分鐘，但是檔案大小為 600M)
```sh
[lvmh@localhost]$ vi Dockerfile
FROM ubuntu:18.04
MAINTAINER Jason jason.wang@pomerobotservice.com
RUN apt update && apt upgrade -y && apt install -y python3-pip
ADD mns-1.0.0.tar.gz /home
WORKDIR /home/project
RUN pip3 install --no-cache-dir -r requirements.txt
ENTRYPOINT ["python3"]
CMD ["manage.py"]

[lvmh@localhost]$ docker build -t mns-ubt .
[lvmh@localhost]$ docker run --name m2 -d -p 6666:8080 mns-ubt
[lvmh@localhost]$ vi test.py
```
```py
port = 6666
```
```sh
[lvmh@localhost]$ python3 test.py
```