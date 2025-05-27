from flask import Flask
from core.config import Config
from core.extensions import db
from api.views import apiBp


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    db.init_app(app)
    app.register_blueprint(apiBp)
    return app

app = create_app()

if __name__ == "__main__":
    app.run(debug=True)
