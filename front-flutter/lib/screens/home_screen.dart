import 'package:docemel_f/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:docemel_f/screens/talhao_detail_screen.dart';
import 'package:docemel_f/models/talhao.dart';
import 'package:docemel_f/models/registro_operacao.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Talhao> _talhoes = [
    Talhao(
      id: '1',
      nome: 'A',
      areaTotal: 100.0,
      emOperacao: true,
      operacaoAtual: 'Adubação',
      cultura: 'Cana-de-açúcar',
      historicoOperacoes: [
        RegistroOperacao(
          tipo: 'Plantio Inicial',
          area: 100.0,
          data: '2023-01-01',
          cultura: 'Cana-de-açúcar',
          responsavel: 'Sistema',
        ),
        RegistroOperacao(
          tipo: 'Adubação',
          area: 50.0,
          data: '2023-03-15',
          cultura: 'Cana-de-açúcar',
          responsavel: 'João',
        ),
      ],
    ),
    Talhao(
      id: '2',
      nome: 'B',
      areaTotal: 150.0,
      emOperacao: false,
      operacaoAtual: null,
      cultura: 'Milho',
      historicoOperacoes: [
        RegistroOperacao(
          tipo: 'Plantio',
          area: 150.0,
          data: '2022-09-01',
          cultura: 'Milho',
          responsavel: 'Maria',
        ),
      ],
    ),
    Talhao(
      id: '3',
      nome: 'C',
      areaTotal: 80.0,
      emOperacao: true,
      operacaoAtual: 'Colheita',
      cultura: 'Soja',
      historicoOperacoes: [],
    ),
    Talhao(
      id: '4',
      nome: 'D',
      areaTotal: 200.0,
      emOperacao: false,
      operacaoAtual: null,
      cultura: null,
      historicoOperacoes: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doce Mel - Talhões',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout efetuado com sucesso!')),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.lightGreen[50],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.landscape, color: Colors.green[700], size: 36),
                      const SizedBox(width: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'Total de Talhões: ',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${_talhoes.length}',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: const Divider(color: Colors.grey, height: 20, thickness: 1),
          ),
          Expanded(
            child: _talhoes.isEmpty
                ? const Center(child: Text('Nenhum talhão cadastrado.'))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8.0),
                    itemCount: _talhoes.length,
                    itemBuilder: (context, index) {
                      final talhao = _talhoes[index];
                      final bool emOperacao = talhao.emOperacao;
                      final String? operacaoAtual = talhao.operacaoAtual;
                      final String? cultura = talhao.cultura;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () => _navigateToTalhaoDetail(index),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Talhão ${talhao.nome}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Área Total: ${talhao.areaTotal} ha',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          emOperacao
                                              ? Icons.warning_rounded
                                              : Icons.check_circle_outline,
                                          color: emOperacao
                                              ? Colors.red[700]
                                              : Colors.green[700],
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Status: ${emOperacao ? 'Em Operação' : 'Inativo'}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: emOperacao
                                                ? Colors.red[700]
                                                : Colors.green[700],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    if (emOperacao)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (operacaoAtual != null &&
                                              operacaoAtual.isNotEmpty)
                                            Text(
                                              'Operação Atual: $operacaoAtual',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.red,
                                              ),
                                            ),
                                          const SizedBox(height: 4),
                                          if (cultura != null &&
                                              cultura.isNotEmpty)
                                            Text(
                                              'Cultura: $cultura',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.blueGrey[700],
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                        ],
                                      )
                                    else if (cultura != null &&
                                        cultura.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4),
                                          Text(
                                            'Cultura: $cultura',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blueGrey[700],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _navigateToTalhaoDetail(int index) async {
    final Talhao? resultadoTalhao = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TalhaoDetailScreen(talhaoData: _talhoes[index]),
      ),
    );

    if (resultadoTalhao != null) {
      setState(() {
        _talhoes[index] = resultadoTalhao;
      });
    }
  }
}
