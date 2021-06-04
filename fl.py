from recomentation import movie
import recomentation
from flask_cors import CORS
from flask import request
from flask import Flask, jsonify
from recomentation import fmov

import json


#from six import b
#import recomentation

app = Flask(__name__)
CORS(app)

# response = ''
# data = ''

data = ''


@app.route('/user', methods=['POST'])
def index():
    global data
    request_data = request.data
    request_data = json.loads(request_data.decode('utf-8'))
    userId = request_data['userid']
    data = userId
    print('######################################################')
    print(data)
    # l = movie(int(data))
    # print(l)

    # return jsonify({'userid': getuserid(int(data))})
    return ''


@app.route("/user1", methods=['GET'])
def getuserid():
    global data
    a = int(data)
    l, m = movie(a)

    return ({'userid': l, 'userid2': m})


fav = ''
a = []


@app.route('/favo', methods=['POST', 'GET'])
def mov_fav():

    if(request.method == 'POST'):
        global fav, a
        requestData = request.data
        requestData = json.loads(requestData.decode('utf-8'))
        usermov = requestData['favmov']
        fav = usermov

        a = fmov(fav)
        print('************************')
        print(a)
        return jsonify({'data': a})
    else:
        print('################')
        print(fav)
        return ({'favourite': a})


if __name__ == '__main__':
    app.run(debug=True)
