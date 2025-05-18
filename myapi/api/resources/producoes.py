from flask import Blueprint, request, jsonify
from core.extensions import db
from models.producoes import Producao

producoesBp = Blueprint('producoes', __name__, url_prefix='/producoes')

@producoesBp.route('/', methods=['GET'])
def get_producoes():
    producoes = Producao.query.all()
    return jsonify([producao.to_dict() for producao in producoes])

@producoesBp.route('/create', methods=['POST'])
def create_producao():
    data = request.get_json()
    producao = Producao(**data)
    db.session.add(producao)
    db.session.commit()
    return jsonify(producao.to_dict()), 201

@producoesBp.route('/<int:id>', methods=['PUT'])
def update_producao(id):
    data = request.get_json()
    producao = Producao.query.get(id)
    if not producao:
        return jsonify({'message': 'Produção não encontrada'}), 404
    for key, value in data.items():
        setattr(producao, key, value)
    db.session.commit()
    return jsonify(producao.to_dict()), 200

@producoesBp.route('/<int:id>', methods=['DELETE'])
def delete_producao(id):
    data = request.get_json()
    producao = Producao.query.get(id)
    if not producao:
        return jsonify({'message': 'Produção não encontrada'}), 404
    db.session.delete(producao)
    db.session.commit()
    return jsonify({'message': 'Produção excluída com sucesso'}), 200