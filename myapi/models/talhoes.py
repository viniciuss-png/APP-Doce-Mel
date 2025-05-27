from sqlalchemy import Column, Integer, String, Numeric
from core.extensions import db

class Talhao(db.Model):
    __tablename__ = 'talhoes'
    IdTalhao = Column(Integer, primary_key=True, autoincrement=True)
    Nome = Column(String(100), nullable=False)
    AreaTotal = Column(Numeric(precision=10, scale=2), nullable=False)
    CodigoImagem = Column(String(100), nullable=False)
    
    
    def to_dict(self):
        return {
            'id': self.IdTalhao,
            'nome': self.Nome,
            'area': self.AreaTotal,
            'codigoImagem': self.CodigoImagem
        }