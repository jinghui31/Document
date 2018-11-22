# Uninstall old versions
## Older versions of Docker were called docker or docker-engine. If these are installed, uninstall them:
```sh
$ systemctl stop docker
$ sudo apt-get autoremove docker docker-engine docker.io
```

# Install using the repository
## SET UP THE REPOSITORY
```sh
$ sudo apt-get update
$ sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

## INSTALL DOCKER CE
### 確認 Kubernetes 目前指定的 Docker 版本
- [Kubernetes](https://github.com/kubernetes/kubernetes/blob/master/cmd/kubeadm/app/util/system/docker_validator.go#L41)

### To install a specific version of Docker CE, list the available versions in the repo, then select and install(安裝指定版本)
```sh
$ apt-cache madison docker-ce
$ sudo apt-get install docker-ce=18.06.1~ce~3-0~ubuntu
```

## Configure
### 將 lvmh 帳號加入 Docker 群組，就不需使用 sudo 執行 Docker
```sh
$ sudo usermod -aG docker lvmh
$ sudo reboot
```

### 檢視 Docker 運作架構資訊
```sh
$ docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 0
Server Version: 18.06.1-ce
Storage Driver: overlay2
 Backing Filesystem: extfs
 Supports d_type: true
 Native Overlay Diff: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host macvlan null overlay
 Log: awslogs fluentd gcplogs gelf journald json-file logentries splunk syslog
Swarm: inactive
Runtimes: runc
```

### Verify that Docker CE is installed correctly by running the hello-world image.
```sh
$ sudo docker run hello-world
```

# Uninstall Docker CE
```sh
$ sudo apt-get purge docker-ce
$ sudo rm -rf /var/lib/docker
```