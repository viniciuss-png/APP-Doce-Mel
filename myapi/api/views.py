from flask import Blueprint
from api.resources.usuarios import usuarioBp
from api.resources.tipos_operacao import tiposOperacaoBp
from api.resources.talhoes import talhaoBp
from api.resources.operacoes import operacoesBp
from api.resources.historico import historicoBp

apiBp = Blueprint('api', __name__,url_prefix='/api')

bluePrintsApi = [ usuarioBp, tiposOperacaoBp, talhaoBp, operacoesBp, historicoBp ]

for bp in bluePrintsApi:
    apiBp.register_blueprint(bp)