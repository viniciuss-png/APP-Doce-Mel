from flask import Blueprint
from api.resources.usuarios import usuarioBp

apiBp = Blueprint('api', __name__,url_prefix='/api')
apiBp.register_blueprint(usuarioBp)