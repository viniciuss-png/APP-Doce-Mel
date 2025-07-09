import 'dart:convert';

import 'package:docemel_f/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:docemel_f/models/talhao.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Talhao> talhoes = [];

  Future<List<Talhao>> getTalhoes() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/talhao'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonTalhoes = json.decode(response.body);
      final List<Talhao> talhoesList = jsonTalhoes.map((json) => Talhao.fromJson(json)).toList();
      return talhoesList;
    } else {
      throw Exception('Failed to load talhoes');
    }
  }

  void fetchTalhoes() async {
    try{
      final List<Talhao> fetchedTalhoes = await getTalhoes();
      setState(() {
        talhoes = fetchedTalhoes;
        print(talhoes);
      });
    } catch (e) {
      print('Error fetching talhoes: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTalhoes();
  }

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
                            '${talhoes.length}',
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
            child: talhoes.isEmpty
                ? const Center(child: Text('Nenhum talhão cadastrado.'))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8.0),
                    itemCount: talhoes.length,
                    itemBuilder: (context, index) {
                      final talhao = talhoes[index];

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
                              // onTap: () => _navigateToTalhaoDetail(index),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      talhao.nome,
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
                                    const SizedBox(height: 4),
                                    if (talhao.codigoImagem != null &&
                                        talhao.codigoImagem!.isNotEmpty)
                                      Text(
                                        'Código da Imagem: ${talhao.codigoImagem}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueGrey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
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

  // void _navigateToTalhaoDetail(int index) async {
  //   final Talhao? resultadoTalhao = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => TalhaoDetailScreen(talhaoData: talhoes[index]),
  //     ),
  //   );

  //   if (resultadoTalhao != null) {
  //     setState(() {
  //       talhoes[index] = resultadoTalhao;
  //     });
  //   }
  // }
}
