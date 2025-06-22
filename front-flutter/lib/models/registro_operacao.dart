class RegistroOperacao {
  final String? tipo;
  final double? area;
  final String? data;
  final String? cultura;
  final String? responsavel;

  RegistroOperacao({
    this.tipo,
    this.area,
    this.data,
    this.cultura,
    this.responsavel,
  });

  factory RegistroOperacao.fromJson(Map<String, dynamic> json) {
    return RegistroOperacao(
      tipo: json['tipo'] as String?,
      area: (json['area'] as num?)?.toDouble(),
      data: json['data'] as String?,
      cultura: json['cultura'] as String?,
      responsavel: json['responsavel'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'area': area,
      'data': data,
      'cultura': cultura,
      'responsavel': responsavel,
    };
  }
}
