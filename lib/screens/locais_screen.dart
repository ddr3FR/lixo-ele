import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'map_screen.dart';
import '../models/local.dart';

class LocaisScreen extends StatelessWidget {
  final List<Local> locais = [
    Local(
      nome: "UNAMA - Alcindo Cacela",
      endereco: "Av. Alcindo Cacela, 287 - Umarizal, Belém - PA",
      latitude: -1.4386125540152424,
      longitude: -48.478426946833466,
    ),
    Local(
      nome: "UNAMA - Ananindeua",
      endereco: "BR 316, km 3, S/N - Coqueiro, Ananindeua - PA",
      latitude: -1.387683897535828,
      longitude: -48.41491122042828,
    ),
    Local(
      nome: "UNAMA - Parque Shopping",
      endereco: "Unnamed Road - Parque Verde, Belém - PA",
      latitude: -1.3716186917438906,
      longitude: -48.44715350116566,
    ),
    Local(
      nome: "UNAMA - Gentil",
      endereco: "Av. Gentil Bitencourt, 745 - Nazaré, Belém - PA,",
      latitude: -1.4552811313148006,
      longitude: -48.48615954440843,
    ),
    Local(
      nome: "Descarte Corretol",
      endereco: "Travessa Barao do Triunfo, 4596 - Marco, Belem - PA",
      latitude: -1.4400903028980505,
      longitude: -48.451293400000004,
    ),
    Local(
      nome: "Recicle Certo",
      endereco: "Rua Elcione Barbalho, 72 - Tenone, Belem - PA",
      latitude: -1.3118074932793526,
      longitude: -48.44842308465784,
    ),
    Local(
      nome: "ECOPONTOS TJPA: PRÉDIO SEDE",
      endereco: "Av. Alm. Barroso, 3089 - Souza, Belém - PA",
      latitude: -1.4253102137518157,
      longitude: -48.452029261450605,
    ),
    Local(
      nome: "ECOPONTOS TJPA: FÓRUM CRIMINAL DE BELÉM ",
      endereco: "R. Tomázia Perdigão, 260, Cidade Velha, Belém - PA",
      latitude: -1.4570075922324193,
      longitude: -48.502991205603976,
    ),
    Local(
      nome: "ECOPONTOS TJPA: FÓRUM CÍVEL DE BELÉM  ",
      endereco: "Praça Felipe Patroni, Cidade Velha, Belém - PA ",
      latitude: -1.4560758388804826,
      longitude: -48.50191083261499,
    ),
    Local(
      nome: "ECOPONTOS TJPA: ESCOLA JUDICIAL",
      endereco: "Tv. Quintino Bocaiúva, 1404, Nazaré, Belem - PA",
      latitude: -1.4515266906748172,
      longitude: -48.48711651912153,
    ),
    Local(
      nome: "Parque Estadual do Utinga (entrada pelo segundo portão) ",
      endereco: "Av. Alm. Barroso, 3089 - Souza, Belém - PA",
      latitude: -1.4252600585824693,
      longitude: -48.443197003309116,
    ),
    Local(
      nome: "Ecoponto Porto Futuro ",
      endereco: "R. Belém, S/N - Reduto, Belém - PA",
      latitude: -1.443370716567982,
      longitude: -48.495131342638125,
    ),
    Local(
      nome: "Ecoponto Usipaz Cabanagem",
      endereco: "Endereço: Av. Damasco, 37 - Cabanagem, Belém - PA",
      latitude: -1.3671862997967654,
      longitude: -48.431358303131475,
    ),
    Local(
      nome: "Ecoponto Usipaz Icuí, Ananindeua  ",
      endereco: "Estr. Icuí-Guajará - Icuí-Guajará, Ananindeua - PA",
      latitude: -1.341653352975213,
      longitude: -48.406867288858656,
    ),
  ];

  Future<void> _abrirNoGoogleMaps(String nome, String endereco) async {
    final query = Uri.encodeComponent("$nome, $endereco");
    final geoUri = Uri.parse("geo:0,0?q=$query");

    if (await canLaunchUrl(geoUri)) {
      await launchUrl(geoUri, mode: LaunchMode.externalApplication);
    } else {
      final webUri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$query",
      );
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      } else {
        print("Não foi possível abrir o Google Maps.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Locais")),
      body: ListView.builder(
        itemCount: locais.length,
        itemBuilder: (context, index) {
          final local = locais[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(local.nome),
              subtitle: Text(local.endereco),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.map),
                    tooltip: "Abrir no app",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(local: local),
                        ),
                      );
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.directions),
                    tooltip: "Abrir no Google Maps",
                    onPressed: () {
                      _abrirNoGoogleMaps(local.nome, local.endereco);
                    },
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
