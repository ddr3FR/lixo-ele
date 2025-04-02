import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjetoScreen extends StatelessWidget {
  const ProjetoScreen({Key? key}) : super(key: key);

  // Função para abrir URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível abrir: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projeto')),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 300.0,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: [
            _buildCarouselItem(
              'https://drive.google.com/uc?export=view&id=17lXA6WENkyyk2tw2HVcuuWpENPugPLkf',
              'seila',
              'https://maps.app.goo.gl/HEQuyUDrSkQZdqdr9',
            ),
            _buildCarouselItem(
              'https://via.placeholder.com/400', // Substitua por um link direto da imagem
              '1397 Marcello Dr',
              'https://maps.google.com/?cid=4732658222675937189',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem(String imageUrl, String title, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Column(
        children: [
          Image.network(imageUrl, height: 200, width: 300, fit: BoxFit.cover),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
