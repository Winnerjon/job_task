import 'package:http/http.dart' as http;

class WeatherService {
  Future<String?> getWeatherData(String place) async {
    try {
      final queryParameters = {
        'key': 'cd356fcf74754fe9963110902232105',
        'q': place,
      };
      final uri = Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);
      final response = await http.get(uri);
      if(response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch(e) {
      return null;
    }
  }
}