from sqlalchemy import Column, Integer, String, ForeignKey, Date, Boolean
from core.extensions import db

class Operacao(db.Model):
    __tablename__ = 'operacoes'
    Id = Column(Integer, primary_key=True, autoincrement=True)
    IdTalhao = Column(Integer,ForeignKey('talhoes.Id'), nullable=False)
    IdTipoOperacao = Column(Integer,ForeignKey('tiposOperacao.Id'), nullable=False)
    Cultura = Column(String(100), nullable=False)
    DataInicio = Column(Date, nullable=False)
    Status = Column(Boolean, nullable=False, default=False)
    
    def to_dict(self):
        return {
            'id': self.Id,
            'talhao': self.IdTalhao,
            'cultura': self.Cultura,
            'tipoOperacao': self.IdTipoOperacao,
            'dataInicio': self.DataInicio,
            'finalizada': self.Status
        }