class ClimaModel {
  final String nomeCidade;
  final double temperatura;
  final String condicaoAtual;

  ClimaModel({
    required this.nomeCidade,
    required this.temperatura,
    required this.condicaoAtual
  });

  factory ClimaModel.fromJson(Map<String, dynamic> json){
    return ClimaModel(
      nomeCidade: json['name'], 
      temperatura: json['main']['temp'].toDouble(), 
      condicaoAtual: json['weather'][0]['main'],
      );
  }

}