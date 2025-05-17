import 'package:flutter/material.dart';

class Turma {
  final int id;
  final String nome;

  Turma({required this.id, required this.nome});

  // Método para converter a partir de JSON
  factory Turma.fromJson(Map<String, dynamic> json) {
    return Turma(
      id: json['id'],
      nome: json['nome'],
    );
  }
}

class CreateAlunoScreen extends StatefulWidget {
  @override
  _CreateAlunoScreenState createState() => _CreateAlunoScreenState();
}

class _CreateAlunoScreenState extends State<CreateAlunoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _matriculaController = TextEditingController();

  List<Turma> _turmas = [];
  Turma? _selectedTurma;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchTurmas();
  }

  Future<void> _fetchTurmas() async {
    setState(() {
      _loading = true;
    });
    try {
      // TODO: Substitua pela chamada real do seu endpoint
      // final response = await http.get(Uri.parse('https://api.seuservidor.com/turmas'));
      // final List data = jsonDecode(response.body);
      // List<Turma> turmas = data.map((e) => Turma.fromJson(e)).toList();

      await Future.delayed(Duration(seconds: 1));
      // Mock de dados
      List<Turma> turmas = [
        Turma(id: 1, nome: '1º Ano A'),
        Turma(id: 2, nome: '1º Ano B'),
        Turma(id: 3, nome: '2º Ano A'),
      ];

      setState(() {
        _turmas = turmas;
      });
    } catch (e) {
      // Tratar erro
      print('Erro ao buscar turmas: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _saveAluno() {
    if (!_formKey.currentState!.validate() || _selectedTurma == null) {
      // Pode mostrar um erro para selecionar turma
      return;
    }

    final alunoData = {
      'nome': _nomeController.text,
      'email': _emailController.text,
      'telefone': _telefoneController.text,
      'matricula': _matriculaController.text,
      'turmaId': _selectedTurma!.id,
    };

    // TODO: Enviar alunoData para o seu endpoint de criação de aluno
    print('Aluno a ser salvo: \$alunoData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Aluno'),
      ),
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
                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(labelText: 'Nome do Aluno *'),
                        validator: (v) => (v == null || v.isEmpty) ? 'Informe o nome' : null,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _telefoneController,
                        decoration: InputDecoration(labelText: 'Telefone'),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _matriculaController,
                        decoration: InputDecoration(labelText: 'Matrícula'),
                      ),
                      SizedBox(height: 12),
                      // DropdownButtonFormField<Turma>(
                      //   value: _selectedTurma,
                      //   decoration: InputDecoration(labelText: 'Turma'),
                      //   items: _turmas
                      //       .map(
                      //         (t) => DropdownMenuItem(
                      //           value: t,
                      //           child: Text(t.nome),
                      //         ),
                      //       )
                      //       .toList(),
                      //   onChanged: (t) {
                      //     setState(() => _selectedTurma = t);
                      //   },
                      //   validator: (_) => _selectedTurma == null ? 'Selecione uma turma' : null,
                      // ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _saveAluno,
                        child: Text('Salvar'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
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
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _matriculaController.dispose();
    super.dispose();
  }
}



