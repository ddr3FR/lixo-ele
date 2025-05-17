import 'package:flutter/material.dart';

class ResiduoTipo {
  final int id;
  final String nome;

  ResiduoTipo({required this.id, required this.nome});

  factory ResiduoTipo.fromJson(Map<String, dynamic> json) {
    return ResiduoTipo(
      id: json['id'],
      nome: json['nome'],
    );
  }
}

class Aluno {
  final int id;
  final String nome;

  Aluno({required this.id, required this.nome});

  factory Aluno.fromJson(Map<String, dynamic> json) {
    return Aluno(
      id: json['id'],
      nome: json['nome'],
    );
  }
}

class CreateReciclagemScreen extends StatefulWidget {
  @override
  _CreateReciclagemScreenState createState() => _CreateReciclagemScreenState();
}

class _CreateReciclagemScreenState extends State<CreateReciclagemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantidadeController = TextEditingController();

  List<ResiduoTipo> _tipos = [];
  ResiduoTipo? _selectedTipo;

  List<Aluno> _alunos = [];
  Aluno? _selectedAluno;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    try {
      // TODO: Substituir pela chamada real a API de tipos de resíduo
      await Future.delayed(Duration(seconds: 1));
      List<ResiduoTipo> tiposMock = [
        ResiduoTipo(id: 1, nome: 'Plástico'),
        ResiduoTipo(id: 2, nome: 'Papel'),
        ResiduoTipo(id: 3, nome: 'Metal'),
      ];

      // TODO: Substituir pela chamada real a API de alunos
      await Future.delayed(Duration(milliseconds: 500));
      List<Aluno> alunosMock = [
        Aluno(id: 1, nome: 'João Silva'),
        Aluno(id: 2, nome: 'Maria Souza'),
      ];

      setState(() {
        _tipos = tiposMock;
        _alunos = alunosMock;
      });
    } catch (e) {
      print('Erro ao buscar dados: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _saveReciclagem() {
    if (!_formKey.currentState!.validate() || _selectedTipo == null || _selectedAluno == null) {
      return;
    }

    final data = {
      'tipoResiduoId': _selectedTipo!.id,
      'quantidade': double.tryParse(_quantidadeController.text) ?? 0,
      'alunoId': _selectedAluno!.id,
    };
    
    // TODO: Enviar dados para o endpoint
    print('Reciclagem a ser salva: \$data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Reciclagem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<ResiduoTipo>(
                        value: _selectedTipo,
                        decoration: InputDecoration(labelText: 'Tipo de Resíduo'),
                        items: _tipos.map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(t.nome),
                        )).toList(),
                        onChanged: (t) => setState(() => _selectedTipo = t),
                        validator: (_) => _selectedTipo == null ? 'Selecione um tipo' : null,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _quantidadeController,
                        decoration: InputDecoration(
                          labelText: 'Quantidade (kg)*',
                          hintText: 'Quantidade em kg',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Informe a quantidade';
                          if (double.tryParse(v) == null) return 'Digite um número válido';
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField<Aluno>(
                        value: _selectedAluno,
                        decoration: InputDecoration(labelText: 'Aluno'),
                        items: _alunos.map((a) => DropdownMenuItem(
                          value: a,
                          child: Text(a.nome),
                        )).toList(),
                        onChanged: (a) => setState(() => _selectedAluno = a),
                        validator: (_) => _selectedAluno == null ? 'Selecione um aluno' : null,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _saveReciclagem,
                        child: Text('Salvar'),
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }
}
