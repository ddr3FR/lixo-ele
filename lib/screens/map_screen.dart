import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/local.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  final Local local; // Destino

  const MapPage({Key? key, required this.local}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  late LatLng destination;
  List<LatLng> routePoints = [];
  LatLng? currentPosition; // Posição do usuário
  bool loadingLocation = true;

  @override
  void initState() {
    super.initState();
    destination = LatLng(widget.local.latitude, widget.local.longitude);
    _determinePosition();
  }

  // Solicita a posição atual do usuário utilizando o Geolocator
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está ativado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Os serviços de localização estão desativados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissão de localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('As permissões de localização estão permanentemente negadas.');
    }

    // Obtém a posição atual
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      loadingLocation = false;
    });

    _fetchRoute();
  }

  // Busca a rota utilizando a API OSRM
  Future<void> _fetchRoute() async {
    if (currentPosition == null) return;

    final String url =
        'https://router.project-osrm.org/route/v1/driving/${currentPosition!.longitude},${currentPosition!.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=geojson';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> coords = data['routes'][0]['geometry']['coordinates'];
        setState(() {
          routePoints = coords
              .map((c) => LatLng(c[1].toDouble(), c[0].toDouble()))
              .toList();
        });
      } else {
        print('Erro ao buscar rota: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar rota: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define o centro do mapa como o ponto médio entre a posição atual e o destino
    LatLng mapCenter;
    if (currentPosition != null) {
      mapCenter = LatLng(
        (currentPosition!.latitude + destination.latitude) / 2,
        (currentPosition!.longitude + destination.longitude) / 2,
      );
    } else {
      mapCenter = destination;
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.local.nome)),
      body: loadingLocation
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(center: mapCenter, zoom: 15.0),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    // Marcador para a localização atual do usuário
                    Marker(
                      point: currentPosition!,
                      child: const Icon(Icons.my_location, color: Colors.green, size: 30),
                    ),
                    // Marcador para o destino
                    Marker(
                      point: destination,
                      child: const Icon(Icons.location_on, color: Colors.red, size: 30),
                    ),
                  ],
                ),
                // Desenha a rota, se disponível
                if (routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(points: routePoints, color: Colors.blue, strokeWidth: 4.0),
                    ],
                  ),
              ],
            ),
    );
  }
}
