import 'package:flutter/material.dart';
import 'package:lixo_ele/screens/locais_screen.dart';
import '../widgets/menu_button.dart';

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
              child: const Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  void _mostrarTextoAjudar() {
    _mostrarDialogAjuda(
      "Central de Ajuda",
      "Bem-vindo à Central de Ajuda! Aqui você encontra respotas rápidas para dúvidas comuns, tutorias e orientações sobre como usar o nosso aplicativo.\n\n "
          "     Perguntas Frequentes(FAQ): consulte soluções para o principal desafios.\nTutorias: Aprenda a usar funcionalidades com o passo a passo simples.\n\nContato: Precisou de ajuda personalizada? Fale conosco via Email(projetoflask100@gmail.com), chat ou telefone (Horário comercial).\n\n"
          "Não encontrou o que procurava? Use a barra de Pesquisa do Google. Não estamos para simplificar sua experiência!",
    );
  }

  void _mostrarTextoAnuncio() {
    _mostrarDialogAjuda(
      "Versão Sem Anúncio",
      "Desfrute de uma experiência livre de interrupções com a versão sem anúncios do Lixo Ele!\n\n "
          "     Navegação fluida: Aproveite o app sem pausas ou distrações.\n\nVelocidade máxima: Carregamento mais rápido e desempenho otimizado\n\nApenas o essencial: Foco total no que realmente importa para você.\n\n"
          "Como adquirir:\nAcesse Configurações > Assinaturas ou visite nossa loja de apps. Escolha entre assinatura mensal/anual ou compra única, conforme disponível.",
    );
  }

  void _mostrarTextoDivulgue() {
    _mostrarDialogAjuda(
      "Divulgue",
      "Sabe de algum ponto de coleta que não esteja sinalizado no nosso aplicativo.\n\nEntre em contato clicando aqui para nos ajudar a divulgar esse novo ponto.",
    );
  }

  void _mostrarTextoNotificacao() {
    _mostrarDialogAjuda(
      "Central de Notificações",
      "Mantenha-se informado(a) e no controle! Aqui você gerencia quais alertas receber, personaliza preferências e garante que só o que é relevante chegue até você.",
    );
  }

  void _mostrarTextoAvaliar() {
    _mostrarDialogAjuda(
      "Avaliação",
      "Nem precisa, nos dois sabemos que somos o melhor em ser nos mesmos.\n\n"
          "⭐⭐⭐⭐⭐",
    );
  }

  void _mostrarTextoSuporte() {
    _mostrarDialogAjuda(
      "Suporte",
      "Precisando de ajuda? Estamos aqui para resolver qualquer desafio, dúvida ou sugestão que você tenha!\n\nComo nos contatar:\n"
          "E-mail: Envie detalhes para [suporte@nomedoapp.com] e respondemos em até 24h.\nChat online: Disponível no app em horário comercial (seg-sex, 8h às 18h).\nTelefone: [21 4002-8922] (seg-sex, 6h às 12h).",
    );
  }

  void _onMenuSelected(String opcao) {
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
      case 'divulger':
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
      case 'locais':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocaisScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    isColorMode
                        ? 'assets/images/fundobinario.gif'
                        : 'assets/images/binarios.gif',
                  ),
                  fit: BoxFit.cover,
                ),
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
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.menu),
                        onSelected: _onMenuSelected,
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: 'central_ajuda',
                              child: Text('Central de ajuda'),
                            ),
                            const PopupMenuItem(
                              value: 'versao_sem_anuncio',
                              child: Text('Versão sem anúncio'),
                            ),
                            const PopupMenuItem(
                              value: 'central_notificacoes',
                              child: Text('Central de notificações'),
                            ),
                            const PopupMenuItem(
                              value: 'divulger',
                              child: Text('Divulger'),
                            ),
                            const PopupMenuItem(
                              value: 'avalie_nos',
                              child: Text('Avalie-nos'),
                            ),
                            const PopupMenuItem(
                              value: 'configuracoes',
                              child: Text('Configurações'),
                            ),
                            const PopupMenuItem(
                              value: 'suporte',
                              child: Text('Suporte'),
                            ),
                            const PopupMenuItem(
                              value: 'locais',
                              child: Text('Venha conhecer os Locais de coleta'),
                            ),
                          ];
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Busca',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Text("B&W"),
                          Switch(
                            value: isColorMode,
                            onChanged: (bool value) {
                              setState(() {
                                isColorMode = value;
                              });
                            },
                          ),
                          const Text("Color"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Nome do Aplicativo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuButton(
                      label: 'Lixo Digital ≠ Lixo Eletronico',
                      popupText:
                          'LIXO ELETRÔNICO\nÉ o lixo físico, também conhecido como e-lixo. São as peças de computador como teclado, placas e monitor. Celular e tablet quebradas, assim como notebooks, também são lixos eletrônicos.\n\nLIXO DIGITAL\nSão os dados (conteúdo virtual) que deixaram de ser úteis ou não queremos mais, como e-mails, fotos, arquivos ou aquele joguinho que deletamos do celular.',
                    ),
                    MenuButton(
                      label: 'A importância do Descarte no Local Correto',
                      popupText:
                          'O descarte adequado do lixo eletrônico é essencial para proteger o planeta, garantir saúde pública e promover sustentabilidade. Pequenas ações individuais, somadas a políticas públicas e responsabilidade corporativa, podem transformar esse desafio em uma oportunidade para um futuro mais equilibrado.',
                    ),
                    MenuButton(
                      label: 'Conheça o Projeto',
                      popupText: 'Aqui vai o texto para Comunica Positivo',
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
