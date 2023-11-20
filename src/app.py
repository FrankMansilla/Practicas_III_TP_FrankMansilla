from flask import Flask, jsonify
from users import users


app = Flask(__name__)

@app.route('/', methods=['get'])
def ping():
    return jsonify({"response": "hellow word"})

@app.route('/users')
def usersHandler():
    return jsonify({"users": users})


if __name__=='__main__':
    app.run(debug=True)