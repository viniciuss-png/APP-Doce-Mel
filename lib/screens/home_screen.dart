import 'package:flutter/material.dart';
import 'package:docemel_f/screens/talhao_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de talhões com dados simulados, usando Map<String, dynamic>
    // As chaves do mapa ('id', 'nome', 'areaTotal', 'emOperacao', 'operacaoAtual')
    // correspondem aos dados que esperamos do backend.
    final List<Map<String, dynamic>> talhoes = const [
      {
        'id': '1',
        'nome': 'A',
        'areaTotal': 100.0,
        'emOperacao': true, // Talhão A está em operação
        'operacaoAtual': 'Adubação',
      },
      {
        'id': '2',
        'nome': 'B',
        'areaTotal': 150.0,
        'emOperacao': false, // Talhão B não está em operação
        'operacaoAtual': null,
      },
      {
        'id': '3',
        'nome': 'C',
        'areaTotal': 80.0,
        'emOperacao': true, // Talhão C está em operação
        'operacaoAtual': 'Pulverização',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione um Talhão'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: talhoes.length,
        itemBuilder: (context, index) {
          final talhao = talhoes[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                Icons.landscape,
                color: Colors.green[800],
                size: 32,
              ),
              title: Text(
                'Talhão ${talhao['nome']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Clique para ver mais detalhes do Talhão'),
                  if (talhao['emOperacao'] == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Operação: ${talhao['operacaoAtual']}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TalhaoDetailScreen(talhaoData: talhao),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
