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

    # Récupérer l'ID de l'utilisateur nouvellement créé
    user_id = cursor.lastrowid

    # Créer automatiquement une collection pour cet utilisateur
    cursor.execute("INSERT INTO collections (id_users) VALUES (%s)", (user_id,))
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


# Récupérer l'ID de la collection de l'utilisateur connecté
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT id FROM collections WHERE id_users = (SELECT id FROM users WHERE email = %s)", (email,))
    id_collection = cursor.fetchone()[0]

    # cursor = mysql.connection.cursor()
    # # Sélectionner l'ID de l'utilisateur à partir de son adresse e-mail
    # cursor.execute("SELECT id FROM users WHERE email = %s", (email,))
    # id_users = cursor.fetchone()[0]  # Récupérer l'ID de l'utilisateur
    # cursor.close()

    # cursor = mysql.connection.cursor()
    # cursor.execute("SELECT id FROM collections WHERE id_users = %s", (id_users,))
    # id_collection = cursor.fetchone()[0]  # Récupérer l'ID de la collection 
    # cursor.close()

    title = data['title']
    siteLink = data['siteLink']
    author = data['author']
    imageUrl = data['imageUrl']
    language = data['language']
    snippet = data['snippet']
    
    print("Logged in as:", email)

    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO snippetPosts (title, siteLink, author, imageUrl, language, snippet, id_collection) VALUES (%s, %s, %s, %s, %s, %s, %s)", (title, siteLink, author, imageUrl, language, snippet, id_collection))
    mysql.connection.commit()

    return jsonify({'message': 'Posted !'}), 201

# _________________________ UPDATE MY SNIPPET _________________________ 

@app.route('/api/posts/<int:id>', methods=['PUT'])
@jwt_required() # l'utilisateur est authentifié
def update_posts(id):
    data = request.get_json()
    email = get_jwt_identity() 

    # Récupérer l'ID de l'utilisateur à partir de son adresse e-mail
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT id FROM users WHERE email = %s", (email,))
    user_id = cursor.fetchone()

    # Vérifier si un ID d'utilisateur a été trouvé
    if not user_id:
        abort(404, description="Utilisateur introuvable")

    # Vérifier si l'utilisateur connecté est bien celui qui a créé le post dans la collection associée
    cursor.execute("SELECT sp.id FROM snippetPosts sp JOIN collections c ON sp.id_collection = c.id WHERE sp.id = %s AND c.id_users = %s", (id, user_id[0]))
    post = cursor.fetchone()

    # Vérifier si un post a été trouvé pour cet ID et cet utilisateur
    if not post:
        abort(403, description="Vous n'êtes pas autorisé à mettre à jour ce post")

    # Mettre à jour le post
    cursor.execute("UPDATE snippetPosts SET title = %s, siteLink = %s, author = %s, imageUrl = %s, language = %s, snippet = %s WHERE id = %s", 
                   (data['title'], data['siteLink'], data['author'], data['imageUrl'], data['language'], data['snippet'], id))
    mysql.connection.commit()

    return jsonify({'message': 'Mise à jour du snippet réussie'}), 200


# _________________________ DELETE MY SNIPPET _________________________ 

@app.route('/api/posts/<int:id>', methods=['DELETE'])
@jwt_required() # l'utilisateur est authentifié
def delete_posts(id):
    data = request.get_json()
    email = get_jwt_identity() 

    # Récupérer l'ID de l'utilisateur à partir de son adresse e-mail
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT id FROM users WHERE email = %s", (email,))
    user_id = cursor.fetchone()

    # Vérifier si un ID d'utilisateur a été trouvé
    if not user_id:
        abort(404, description="Utilisateur introuvable")

    # Vérifier si l'utilisateur connecté est bien celui qui a créé le post dans la collection associée
    cursor.execute("SELECT sp.id FROM snippetPosts sp JOIN collections c ON sp.id_collection = c.id WHERE sp.id = %s AND c.id_users = %s", (id, user_id[0]))
    post = cursor.fetchone()

    # Vérifier si un post a été trouvé pour cet ID et cet utilisateur
    if not post:
        abort(403, description="Vous n'êtes pas autorisé à mettre à jour ce post")

    # Mettre à jour le post
    cursor.execute("DELETE FROM snippetPosts WHERE id = %s", (id,))
    mysql.connection.commit()

    return jsonify({'message': 'Snippet deleted'}), 200

# _________________________ VIEW SNIPPETS OF 1 COLLECTION _________________________ 

@app.route('/api/posts/<int:id_collection>', methods=['GET'])

def get_posts(id_collection):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM snippetPosts WHERE id_collection = %s", (id_collection,))
    collection_posts = cursor.fetchall()
    cursor.close()

    if collection_posts:
        # Format the posts data into a JSON response
        posts_data = []
        for post in collection_posts:
            post_data = {
                'id': post[0],
                'title': post[1],
                'siteLink': post[2],
                'author': post[3],
                'imageUrl': post[4],
                'language': post[5],
                'snippet': post[6],
                'id_collection': post[7]  # Assuming user_id is the 7th column in your table
            }
            posts_data.append(post_data)

        return jsonify({'id_collection': id_collection, 'posts': posts_data}), 200
    else:
        return jsonify({'message': 'No posts found for user with ID {}'.format(id_collection)}), 404







if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)


