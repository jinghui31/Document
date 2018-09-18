## Start project
```sh
D:\> cd project
D:\project> python -m venv venv
D:\project> venv\Scripts\activate
```
---

## Start web & app
```sh
 (venv) D:\project> django-admin startproject mysite .
 (venv) D:\project> python manage.py startapp blog
```

## MySQL to Model.py
```sh
python manage.py inspectdb
```