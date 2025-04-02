import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  LatLng origem = LatLng(-23.55052, -46.633308); // Exemplo: São Paulo
  LatLng destino = LatLng(-23.564, -46.653); // Exemplo: outro ponto em SP
  List<LatLng> rota = [];

  Future<void> _buscarRota() async {
    const String apiKey = 'SUA_CHAVE_DA_OPENROUTESERVICE';
    final String url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${origem.longitude},${origem.latitude}&end=${destino.longitude},${destino.latitude}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coordenadas =
            data['routes'][0]['geometry']['coordinates'];

        setState(() {
          rota = coordenadas.map((c) => LatLng(c[1], c[0])).toList();
        });
      } else {
        print('Erro na resposta: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar rota: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _buscarRota();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mapa com Rota')),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(center: origem, zoom: 13.0),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: origem,
                child: Icon(Icons.location_on, color: Colors.red, size: 30),
              ),
              Marker(
                point: destino,
                child: Icon(Icons.flag, color: Colors.blue, size: 30),
              ),
            ],
          ),
          if (rota.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(points: rota, color: Colors.blue, strokeWidth: 4.0),
              ],
            ),
        ],
      ),
    );
  }
}
