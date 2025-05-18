from sqlalchemy import Column, Integer, Date, ForeignKey
from core.extensions import db


class Producao(db.Model):
    __tablename__ = 'producoes'
    idProducao = Column(Integer, primary_key=True, autoincrement=True)
    DataInicio = Column(Date, nullable=False)
    DataFim = Column(Date, nullable=False)
    idTalhao = Column(Integer,ForeignKey('talhoes.idTalhao'), nullable=False)
    
    def to_dict(self):
        return {
            'id': self.idProducao,
            'dataInicio': self.DataInicio,
            'dataFim': self.DataFim,
            'talhao': self.idTalhao
        }