from flask import Flask, jsonify
import requests
app = Flask(__name__)
PLACE_ID = 1224212277
#PLACE_ID = 15595452055 #TEST
@app.route("/server_ids")
def server_ids():
    url = f"https://games.roblox.com/v1/games/{PLACE_ID}/servers/Public"
    params = {
        "limit": 100,
        "sortOrder": "Des",
        "excludeFullGames": False
    }

    r = requests.get(url, params=params)
    data = r.json()

    ids = [s["id"] for s in data.get("data", [])]

    return jsonify(ids)
app.run(port=5000)
#this script was writen by ChatGPT!!!