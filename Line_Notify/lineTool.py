import requests

"""
發送 Line Notify 訊息
"""

def lineNotify(token, msg):
    url = "https://notify-api.line.me/api/notify"
    headers = {
        "Authorization": "Bearer " + token, 
        "Content-Type" : "application/x-www-form-urlencoded"
    }

    payload = {'message': msg}
    result = requests.post(url, headers = headers, params = payload)
    return result.status_code