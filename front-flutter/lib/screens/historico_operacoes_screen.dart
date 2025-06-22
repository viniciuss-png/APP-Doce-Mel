import 'package:flutter/material.dart';
import 'package:docemel_f/models/registro_operacao.dart';

class HistoricoOperacoesScreen extends StatelessWidget {
  final String talhaoNome;
  final List<RegistroOperacao> historico;

  const HistoricoOperacoesScreen({
    Key? key,
    required this.talhaoNome,
    required this.historico,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histórico de Operações - Talhão $talhaoNome',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: historico.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma operação registrada ainda.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: historico.length,
              itemBuilder: (context, index) {
                final registro = historico[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tipo: ${registro.tipo ?? 'N/A'}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Área: ${registro.area ?? 0.0} ha',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Cultura: ${registro.cultura ?? 'Não especificada'}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Data: ${registro.data ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Responsável: ${registro.responsavel ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
