from flask import Flask
from core.config import Config
from core.extensions import db
from api.views import apiBp
from sqlalchemy import MetaData
from flask_cors import CORS



def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    CORS(app, resources={r"/*": {"origins": "*"}})
    app.register_blueprint(apiBp)
    db.init_app(app)
    
    return app

app = create_app()


with app.app_context():
    metadata = MetaData()
    metadata.reflect(bind=db.engine)
    metadata.drop_all(db.engine)
    
    from models import historico, talhoes, tipos_operacao, operacoes
    db.create_all()

if __name__ == "__main__":
    app.run(debug=True)
