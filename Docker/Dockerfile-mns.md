# 設定 Dockerfile
```sh
[lvmh@localhost]$ mkdir ~/Desktop/flask
[lvmh@localhost]$ cd ~/Desktop/flsk
[lvmh@localhost]$ vi Dockerfile
FROM python:3
MAINTAINER Jason jason.wang@pomerobotservice.com
COPY ./project /
WORKDIR /
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8080
ENTRYPOINT ["python"]
CMD ["manage.py"]

[lvmh@localhost]$ docker build -t mns .
[lvmh@localhost]$ docker run --name m1 -d -p 5000:8080 mns
```