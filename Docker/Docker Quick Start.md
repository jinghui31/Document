# Search and Pull Docker Image
```bat
[lvmh@localhost]$ docker search busybox
NAME                DESCRIPTION             STARS       OFFICIAL    AUTOMATED
busybox             Busybox base image.     1417        [OK]                
progrium/busybox                            68                      [OK]

[lvmh@localhost]$ docker pull busybox
Using default tag: latest
latest: Pulling from library/busybox
90e01955edcd: Pull complete 
Digest: sha256:2a03a6059f21e150ae84b0973863609494aad70f0a80eaeb64bddd8d92465812
Status: Downloaded newer image for busybox:latest

[lvmh@localhost]$ docker images
REPOSITORY      TAG         IMAGE ID        CREATED         SIZE
busybox         latest      59788edf1f3e    7 weeks ago     1.15MB
```

# 建立與執行 Container
```bat
[lvmh@localhost]$ docker run --name myct -it busybox /bin/sh
root@container:/ # ps aux
PID     USER    TIME    COMMAND
1       root    0:00    /bin/sh
7       root    0:00    ps aux

root@container:/ # ifconfig eth0
eth0    Link encap:Ethernet  HWaddr 02:42:AC:11:00:02
        inet addr:172.17.0.2  Bcast:172.17.255.255  Mask:255.255.0.0
        UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
        RX packets:25 errors:0 dropped:0 overruns:0 frame:0
        TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
        collisions:0 txqueuelen:0
        RX bytes:3024 (2.9 KiB)  TX bytes:0 (0.0 B)

root@container:/ # exit
```

# 管理 Container
```bat
[lvmh@localhost]$ docker ps -a
CONTAINER ID    IMAGE   COMMAND     CREATED             STATUS                      PORTS   NAMES
fa7561452bae    busybox "/bin/sh"   About a minute ago  Exited (0) 4 seconds ago            myct

[lvmh@localhost]$ docker start myct
myct

[lvmh@localhost]$ docker attach myct
root@container:/ # whoami
root
root@container:/ # exit

[lvmh@localhost]$ docker ps -a
CONTAINER ID    IMAGE   COMMAND     CREATED         STATUS              PORTS   NAMES
fa7561452bae    busybox "/bin/sh"   4 minutes ago   Up About a minute           myct

[lvmh@localhost]$ docker exec -it myct sh
root@container:/ # exit

[lvmh@localhost]$ docker stop myct
myct

[lvmh@localhost]$ docker rm -f myct
myct
```

# 建立 MySQL Container
```bat
[lvmh@localhost]$ docker pull mysql:5.7
5.7: Pulling from library/mysql
a5a6f2f73cd8: Pull complete 
936836019e67: Pull complete 
283fa4c95fb4: Pull complete 
1f212fb371f9: Pull complete 
e2ae0d063e89: Pull complete 
5ed0ae805b65: Pull complete 
0283dc49ef4e: Pull complete 
a7905d9fbbea: Pull complete 
cd2a65837235: Pull complete 
5f906b8da5fe: Pull complete 
e81e51815567: Pull complete 
Digest: sha256:c23e9bfe66eeffc990cf6bce4bb0e9c5c85eb908170f3b3dde3e9a12c5a91689
Status: Downloaded newer image for mysql:5.7

[lvmh@localhost]$ sudo mkdir -p /opt/docker/mysql
[lvmh@localhost]$ cd /opt/docker/mysql
[lvmh@localhost]$ sudo vi my.cnf
# datadir = /var/lib/mysql
# socket = /var/lib/mysql/mysql.sock
# validate_password = OFF

# log-error = /var/log/mysqld.log
# pid-file = /var/run/mysqld/mysqld.pid
[lvmh@localhost]$ docker run --name mysql -v /opt/docker/mysql:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=pome -p 3306:3306 -d mysql:5.7
f49895cfdd991fdd6eff0e0f1e2a9a6778287095fc73a9099c9e26fad49a33e6
        
[lvmh@localhost]$ docker exec -it mysql bash
root@container:/# /usr/bin/mysql_secure_installation
Enter password for user root: lvmh
Change the password for root ? : n
Remove anonymous users? : y
Disallow root login remotely? : y
Remove test database and access to it? : y
Reload privilege tables now? :y
root@container:/# mysql -uroot -p
root@container:/# exit
```

