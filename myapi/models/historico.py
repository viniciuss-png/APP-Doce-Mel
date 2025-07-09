from sqlalchemy import Column, ForeignKey, Integer, String, Numeric
from core.extensions import db

class Historico(db.Model):
    __tablename__ = 'Historico'
    Id = Column(Integer, primary_key=True, autoincrement=True)
    IdTalhao = Column(Integer, ForeignKey('talhoes.Id'), nullable=False)
    Nome = Column(String(100), nullable=False)
    Cultura = Column(String(100), nullable=False)
    Operacao = Column(String(100), nullable=False)
    Data = Column(String(100), nullable=False)
    Area = Column(Numeric(precision=10, scale=2), nullable=False)
    Responsavel = Column(String(100), nullable=False)
  

    def to_dict(self):
        return {
            'id': self.Id,
            'talhao': self.IdTalhao,
            'nome': self.Nome,
            'cultura': self.Cultura,
            'operacao': self.Operacao,
            'data': self.Data,
            'area': self.Area,
            'responsavel': self.Responsavel
        }