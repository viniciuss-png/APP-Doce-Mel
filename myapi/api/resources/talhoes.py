from flask import Blueprint, request, jsonify
from core.extensions import db
from models.talhoes import Talhao

talhaoBp = Blueprint('talhao', __name__, url_prefix='/talhao')

@talhaoBp.route('/', methods=['GET'])
def get_talhoes():
    talhoes = Talhao.query.all()
    return jsonify([talhao.to_dict() for talhao in talhoes])

@talhaoBp.route('/create', methods=['POST'])
def create_talhao():
    data = request.get_json()
    talhao = Talhao(**data)
    db.session.add(talhao)
    db.session.commit()
    return jsonify(talhao.to_dict()), 201

@talhaoBp.route('/<int:id>', methods=['PUT'])
def update_talhao(id):
    data = request.get_json()
    talhao = Talhao.query.get(id)
    if not talhao:
        return jsonify({'message': 'Talhao não encontrado'}), 404
    for key, value in data.items():
        setattr(talhao, key, value)
    db.session.commit()
    return jsonify(talhao.to_dict()), 200

@talhaoBp.route('/<int:id>', methods=['DELETE'])
def delete_talhao(id):
    data = request.get_json()
    talhao = Talhao.query.get(id)
    if not talhao:
        return jsonify({'message': 'Talhao não encontrado'}), 404
    db.session.delete(talhao)
    db.session.commit()
    return jsonify({'message': 'Talhao excluído com sucesso'}), 200