# 建立 Alpine Container
```bat
[lvmh@localhost]$ docker run --name ap -it alpine sh
root@container:/# busybox | head -n 2
Busybox
```

# 建立 Busybox Httpd 網站伺服器
### 下載 Busybox 增益集，增加 httpd 功能
```bat
root@container:/# apk add busybox-extras
```

### 製作網站目錄及首頁
```bat
root@container:/ # mkdir /www
root@container:/ # echo '<h1>Busybox HTTPd</h1>' > www/index.html
```

### 啟動 Busybox Httpd 網站伺服器
```bat
root@container:/ # httpd -p 8888 -h www
```

### 安裝網頁工具
```bat
root@container:/ # apk update
root@container:/ # apk add elinks curl
```

### 取得網頁
```bat
root@container:/ # curl http://localhost:8888
<h1>Busybox HTTPd</h1>
```

### 檢視網頁
```bat
root@container:/ # elinks -dump 1 http://localhost:8888
Busybox HTTPd
root@container:/ # exit
```

# 製作 Alpine image 並上傳到 Docker Hub
```bat
[lvmh@localhost]$ docker ps -a
...
[lvmh@localhost]$ docker commit ap lvmh/ap
[lvmh@localhost]$ docker login
lvmh
[lvmh@localhost]$ docker push lvmh/ap
[lvmh@localhost]$ docker logout
```

# 使用自製 Alpine image, 前景執行 httpd
```bat
[lvmh@localhost]$ docker run --name ap_httpd -d lvmh/a1 httpd -f -p 8888 -h www
-d: detach daemon 背景執行
-f: foreground 前景執行
[lvmh@localhost]$ docker exec ap_httpd hostname -i
172.17.0.2
[lvmh@localhost]$ curl http://172.17.0.2:8888
<h1>Busybox HTTPd</h1>
```

# 開放 Container 外部連線
### 以強制方式移除 ap_httpd
```bat
[lvmh@localhost]$ docker rm -f ap_httpd
```

### 重新建立 ap_httpd Container, 並指定外部連接 Port
```bat
[lvmh@localhost]$ docker run --name ap_httpd -d -p 80:8888 lvmh/ap httpd -f -p 8888 -h www
[lvmh@localhost]$ curl http://localhost:80
<h1>Busybox HTTPd</h1>
```

### 以強制方式再次移除 ap_httpd
```bat
[lvmh@localhost]$ docker rm -f ap_httpd
```

# Nginx
### 建立與測試 Nginx Container
```bat
[lvmh@localhost]$ docker run -d -p 7777:80 --name n1 nginx
...
[lvmh@localhost]$ elinks -dump 1 http://localhost:7777
Welcome to nginx!
```

### 設定 Nginx Container 首頁
```bat
[lvmh@localhost]$ docker exec -it ng bash
root@container:/# apt update
root@container:/# apt upgrade
root@container:/# apt install nano curl elinks tree 
root@container:/# nano /usr/share/nginx/html/index.html 
<html>
    <body>
        <h1>Hi Nginx Docker</h1>
    </body>
</html>
root@container:/# exit

[lvmh@localhost]$ elinks -dump 1 http://localhost:7777
Hi Nginx Docker
[lvmh@localhost]$ docker stop ng
ng
```

### 製作與使用 Nginx image
```bat
[lvmh@localhost]$ docker commit  nginx  lvmh/ng
sha256:fd12fd3cd6c97745937358a0fd9a8739e99b2861e651c056eb3d72d50a32d3bf

[lvmh@localhost]$ docker  images
REPOSITORY  TAG                 IMAGE ID              CREATED               SIZE
<xxx>ng        latest              b2ec4c628fc8        11 seconds ago      109MB

[lvmh@localhost]$ docker run --rm --name testng -p 7777:80 -d lvmh/ng
4f526c7f1a75f31429712bdcea39e5f7be6bffccf0b95e7a7f69953f2ba94b79

[lvmh@localhost]$ curl http://localhost:7777
<html>
    <body>
        <h1>Hi Nginx Docker</h1>
    </body>
</html>

[lvmh@localhost]$ docker stop testng
```