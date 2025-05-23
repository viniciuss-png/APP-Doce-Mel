import 'package:flutter/material.dart';
import 'package:docemel_f/screens/talhao_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final talhoes = ['A', 'B', 'C'];

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
                'Talhão $talhao',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Clique para ver mais detalhes do Talhão'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TalhaoDetailScreen(nomeTalhao: talhao),
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
