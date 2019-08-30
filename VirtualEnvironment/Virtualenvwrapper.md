## 安裝
- 創建目錄用來存放虛擬環境
```sh
[lvmh@localhost ~]$ mkdir $HOME/.virtualenvs
```

- 在 ~/.bashrc 中添加行
```sh
[lvmh@localhost ~]$ export WORKON_HOME=$HOME/.virtualenvs
[lvmh@localhost ~]$ source /usr/bin/virtualenvwrapper.sh
```

- 運行
```sh
[lvmh@localhost ~]$ source ~/.bashrc
```

## 列出虛擬環境列表
```sh
[lvmh@localhost ~]$ workon
```

## 新建虛擬環境
```sh
[lvmh@localhost ~]$ mkvirtualenv -p python3.6 ENV
```

## 啟動/切換虛擬環境
```sh
[lvmh@localhost ~]$ workon ENV
```

## 刪除虛擬環境
```sh
[lvmh@localhost ~]$ rmvirtualenv ENV
```

## 離開虛擬環境
```sh
[lvmh@localhost ~]$ deactivate
```