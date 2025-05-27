from sqlalchemy import Column, Integer, String
from core.extensions import db

class Usuario(db.Model):
    __tablename__ = 'usuarios'

    idUsuario = Column(Integer, primary_key=True, autoincrement=True)
    Nome = Column(String(100), nullable=False)
    Email = Column(String(100), nullable=False, unique=True)
    senhaHash = Column(String(255), nullable=False)
    
    def to_dict(self):
        return {
            'id': self.idUsuario,
            'nome': self.Nome,
            'email': self.Email
        }
