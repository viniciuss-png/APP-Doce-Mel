import 'package:flutter/material.dart';

class TalhaoDetailScreen extends StatefulWidget {
  final Map<String, dynamic> talhaoData;

  const TalhaoDetailScreen({Key? key, required this.talhaoData})
    : super(key: key);

  @override
  State<TalhaoDetailScreen> createState() => _TalhaoDetailScreenState();
}

class _TalhaoDetailScreenState extends State<TalhaoDetailScreen> {
  late bool _emOperacao;
  late String? _operacaoAtual;
  late double _areaFeitaHojeController;

  final List<String> _tiposOperacaoDisponiveis = [
    'Plantio',
    'Adubação',
    'Pulverização',
    'Colheita',
    'Irrigação',
  ];

  @override
  void initState() {
    super.initState();
    _emOperacao = widget.talhaoData['emOperacao'] ?? false;
    _operacaoAtual = widget.talhaoData['operacaoAtual'];
    _areaFeitaHojeController = 0.0;
  }

  Future<void> _iniciarOperacao() async {
    final String? tipoSelecionado = await showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(
          title: const Text('Selecione o Tipo de Operação'),
          children: _tiposOperacaoDisponiveis.map((String tipo) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(dialogContext, tipo);
              },
              child: Text(tipo),
            );
          }).toList(),
        );
      },
    );

    if (tipoSelecionado != null) {
      setState(() {
        _emOperacao = true;
        _operacaoAtual = tipoSelecionado;
        _areaFeitaHojeController = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Operação de "$tipoSelecionado" iniciada!')),
      );
    }
  }

  void _registrarAreaFeita() {
    if (_areaFeitaHojeController <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, informe uma área válida (maior que zero).'),
        ),
      );
      return;
    }

    final DateTime dataRegistro = DateTime.now();
    final String dataFormatada =
        '${dataRegistro.day.toString().padLeft(2, '0')}/'
        '${dataRegistro.month.toString().padLeft(2, '0')}/'
        '${dataRegistro.year} '
        '${dataRegistro.hour.toString().padLeft(2, '0')}:'
        '${dataRegistro.minute.toString().padLeft(2, '0')}';

    setState(() {
      // No futuro, o backend enviará:
      // - widget.talhaoData['id'] (IdTalhao)
      // - _operacaoAtual (o tipo de operação, que precisaria ser mapeado para IdTipoOperacao)
      // - _areaFeitaHojeController (AreaFeitaHa)
      // - dataRegistro (DataRegistro)
      // - E talvez um ID de usuário ou nome do responsável

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Registrado $_areaFeitaHojeController hectares '
            'para "${_operacaoAtual}" em $dataFormatada.',
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    });
  }

  void _encerrarOperacao() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Encerrar Operação'),
          content: Text(
            'Deseja realmente encerrar a operação de "${_operacaoAtual}"?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Sim, Encerrar'),
              onPressed: () {
                setState(() {
                  _emOperacao = false;
                  _operacaoAtual = null;
                  _areaFeitaHojeController = 0.0;
                });
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Operação encerrada com sucesso!')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Talhão ${widget.talhaoData['nome']}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome do Talhão:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(widget.talhaoData['nome']?.toString() ?? 'N/A'),
              ),

              const SizedBox(height: 24),

              Text(
                'Área Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '${widget.talhaoData['areaTotal']?.toString() ?? 'N/A'} hectares',
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Status da Operação:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _emOperacao ? Colors.red[50] : Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _emOperacao ? Colors.red : Colors.green,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_emOperacao)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Em Andamento: SIM',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Operação Atual: ${_operacaoAtual}',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Área feita hoje (hectares):',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Hectares',
                              suffixText: 'ha',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _areaFeitaHojeController =
                                    double.tryParse(value) ?? 0.0;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _registrarAreaFeita,
                            icon: Icon(Icons.check),
                            label: Text('Registrar Área Feita'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _encerrarOperacao,
                            icon: Icon(Icons.stop),
                            label: Text('Encerrar Operação'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Em Andamento: NÃO',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _iniciarOperacao,
                            icon: Icon(Icons.play_arrow),
                            label: Text('Iniciar Nova Operação'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Imagem do Talhão:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'A imagem do talhão será exibida aqui futuramente',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar para a lista de Talhões'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
