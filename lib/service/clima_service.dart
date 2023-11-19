import 'dart:convert';

import 'package:clima/model/clima_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ClimaSevice {
  static const BASE_URL = 'http://82.196.7.246/data/2.5/weather';

  final String apiKey;

  ClimaSevice(this.apiKey);

  Future<ClimaModel> getClima(String nomeCidade) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$nomeCidade&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return ClimaModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar');
    }
  }

  Future<String> getCidade() async{
    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? cidade = placemark[0].locality;

    return cidade ?? "";
  }
}