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


# _________________________ REGISTER _________________________ 
@app.route('/api/auth/register', methods=['POST'])
def register():
    data = request.get_json()
    name = data['name']
    email = data['email']
    password = data['password']

    # Hasher le mot de passe et le stocker en tant que chaîne de caractères
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO users (name, email, password) VALUES (%s, %s, %s)", (name, email, hashed_password))
    mysql.connection.commit()

    return jsonify({'message': 'User registered successfully'}), 201



# _________________________ LOGIN _________________________ 
@app.route('/api/auth/login', methods=['POST'])
def login():
    
    data = request.get_json()
    email = data['email']
    password = data['password']

    cursor = mysql.connection.cursor()
    cursor.execute("SELECT password FROM users WHERE email = %s", (email,))
    result = cursor.fetchone()

    # Vérifier si le mot de passe haché existe et correspond au mot de passe fourni
    if result is None or not bcrypt.checkpw(password.encode('utf-8'), result[0].encode('utf-8')):
        return jsonify({'message': 'Invalid email or password'}), 401

    # Charger le secret JWT à partir des variables d'environnement
    jwt_secret = os.getenv('JWT_SECRET')
    if jwt_secret is None:
        return jsonify({'message': 'JWT secret not found'}), 500


    token = create_access_token(identity=email)
    return jsonify({'token': token}), 200


# _________________________ ADD SNIPPET TO THE COLLECTION (POST) _________________________ 


@app.route('/api/posts', methods=['POST'])
@jwt_required() # l'utilisateur est authentifié
def posts():
    data = request.get_json()
    email = get_jwt_identity() # Récupérer l'adresse e-mail de l'utilisateur authentifié



    cursor = mysql.connection.cursor()
    # Sélectionner l'ID de l'utilisateur à partir de son adresse e-mail
    cursor.execute("SELECT id FROM users WHERE email = %s", (email,))
    user_id = cursor.fetchone()[0]  # Récupérer l'ID de l'utilisateur
    cursor.close()

    cursor = mysql.connection.cursor()
    cursor.execute("SELECT id FROM collection WHERE user_id = %s", (user_id,))
    id_collection = cursor.fetchone()[0]
    cursor.close()


    title = data['title']
    siteLink = data['siteLink']
    author = data['author']
    imageUrl = data['imageUrl']
    language = data['language']
    snippet = data['snippet']
    
    print("Logged in as:", email)

    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO posts (title, siteLink, author, imageUrl, language, snippet, id_collection) VALUES (%s, %s, %s, %s, %s, %s, %s)", (title, siteLink, author, imageUrl, language, snippet, id_collection))
    mysql.connection.commit()

    return jsonify({'message': 'Posted !'}), 201

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)


