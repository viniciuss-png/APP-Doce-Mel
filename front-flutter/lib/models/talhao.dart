import 'package:docemel_f/models/registro_operacao.dart';

class Talhao {
  final String id;
  final String nome;
  final double areaTotal;
  bool emOperacao;
  String? operacaoAtual;
  String? cultura;
  String? codigoImagem;
  List<RegistroOperacao> historicoOperacoes;

  Talhao({
    required this.id,
    required this.nome,
    required this.areaTotal,
    this.emOperacao = false,
    this.operacaoAtual,
    this.cultura,
    this.codigoImagem,
    List<RegistroOperacao>? historicoOperacoes,
  }) : historicoOperacoes = historicoOperacoes ?? [];

  factory Talhao.fromJson(Map<String, dynamic> json) {
    var historicoList = json['historicoOperacoes'] as List?;
    List<RegistroOperacao> parsedHistorico = historicoList != null
        ? historicoList
              .map((i) => RegistroOperacao.fromJson(i as Map<String, dynamic>))
              .toList()
        : [];

    return Talhao(
      id: json['id'] as String,
      nome: json['nome'] as String,
      areaTotal: (json['areaTotal'] as num).toDouble(),
      emOperacao: json['emOperacao'] as bool? ?? false,
      operacaoAtual: json['operacaoAtual'] as String?,
      cultura: json['cultura'] as String?,
      codigoImagem: json['codigoImagem'] as String?,
      historicoOperacoes: parsedHistorico,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'areaTotal': areaTotal,
      'emOperacao': emOperacao,
      'operacaoAtual': operacaoAtual,
      'cultura': cultura,
      'codigoImagem': codigoImagem,
      'historicoOperacoes': historicoOperacoes.map((e) => e.toJson()).toList(),
    };
  }

  Talhao copyWith({
    String? id,
    String? nome,
    double? areaTotal,
    bool? emOperacao,
    String? operacaoAtual,
    String? cultura,
    String? codigoImagem,
    List<RegistroOperacao>? historicoOperacoes,
  }) {
    return Talhao(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      areaTotal: areaTotal ?? this.areaTotal,
      emOperacao: emOperacao ?? this.emOperacao,
      operacaoAtual: operacaoAtual ?? this.operacaoAtual,
      cultura: cultura ?? this.cultura,
      codigoImagem: codigoImagem ?? this.codigoImagem,
      historicoOperacoes: historicoOperacoes ?? this.historicoOperacoes,
    );
  }
}
