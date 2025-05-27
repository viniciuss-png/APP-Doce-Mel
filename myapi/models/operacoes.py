from sqlalchemy import Column, Integer, String, ForeignKey, Date, BOOLEAN
from core.extensions import db

class Operacao(db.Model):
    __tablename__ = 'operacoes'
    idOperacao = Column(Integer, primary_key=True, autoincrement=True)
    idProducao = Column(Integer,ForeignKey('producoes.idProducao'), nullable=False)
    idTipoOperacao = Column(Integer,ForeignKey('tipos_operacao.idTipoOperacao'), nullable=False)
    DataInicio = Column(Date, nullable=False)
    Finalizada = Column(BOOLEAN, nullable=False, default=False)
    
    def to_dict(self):
        return {
            'id': self.idOperacao,
            'producao': self.idProducao,
            'tipoOperacao': self.idTipoOperacao,
            'dataInicio': self.DataInicio,
            'finalizada': self.Finalizada
        }