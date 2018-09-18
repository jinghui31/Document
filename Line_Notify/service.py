"""
測試 Line Notify
Created on 2018/6/7
@author: Jason
"""

import os
import lineTool
import time

# token 改成自己的，底下的案例是設到環境變數
# token = os.environ['LINE_NOTIFY_TOKEN']
token = 'y6jajy15N69Nkbktpg4MqxAZLsCFVFKAM6c8xXWjYmD'
msg = 'Notify from Python test\nHave a nice day'

if __name__ == '__main__':
    while True:
        lineTool.lineNotify(token, msg)
        time.sleep(5)