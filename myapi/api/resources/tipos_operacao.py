from flask import Blueprint, request, jsonify
from core.extensions import db
from models.tipos_operacao import TiposOperacao

tiposOperacaoBp = Blueprint('tiposOperacao', __name__, url_prefix='/tiposOperacao')

@tiposOperacaoBp.route('/', methods=['GET'])
def get_tipos_operacao():
    tipos_operacao = TiposOperacao.query.all()
    return jsonify([tipos_operacao.to_dict() for tipos_operacao in tipos_operacao])

@tiposOperacaoBp.route('/create', methods=['POST'])
def create_tipos_operacao():
    data = request.get_json()
    tipos_operacao = TiposOperacao(**data)
    db.session.add(tipos_operacao)
    db.session.commit()
    return jsonify(tipos_operacao.to_dict()), 201

@tiposOperacaoBp.route('/<int:id>', methods=['PUT'])
def update_tipos_operacao(id):
    data = request.get_json()
    tipos_operacao = TiposOperacao.query.get(id)
    if not tipos_operacao:
        return jsonify({'message': 'Tipos Operacao não encontrado'}), 404
    for key, value in data.items():
        setattr(tipos_operacao, key, value)
    db.session.commit()
    return jsonify(tipos_operacao.to_dict()), 200

@tiposOperacaoBp.route('/<int:id>', methods=['DELETE'])
def delete_tipos_operacao(id):
    tipos_operacao = TiposOperacao.query.get(id)
    if not tipos_operacao:
        return jsonify({'message': 'Tipos Operacao não encontrado'}), 404
    db.session.delete(tipos_operacao)
    db.session.commit()
    return jsonify({'message': 'Tipos Operacao excluído com sucesso'}), 200