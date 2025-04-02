import 'package:flutter/material.dart';
import '../widgets/menu_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // false: modo preto e branco, true: modo colorido
  bool isColorMode = false;

  // Função para tratar as ações do menu (PopupMenuButton)
  void _onMenuSelected(String opcao) {
    switch (opcao) {
      case 'central_ajuda':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Central de ajuda')));
        break;
      case 'versao_sem_anuncio':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Versão sem anúncio')));
        break;
      case 'central_notificacoes':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Central de notificações')),
        );
        break;
      case 'divulger':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Divulger')));
        break;
      case 'avalie_nos':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Avalie-nos')));
        break;
      case 'configuracoes':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Configurações')));
        break;
      case 'suporte':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Suporte')));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Imagem de fundo que muda conforme o modo
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
            // Conteúdo do aplicativo
            Column(
              children: [
                // Barra superior personalizada
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      // Menu de opções (PopupMenuButton)
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
                          ];
                        },
                      ),
                      const SizedBox(width: 8),
                      // Barra de busca
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
                      // Switch para alternar entre modos
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
                // Título principal
                const Text(
                  'Nome do Aplicativo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                // Botões com popups (usando widget customizado)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuButton(
                      label: 'Lixo Digital ≠ Lixo Eletronico',
                      popupText:
                          'LIXO ELETRÔNICO\nÉ o lixo físico, também conhecido como e-lixo. São as peças de computador como teclado, placas e monitor. Celular e tablet quebradas, assim como notebooks, também são lixos eletrônicos.\n\nLIXO DIGITAL\nSão os dados (conteúdo virtual) que deixaram de ser úteis ou não queremos mais, como e-mails, fotos, arquivos ou aquele joguinho que deletamos do celular.',
                    ),
                    MenuButton(
                      label: 'A importancia Do Descarte No Local Correto',
                      popupText: 'Aqui vai o texto para Inteligência Coletiva',
                    ),
                    MenuButton(
                      label: 'Conheça O Projeto',
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
