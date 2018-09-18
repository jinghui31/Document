import requests
import json

url = "https://notify-bot.line.me/oauth/token"
headers = {
    "Content-Type" : "application/x-www-form-urlencoded"
}
payload = {
    'grant_type': 'authorization_code',
    'code': 'p5JPuhATeD7D3NecQW0wcQ',
    'redirect_uri': 'http://localhost:8000',
    'client_id': 'aRvgPwpp9BHMTCEPq1gy4m',
    'client_secret': 'dNmnsgEmiD7kTr9FYVrKPDIZycc5MFL7JgADw1On7zJ'
}

result = requests.post(url, headers = headers, data = payload)

print(result.json()['access_token'])

with open('oauth.txt', 'w') as f:
    f.write(result.json()['access_token'])