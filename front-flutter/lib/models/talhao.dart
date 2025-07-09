import 'package:docemel_f/models/registro_operacao.dart';

class Talhao {
  final String id;
  final String nome;
  final double areaTotal;
  String? codigoImagem;
  final List<RegistroOperacao> _historicoOperacoes;

  Talhao({
    required this.id,
    required this.nome,
    required this.areaTotal,
    this.codigoImagem,
    List<RegistroOperacao>? historicoOperacoes,
  }): _historicoOperacoes = historicoOperacoes ?? [];

 factory Talhao.fromJson(Map<String, dynamic> json) {
  return Talhao(
    id: json['id'].toString(), // para garantir string
    nome: json['nome'] ?? '',
    areaTotal: double.tryParse(json['area']?.toString() ?? '0') ?? 0.0, // pegando 'area' e convertendo para double
    codigoImagem: json['codigoImagem'],
    historicoOperacoes: (json['historicoOperacoes'] as List<dynamic>?)
        ?.map((op) => RegistroOperacao.fromJson(op))
        .toList(),
  );
}

 Map<String, dynamic> toJson() {
  return {
    'id': id,
    'nome': nome,
    'area': areaTotal,  // chave 'area' para o backend
    'codigoImagem': codigoImagem,
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
      codigoImagem: codigoImagem ?? this.codigoImagem,
      historicoOperacoes: historicoOperacoes ?? _historicoOperacoes,
    );
  }
}
