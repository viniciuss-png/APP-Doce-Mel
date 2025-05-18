from flask import Blueprint, request, jsonify
from core.extensions import db
from models.tipos_operacao import TiposOperacao

tiposOperacaoBp = Blueprint('tiposOperacao', __name__, url_prefix='/tiposOperacao')

@tiposOperacaoBp.route('/', methods=['GET'])
def get_tiposOperacao():
    tiposOperacao = TiposOperacao.query.all()
    return jsonify([tiposOperacao.to_dict() for tiposOperacao in tiposOperacao])

@tiposOperacaoBp.route('/create', methods=['POST'])
def create_tiposOperacao():
    data = request.get_json()
    tiposOperacao = TiposOperacao(**data)
    db.session.add(tiposOperacao)
    db.session.commit()
    return jsonify(tiposOperacao.to_dict()), 201

@tiposOperacaoBp.route('/<int:id>', methods=['PUT'])
def update_tiposOperacao(id):
    data = request.get_json()
    tiposOperacao = TiposOperacao.query.get(id)
    if not tiposOperacao:
        return jsonify({'message': 'TiposOperacao não encontrado'}), 404
    for key, value in data.items():
        setattr(tiposOperacao, key, value)
    db.session.commit()
    return jsonify(tiposOperacao.to_dict()), 200

@tiposOperacaoBp.route('/<int:id>', methods=['DELETE'])
def delete_tiposOperacao(id):
    tiposOperacao = TiposOperacao.query.get(id)
    if not tiposOperacao:
        return jsonify({'message': 'TiposOperacao não encontrado'}), 404
    db.session.delete(tiposOperacao)
    db.session.commit()
    return jsonify({'message': 'TiposOperacao excluído com sucesso'}), 200