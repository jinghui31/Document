### Create venv
```sh
D:\> cd project
D:\project> python -m venv virtual_name
```

### Into venv
```sh
D:\project> virtual_name\Scripts\activate
(venv) D:\project>
```

### Install package
```sh
(venv) D:\project> cd program
(venv) D:\project\program> pip install -r requirements.txt
(venv) D:\project\program> python app.py
```

### Leave venv
```sh
(venv) D:\project\program> cd ..
(venv) D:\project> virtual_name\Scripts\deactivate
D:\project>
```