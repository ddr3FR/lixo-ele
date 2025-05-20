import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login / Registro',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF2E5130),
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showLogin = true;

  // Controllers para os campos
  final _loginNameCtrl = TextEditingController();
  final _loginPassCtrl = TextEditingController();
  final _regNameCtrl = TextEditingController();
  final _regMatriculaCtrl = TextEditingController();
  final _regPassCtrl = TextEditingController();
  final _regPassConfirmCtrl = TextEditingController();

  @override
  void dispose() {
    _loginNameCtrl.dispose();
    _loginPassCtrl.dispose();
    _regNameCtrl.dispose();
    _regMatriculaCtrl.dispose();
    _regPassCtrl.dispose();
    _regPassConfirmCtrl.dispose();
    super.dispose();
  }

  Widget _buildSocialDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (_) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.yellow),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.yellow),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.yellow),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.yellow, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Expanded(
                  child: AnimatedCrossFade(
                    firstChild: _loginForm(),
                    secondChild: _registerForm(),
                    crossFadeState:
                        _showLogin
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 400),
                  ),
                ),

                // Botão para alternar entre Login e Registrar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.yellow),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () => setState(() => _showLogin = !_showLogin),
                  child: Text(
                    _showLogin ? 'Registrar-se' : 'Login',
                    style: const TextStyle(color: Colors.yellow, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Botão de Login “social” (só desenho)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.yellow, fontSize: 20),
          ),
        ),
        const SizedBox(height: 16),
        _buildSocialDots(),
        const SizedBox(height: 24),
        TextField(
          controller: _loginNameCtrl,
          style: const TextStyle(color: Colors.yellow),
          decoration: _inputDecoration('Nome'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _loginPassCtrl,
          obscureText: true,
          style: const TextStyle(color: Colors.yellow),
          decoration: _inputDecoration('Senha'),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: lógica de login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.yellow),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {
                // TODO: “Esqueci minha senha”
              },
              child: const Text(
                'Esqueci minha senha',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _registerForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.yellow),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text(
              'Registrar-se',
              style: TextStyle(color: Colors.yellow, fontSize: 20),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _regNameCtrl,
            style: const TextStyle(color: Colors.yellow),
            decoration: _inputDecoration('Nome'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _regMatriculaCtrl,
            style: const TextStyle(color: Colors.yellow),
            decoration: _inputDecoration('Matrícula'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _regPassCtrl,
            obscureText: true,
            style: const TextStyle(color: Colors.yellow),
            decoration: _inputDecoration('Senha'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _regPassConfirmCtrl,
            obscureText: true,
            style: const TextStyle(color: Colors.yellow),
            decoration: _inputDecoration('Confirmar Senha'),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: lógica de registro (validar se as senhas coincidem, etc.)
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: Colors.yellow),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Entrar', style: TextStyle(color: Colors.yellow)),
          ),
        ],
      ),
    );
  }
}
