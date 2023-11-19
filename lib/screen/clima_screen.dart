import 'package:clima/model/clima_model.dart';
import 'package:clima/service/clima_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ClimaScreen extends StatefulWidget {
  const ClimaScreen({super.key});

  @override
  State<ClimaScreen> createState() => _ClimaScreenState();
}

class _ClimaScreenState extends State<ClimaScreen> {
  final _climaService = ClimaSevice('ce6bd2a02d2979f0ca5941d7a2a75fce');
  ClimaModel? _clima;

  _feachClima() async {
    String nomeCidade = await _climaService.getCidade();

    try {
      final clima = await _climaService.getClima(nomeCidade);
      setState(() {
        _clima = clima;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _feachClima();
  }

  String getAnimacao(String? condicaoAtual) {
    if (condicaoAtual == null) return 'assets/sol.json';

    switch (condicaoAtual.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/nuvem.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/chuva com trovoada.json';
      case 'thunderstorm':
        return 'assets/nuvem trovoada.json';
      case 'clear':
        return 'assets/sol.json';
      default:
        return 'assets/sol.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
              Icon(CupertinoIcons.location_solid, color: Colors.grey),
              Text(
                _clima?.nomeCidade ?? "carregando cidade...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey),
              ),
                ],
              ),
              Lottie.asset(getAnimacao(_clima?.condicaoAtual ?? "")),
              Column(
                children: [
              Text(
                '${_clima?.temperatura.round()}ºC',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(_clima?.condicaoAtual ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
