import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  static const String _apiKey = "pk.d074964679caaa4f8b75ed81cd6b038a";
  static const String _baseUrl = "https://api.locationiq.com/v1/autocomplete";

  static Future<List<Map<String, dynamic>>> searchPlaces(String query) async {
    if (query.isEmpty) return [];
    final Uri url = Uri.parse(
      "$_baseUrl?key=$_apiKey&q=$query&format=json&countrycodes=us",
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((place) {
          final address = place["address"] ?? {};
          final city =
              address["city"] ?? address["town"] ?? address["village"] ?? "";
          final state = address["state"] ?? "";
          final display = [city, state].where((e) => e.isNotEmpty).join(", ");

          return {
            "name": display.isNotEmpty ? display : place["display_name"],
            "full_name": place["display_name"],
            "lat": place["lat"],
            "lon": place["lon"],
          };
        }).toList();
      } else {
        print("Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching places: $e");
      return [];
    }
  }
}
