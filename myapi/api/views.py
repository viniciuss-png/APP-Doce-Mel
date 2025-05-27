from flask import Blueprint
from api.resources.usuarios import usuarioBp
from api.resources.tipos_operacao import tiposOperacaoBp
from api.resources.talhoes import talhaoBp
from api.resources.producoes import producoesBp
from api.resources.operacoes import operacoesBp

apiBp = Blueprint('api', __name__,url_prefix='/api')

bluePrintsApi = [ usuarioBp, tiposOperacaoBp, talhaoBp, producoesBp, operacoesBp ]

for bp in bluePrintsApi:
    apiBp.register_blueprint(bp)