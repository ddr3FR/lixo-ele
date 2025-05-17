import 'package:flutter/material.dart';
import 'package:lixo_ele/screens/locais_screen.dart';
import '../widgets/menu_button.dart';
import 'package:lixo_ele/screens/createAluno.dart';
import 'package:lixo_ele/screens/createReciclagem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isColorMode = false;

  void _mostrarDialogAjuda(String titulo, String texto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(
            texto,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarTextoAjudar() {
    _mostrarDialogAjuda(
      'Central de Ajuda',
      'Bem-vindo à Central de Ajuda! Aqui você encontra respostas rápidas para dúvidas comuns, tutoriais e orientações sobre como usar o nosso aplicativo.\n\n'
          'Perguntas Frequentes (FAQ): consulte soluções para os principais desafios.\n'
          'Tutoriais: aprenda a usar funcionalidades com passo a passo simples.\n\n'
          'Contato: precisou de ajuda personalizada? Fale conosco via email (projetoflask100@gmail.com), chat ou telefone (horário comercial).',
    );
  }

  void _mostrarTextoAnuncio() {
    _mostrarDialogAjuda(
      'Versão Sem Anúncio',
      'Desfrute de uma experiência livre de interrupções com a versão sem anúncios do Lixo Ele!\n\n'
          'Navegação fluida: aproveite o app sem pausas ou distrações.\n'
          'Velocidade máxima: carregamento mais rápido e desempenho otimizado.\n'
          'Apenas o essencial: foco total no que realmente importa para você.\n\n'
          'Como adquirir: acesse Configurações > Assinaturas ou visite nossa loja de apps. Escolha entre assinatura mensal/anual ou compra única.',
    );
  }

  void _mostrarTextoNotificacao() {
    _mostrarDialogAjuda(
      'Central de Notificações',
      'Mantenha-se informado(a) e no controle! Aqui você gerencia quais alertas receber, personaliza preferências e garante que só o que é relevante chegue até você.',
    );
  }

  void _mostrarTextoDivulgue() {
    _mostrarDialogAjuda(
      'Divulgue',
      'Sabe de algum ponto de coleta que não esteja sinalizado no nosso aplicativo?\n\n'
          'Entre em contato clicando aqui para nos ajudar a divulgar esse novo ponto.',
    );
  }

  void _mostrarTextoAvaliar() {
    _mostrarDialogAjuda(
      'Avaliação',
      'Nem precisa, nos dois sabemos que somos o melhor em ser nós mesmos.\n\n⭐⭐⭐⭐⭐',
    );
  }

  void _mostrarTextoSuporte() {
    _mostrarDialogAjuda(
      'Suporte',
      'Precisando de ajuda? Estamos aqui para resolver qualquer desafio, dúvida ou sugestão que você tenha!\n\n'
          'Como nos contatar:\n'
          'E-mail: suporte@nomedoapp.com (resposta em até 24h).\n'
          'Chat online: disponível no app em horário comercial (seg-sex, 8h às 18h).\n'
          'Telefone: (21) 4002-8922 (seg-sex, 6h às 12h).',
    );
  }

  void _onMenuSelected(String opcao) {
    Navigator.of(context).pop(); // fecha o drawer
    switch (opcao) {
      case 'central_ajuda':
        _mostrarTextoAjudar();
        break;
      case 'versao_sem_anuncio':
        _mostrarTextoAnuncio();
        break;
      case 'central_notificacoes':
        _mostrarTextoNotificacao();
        break;
      case 'divulgar':
        _mostrarTextoDivulgue();
        break;
      case 'avalie_nos':
        _mostrarTextoAvaliar();
        break;
      case 'configuracoes':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Configurações')));
        break;
      case 'suporte':
        _mostrarTextoSuporte();
        break;
      case 'recicla':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateReciclagemScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0A6435)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Central de ajuda'),
              onTap: () => _onMenuSelected('central_ajuda'),
            ),
            ListTile(
              leading: const Icon(Icons.remove_red_eye_outlined),
              title: const Text('Versão sem anúncio'),
              onTap: () => _onMenuSelected('versao_sem_anuncio'),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Central de notificações'),
              onTap: () => _onMenuSelected('central_notificacoes'),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Divulgue'),
              onTap: () => _onMenuSelected('divulgar'),
            ),
            ListTile(
              leading: const Icon(Icons.star_border),
              title: const Text('Avalie-nos'),
              onTap: () => _onMenuSelected('avalie_nos'),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Configurações'),
              onTap: () => _onMenuSelected('configuracoes'),
            ),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text('Suporte'),
              onTap: () => _onMenuSelected('suporte'),
            ),
            ListTile(
              leading: const Icon(Icons.recycling),
              title: const Text('Recicle Aqui'),
              onTap: () => _onMenuSelected('recicla'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/imagemSerRecicla.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Builder(
                        builder:
                            (context) => IconButton(
                              icon: const Icon(Icons.menu),
                              color:
                                  isColorMode
                                      ? const Color(0xFF0A6435)
                                      : Colors.black,
                              onPressed:
                                  () => Scaffold.of(context).openDrawer(),
                            ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Ser Recicla',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0A6435),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuButton(
                      label: 'Cadastra Aluno',
                      onPressed: () {
                        // Navegação substitui o popup
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAlunoScreen(),
                          ),
                        );
                      },
                    ),
                    MenuButton(
                      label: 'A importância do Descarte no Local Correto',
                      popupText:
                          'O descarte adequado do lixo eletrônico é essencial para proteger o planeta, garantir saúde pública e promover sustentabilidade. Pequenas ações individuais, somadas a políticas públicas e responsabilidade corporativa, podem transformar esse desafio em uma oportunidade para um futuro mais equilibrado.',
                    ),
                    MenuButton(
                      label: 'Venha conhecer os Locais de coleta',
                      onPressed: () {
                        // Navegação substitui o popup
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocaisScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
