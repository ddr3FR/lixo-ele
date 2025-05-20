from flask import Flask, jsonify, request
import firebase_admin
from firebase_admin import credentials, db
from dotenv import load_dotenv
import os

""" Não mecham AQUI"""
load_dotenv()
app = Flask(__name__)
firebase_key_path = os.getenv("GOOGLE_APPLICATION_CREDENTIALS")
database_url = os.getenv("FIREBASE_DB_URL")


if not firebase_admin._apps:
    cred = credentials.Certificate(firebase_key_path)
    firebase_admin.initialize_app(cred, {
        'databaseURL': database_url
    })
"""Podem mexer a partir daqui"""

@app.route('/')
def home():
    return jsonify({"mensagem": "API Flask conectada ao Firebase com sucesso!"})


@app.route('/usuarios', methods=['GET'])
def listar_usuarios():
    ref = db.reference('usuarios')
    dados = ref.get()
    return jsonify(dados or {})


@app.route('/usuarios', methods=['POST'])
def adicionar_usuario():
    dados = request.json
    ref = db.reference('usuarios')
    novo_ref = ref.push(dados)  
    return jsonify({"id": novo_ref.key, "mensagem": "Usuário adicionado com sucesso!"}), 201

@app.route('/reciclagem', methods=['POST'])
def adicionar_reciclagem():
    dados = request.json
    ref = db.reference('reciclagem')
    novo_ref = ref.push(dados)
    return jsonify({"id": novo_ref.key, "mensagem": "Registro de reciclagem adicionado com sucesso!"}), 201

@app.route('/residuos', methods=['POST'])
def adicionar_residuo():
    dados = request.json
    ref = db.reference('residuos')
    novo_ref = ref.push(dados)
    return jsonify({"id": novo_ref.key, "mensagem": "Resíduo adicionado com sucesso!"}), 201

@app.route('/aluno', methods=['GET'])
def listar_alunos():
    ref = db.reference('aluno')
    dados = ref.get()
    return jsonify(dados or {})

@app.route('/curso', methods=['GET'])
def listar_cursos():
    ref = db.reference('curso')
    dados = ref.get()
    return jsonify(dados or {})

@app.route('/unidade', methods=['GET'])
def listar_unidades():
    ref = db.reference('unidade')
    dados = ref.get()
    return jsonify(dados or {})

@app.route('/turmas', methods=['GET'])
def listar_turmas():
    ref = db.reference('turmas')
    dados = ref.get()
    return jsonify(dados or {})
# Executar o app
if __name__ == '__main__':
    app.run(debug=True)
