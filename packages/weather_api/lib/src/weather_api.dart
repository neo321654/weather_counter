import 'package:dio/dio.dart';
import 'package:location/location.dart';

//todo выделить в отдельный сервис
Future<LocationData?> getLocation() async {
  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  return await location.getLocation();
}

class WeatherApi {
  Future<String> getWeather() async {
    LocationData? loc = await getLocation();
    String lon, lat = '';
    if (loc != null) {
      print(loc.longitude);
      print(loc.latitude);
      lat = loc.latitude.toString();
      lon = loc.longitude.toString();
    } else {
      lat = '37.4219983';
      lon = '-122.084';
    }

    try {
      //todo спрятать апи кий

      final response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=289d79262f138bd6ebb226285fd277e3');

      print(getMaxTemp(response.data.toString()));

      if (response.statusCode == 200) {
        return getMaxTemp(response.data.toString());
      } else {
        throw Exception('Ошибка при запросе к API');
      }
    } catch (e) {
      print('Ошибка при запросе к API: $e');
      rethrow;
    }
  }
}
//todo положить в другое место
String getMaxTemp(String jsonString) {
  RegExp regex = RegExp(r'\d+\.\d+');
  String tempMaxString = jsonString.split('temp_max')[1].split(',')[0];
  String tempMax = regex.firstMatch(tempMaxString)![0]!;
  return tempMax;
}