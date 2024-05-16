from flask import Flask, request, jsonify, abort
from flask_mysqldb import MySQL
import bcrypt
import os
from dotenv import load_dotenv
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity
from cloudinary.uploader import upload

load_dotenv()

app = Flask(__name__)
app.config['MYSQL_HOST'] = os.getenv('MYSQL_HOST')
app.config['MYSQL_USER'] = os.getenv('MYSQL_USER')
app.config['MYSQL_PASSWORD'] = os.getenv('MYSQL_PASSWORD')
app.config['MYSQL_DB'] = os.getenv('MYSQL_DB')
app.config['JWT_TOKEN_LOCATION'] = ['headers', 'cookies']
app.config['JWT_IDENTITY_CLAIM'] = 'sub'
app.config['JWT_HEADER_NAME'] = 'Authorization'
app.config['JWT_HEADER_TYPE'] = 'Bearer'
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET')



jwt = JWTManager(app)

mysql = MySQL()
mysql.init_app(app)



# _________________________ TEST _________________________ 
@app.route("/")
def hello_world():

    return "<p>Hello, World!!!!!!! ehehehe</p>"





# if __name__ == '__main__':
#     app.run(debug=True)

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)


