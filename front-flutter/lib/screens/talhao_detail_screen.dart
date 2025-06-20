import 'package:flutter/material.dart';
import 'package:docemel_f/screens/historico_operacoes_screen.dart';
import 'package:docemel_f/models/talhao.dart';
import 'package:docemel_f/models/registro_operacao.dart';

class TalhaoDetailScreen extends StatefulWidget {
  final Talhao talhaoData;

  const TalhaoDetailScreen({Key? key, required this.talhaoData})
    : super(key: key);

  @override
  State<TalhaoDetailScreen> createState() => _TalhaoDetailScreenState();
}

class _TalhaoDetailScreenState extends State<TalhaoDetailScreen> {
  late Talhao _currentTalhao;
  late double _areaFeitaHojeController;
  late TextEditingController _culturaAtualController;

  final List<String> _tiposOperacaoDisponiveis = [
    'Plantio',
    'Adubação',
    'Pulverização',
    'Colheita',
    'Irrigação',
    'Preparo de Solo',
  ];

  @override
  void initState() {
    super.initState();
    _currentTalhao = widget.talhaoData.copyWith();

    _areaFeitaHojeController = 0.0;
    _culturaAtualController = TextEditingController(
      text: _currentTalhao.cultura ?? '',
    );
  }

  @override
  void dispose() {
    _culturaAtualController.dispose();
    super.dispose();
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
        _currentTalhao.emOperacao = true;
        _currentTalhao.operacaoAtual = tipoSelecionado;
        _areaFeitaHojeController = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Operação de "$tipoSelecionado" iniciada!')),
      );
    }
  }

  void _registrarAreaFeita() {
    final double areaTotalTalhao = _currentTalhao.areaTotal;

    if (_areaFeitaHojeController <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, informe uma área válida (maior que zero).'),
        ),
      );
      return;
    }

    if (_areaFeitaHojeController > areaTotalTalhao) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'A área (${_areaFeitaHojeController} ha) não pode ser maior que a área total do talhão (${areaTotalTalhao} ha).',
          ),
          duration: const Duration(seconds: 4),
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
      _currentTalhao.historicoOperacoes.add(
        RegistroOperacao(
          tipo: _currentTalhao.operacaoAtual,
          area: _areaFeitaHojeController,
          data: dataRegistro.toIso8601String().substring(0, 10),
          cultura: _culturaAtualController.text.isNotEmpty
              ? _culturaAtualController.text
              : 'N/A',
          responsavel: 'Usuário App',
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Registrado $_areaFeitaHojeController hectares '
            'para "${_currentTalhao.operacaoAtual}" em $dataFormatada. (Adicionado ao histórico)',
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
            'Deseja realmente encerrar a operação de "${_currentTalhao.operacaoAtual}"?',
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
                  _currentTalhao.emOperacao = false;
                  _currentTalhao.operacaoAtual = null;
                  _areaFeitaHojeController = 0.0;
                });
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Operação encerrada com sucesso!')),
                );
                Navigator.of(context).pop(_currentTalhao);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _currentTalhao.cultura = _culturaAtualController.text;
        Navigator.of(context).pop(_currentTalhao);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Detalhes do Talhão ${_currentTalhao.nome}',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green[700],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              _currentTalhao.cultura = _culturaAtualController.text;
              Navigator.of(context).pop(_currentTalhao);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome do Talhão:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _currentTalhao.nome,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  'Área Total:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${_currentTalhao.areaTotal} hectares',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  'Cultura Atual:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _culturaAtualController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    labelText: 'Ex: Abacaxi, Mamão, Banana',
                    hintText: 'Digite a cultura atual',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _currentTalhao.cultura = value;
                    });
                  },
                ),

                const SizedBox(height: 24),
                Text(
                  'Status da Operação:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _currentTalhao.emOperacao
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _currentTalhao.emOperacao
                          ? Colors.red.shade300
                          : Colors.green.shade300,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_currentTalhao.emOperacao)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Em Andamento: SIM',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Operação Atual: ${_currentTalhao.operacaoAtual}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red[600],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Área feita hoje (hectares):',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                labelText: 'Hectares',
                                suffixText: 'ha',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _areaFeitaHojeController =
                                      double.tryParse(value) ?? 0.0;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _registrarAreaFeita,
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Registrar Área Feita',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _encerrarOperacao,
                                icon: const Icon(
                                  Icons.stop,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Encerrar Operação',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
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
                                fontSize: 18,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _iniciarOperacao,
                                icon: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Iniciar Nova Operação',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey.shade300),
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

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoricoOperacoesScreen(
                            talhaoNome: _currentTalhao.nome,
                            historico: _currentTalhao.historicoOperacoes,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.history, color: Colors.white),
                    label: const Text(
                      'Ver Histórico de Operações',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[400],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _currentTalhao.cultura = _culturaAtualController.text;
                      Navigator.of(context).pop(_currentTalhao);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[600],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Voltar para a lista de Talhões',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
