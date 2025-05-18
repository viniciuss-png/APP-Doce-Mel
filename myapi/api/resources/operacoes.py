from flask import Blueprint, request, jsonify
from core.extensions import db
from models.operacoes import Operacao

operacoesBp = Blueprint('operacoes', __name__, url_prefix='/operacoes')

@operacoesBp.route('/', methods=['GET'])
def get_operacoes():
    operacoes = Operacao.query.all()
    return jsonify([operacoes.to_dict() for operacoes in operacoes])

@operacoesBp.route('/create', methods=['POST'])
def create_operacoes():
    data = request.get_json()
    operacoes = Operacao(**data)
    db.session.add(operacoes)
    db.session.commit()
    return jsonify(operacoes.to_dict()), 201

@operacoesBp.route('/<int:id>', methods=['PUT'])
def update_operacoes(id):
    data = request.get_json()
    operacoes = Operacao.query.get(id)
    if not operacoes:
        return jsonify({'message': 'Operação não encontrada'}), 404
    for key, value in data.items():
        setattr(operacoes, key, value)
    db.session.commit()
    return jsonify(operacoes.to_dict()), 200

@operacoesBp.route('/<int:id>', methods=['DELETE'])
def delete_operacoes(id):
    operacoes = Operacao.query.get(id)
    if not operacoes:
        return jsonify({'message': 'Operação não encontrada'}), 404
    db.session.delete(operacoes)
    db.session.commit()
    return jsonify({'message': 'Operação excluída com sucesso'}), 200
