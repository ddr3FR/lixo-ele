import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlunoReciclagem {
  final String nome;
  final double totalKg;
  final String residuo;
  final double residuoKg;

  AlunoReciclagem({
    required this.nome,
    required this.totalKg,
    required this.residuo,
    required this.residuoKg,
  });

  factory AlunoReciclagem.fromJson(Map<String, dynamic> json) {
    return AlunoReciclagem(
      nome: json['nomeAluno'],
      totalKg: (json['totalKg'] as num).toDouble(),
      residuo: json['residuoMaisDeposito']['tipo'],
      residuoKg: (json['residuoMaisDeposito']['kg'] as num).toDouble(),
    );
  }
}

class PodiumListScreen extends StatefulWidget {
  @override
  _PodiumListScreenState createState() => _PodiumListScreenState();
}

class _PodiumListScreenState extends State<PodiumListScreen> {
  List<AlunoReciclagem> _data = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    final jsonString =
        await rootBundle.loadString('assets/reciclagem_podium.json');
    final List parsed = json.decode(jsonString);
    setState(() {
      _data = parsed
          .map((e) => AlunoReciclagem.fromJson(e))
          .take(5)
          .toList(); // top 5
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return Center(child: CircularProgressIndicator());

    // Encontre o maior total para usar como base de porcentagem
    final maxTotal =
        _data.map((e) => e.totalKg).reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(title: Text('Top 5 Contribuidores')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _data.length,
        itemBuilder: (ctx, i) {
          final a = _data[i];
          // percentuais relativos ao maior total
          final pctTotal = (a.totalKg / maxTotal).clamp(0.0, 1.0);
          final pctResiduo = (a.residuoKg / maxTotal).clamp(0.0, 1.0);

          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho: nome e resíduo+valor
                  Text(a.nome,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(
                    '${a.residuo} — ${a.residuoKg.toStringAsFixed(1)} kg',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 12),

                  // Barra do resíduo (cinza)
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: pctResiduo,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: -2,
                        child: Text(
                          '${a.residuoKg.toStringAsFixed(0)} kg',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Barra do total (azul)
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: pctTotal,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: -2,
                        child: Text(
                          '${a.totalKg.toStringAsFixed(0)} kg',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
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
