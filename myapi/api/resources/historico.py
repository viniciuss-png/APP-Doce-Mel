from flask import Blueprint, request, jsonify
from core.extensions import db
from models.historico import Historico

historicoBp = Blueprint('historico', __name__, url_prefix='/historico')

@historicoBp.route('/', methods=['GET'])
def get_historico():
    historico = Historico.query.all()
    return jsonify([historico.to_dict() for historico in historico])
