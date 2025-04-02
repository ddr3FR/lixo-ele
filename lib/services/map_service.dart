import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapService {
  static const String apiKey = 'SUA_CHAVE_DA_OPENROUTESERVICE';

  static Future<List<LatLng>> getRoute(LatLng origem, LatLng destino) async {
    final String url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${origem.longitude},${origem.latitude}&end=${destino.longitude},${destino.latitude}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coordenadas =
            data['routes'][0]['geometry']['coordinates'];
        return coordenadas.map((c) => LatLng(c[1], c[0])).toList();
      }
    } catch (e) {
      print('Erro ao buscar rota: $e');
    }
    return [];
  }
}
