from sqlalchemy import Column, Integer, String
from core.extensions import db

class TiposOperacao(db.Model):
    __tablename__ = 'tiposOperacao'
    IdTipoOperacao = Column(Integer, primary_key=True, autoincrement=True)
    Nome = Column(String(100), nullable=False)
    
    def to_dict(self):
        return {
            'id': self.IdTipoOperacao,
            'nome': self.Nome
        }