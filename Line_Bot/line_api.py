import os
from flask import Flask, request, abort
from linebot import LineBotApi, WebhookHandler
from linebot.exceptions import LineBotApiError, InvalidSignatureError
from linebot.models import MessageEvent, TextMessage, TextSendMessage, JoinEvent

app = Flask(__name__)

token = os.environ['CHANNEL_ACCESS_TOKEN']
secret = os.environ['CHANNEL_SECRET']

line_bot_api = LineBotApi(token)
handler = WebhookHandler(secret)


@app.route("/callback", methods = ['POST'])
def callback():
    # get X-Line-Signature header value
    signature = request.headers['X-Line-Signature']

    # get request body as text
    body = request.get_data(as_text = True)
    app.logger.info("Request body: " + body)

    # handle webhook body
    try:
        handler.handle(body, signature)
    except InvalidSignatureError:
        abort(400)

    return 'OK'

@handler.add(MessageEvent, message = TextMessage)
def handle_message(event):
    line_bot_api.reply_message(
        event.reply_token,
        TextSendMessage(text = event.message.text))

@handler.add(JoinEvent)
def handle_join(event):
    line_bot_api.reply_message(
        event.reply_token,
        TextSendMessage(text = event.source.group_id)
    )

def announce(line_id):
    try:
        line_bot_api.push_message(line_id, TextSendMessage(text = '推送消息'))

    except LineBotApiError as e:
        print('Line Push Error')


if __name__ == "__main__":
    app.run()