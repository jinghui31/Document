# MNS 專案建置 Dockerfile
## 前置作業
### 打包並確認好 MNS 專案資料夾內容
```sh
[lvmh@localhost]$ mkdir ~/Desktop/flask-mns
# 複製 project 資料夾到 flask-mns 下面
[Windows]$ scp -r /mns/project lvmh@192.168.220.130:/lvmh/home/Desktop/flask-mns
[lvmh@localhost]$ cd ~/Desktop/flask-mns/project
# 刪除 .git 資料夾, __pycache__資料夾, .gitignore
[lvmh@localhost]$ rm -r .git/
[lvmh@localhost]$ rm -r __pycache__/
[lvmh@localhost]$ rm -r Line/__pycache__/
[lvmh@localhost]$ rm -r Wechat/__pycache__/
[lvmh@localhost]$ rm -r Wechat/src/__pycache__/
[lvmh@localhost]$ rm -r Email/__pycache__/
[lvmh@localhost]$ rm .gitignore
[lvmh@localhost]$ cd ..
[lvmh@localhost]$ tar -zcvf mns-1.0.0.tar.gz project
```

### 建立測試文件
```sh
[lvmh@localhost]$ vi test.py
```
```py
import requests
import json

port = 8080
url = 'http://localhost:' + str(port) + '/api/mns/wechat'
data = {
    "corpID": "wwc95b106e3a09567c",
    "appID": 1000002,
    "appSecret": "AkNinNwfNuhql9SOV0Jt2X96n6TQbVmVJHJxAOSe7gs",
    "toFlag": ["1"],
    "msgs": ["API test1", "API test2", "API test3"],
    "title": "系統訊息",
    "wrap": 2
}

print(requests.post(url, data = json.dumps(data, ensure_ascii = False).encode('utf-8')).json())
```

## 方法一：純手工打造 Dockerfile
### 設定 Ubuntu 版 Dockerfile (Build 15分鐘，檔案大小為 577M)
```sh
[lvmh@localhost]$ vi Dockerfile
FROM ubuntu:18.04
MAINTAINER Jason jason.wang@pomerobotservice.com
ENV LANG=C.UTF-8
RUN apt update && apt upgrade -y && apt install -y python3-pip \
    && rm -rf /var/lib/apt/lists/*
ADD mns-1.0.0.tar.gz /home
WORKDIR /home/project
RUN pip3 install --no-cache-dir -r requirements.txt
EXPOSE 8080
ENTRYPOINT ["python3"]
CMD ["manage.py"]

[lvmh@localhost]$ docker build -t mns-ubt .
[lvmh@localhost]$ docker run --name mns -d -p 8080:8080 mns-ubt
[lvmh@localhost]$ vi test.py
```
```py
port = 8080
```
```sh
[lvmh@localhost]$ python3 test.py
```

## 方法二：參考 Python 開源 Docker Official Images
- [Python - Docker Official Images](https://hub.docker.com/_/python/)

### 2-1: 設定 Alpine 版 Dockerfile (Build 10分鐘，檔案大小為 391M)
```sh
[lvmh@localhost]$ vi Dockerfile
FROM python:3.7.1-alpine3.8
MAINTAINER Jason jason.wang@pomerobotservice.com
RUN apk update && apk upgrade && apk add --no-cache gcc g++ \
    && rm -rf /var/cache/apk/*
ADD mns-1.0.0.tar.gz /home
WORKDIR /home/project
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8080
ENTRYPOINT ["python"]
CMD ["manage.py"]

[lvmh@localhost]$ docker build -t mns-alp .
[lvmh@localhost]$ docker run --name m1 -d -p 5000:8080 mns-alp
[lvmh@localhost]$ vi test.py
```
```py
port = 5000
```
```sh
[lvmh@localhost]$ python3 test.py
```

### 2-2: 設定 Debian-Stretch 版 Dockerfile (Build 3分鐘，檔案大小為 1.04G)
```sh
[lvmh@localhost]$ vi Dockerfile
FROM python:3.7.1-stretch
MAINTAINER Jason jason.wang@pomerobotservice.com
ADD mns-1.0.0.tar.gz /home
WORKDIR /home/project
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8080
ENTRYPOINT ["python"]
CMD ["manage.py"]

[lvmh@localhost]$ docker build -t mns-stt .
[lvmh@localhost]$ docker run --name m2 -d -p 7777:8080 mns-stt
[lvmh@localhost]$ vi test.py
```
```py
port = 7777
```
```sh
[lvmh@localhost]$ python3 test.py
```

### 2-3: 設定 Debian-Stretch Slim 版 Dockerfile (Build 1分鐘，檔案大小為 257M)
```sh
[lvmh@localhost]$ vi Dockerfile
FROM python:3.7.1-slim-stretch
MAINTAINER Jason jason.wang@pomerobotservice.com
ADD mns-1.0.0.tar.gz /home
WORKDIR /home/project
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8080
ENTRYPOINT ["python"]
CMD ["manage.py"]

[lvmh@localhost]$ docker build -t mns-sts .
[lvmh@localhost]$ docker run --name m3 -d -p 6666:8080 mns-sts
[lvmh@localhost]$ vi test.py
```
```py
port = 6666
```
```sh
[lvmh@localhost]$ python3 test.py
```