part of 'clime_bloc.dart';

class ClimeState extends Equatable {
  final List<PredictionResponse> climePredictions;
  final List<ClimateResponse> clime;
  final List<int> humidity;
  final List<int> clouds;
  final bool rain;
  final List<double> temperature;
  List<Map<dynamic, dynamic>> temperatureData = [];
  List<Map<dynamic, dynamic>> humidityData = [];
  List<Map<dynamic, dynamic>> cloudsData = [];
  List<Map<dynamic, dynamic>> graphic = [];
  List<Map<dynamic, dynamic>> graphicPoligon = [];

  ClimeState(
      {this.clime = const [],
      this.climePredictions = const [],
      this.clouds = const [],
      this.humidity = const [],
      this.temperature = const [],
      this.cloudsData = const [],
      this.humidityData = const [],
      this.temperatureData = const [],
      this.graphic = const [],
      this.graphicPoligon = const [],
      this.rain = false});

  ClimeState copyWith(
          {List<ClimateResponse>? clime,
          List<PredictionResponse>? climePredictions,
          List<int>? clouds,
          bool? rain,
          List<int>? humidity,
          List<double>? temperature,
          List<Map<dynamic, dynamic>>? temperatureData,
          List<Map<dynamic, dynamic>>? humidityData,
          List<Map<dynamic, dynamic>>? cloudsData,
          List<Map<dynamic, dynamic>>? graphic,
          List<Map<dynamic, dynamic>>? graphicPoligon}) =>
      ClimeState(
        clime: clime ?? this.clime,
        climePredictions: climePredictions ?? this.climePredictions,
        clouds: clouds ?? this.clouds,
        humidity: humidity ?? this.humidity,
        temperature: temperature ?? this.temperature,
        cloudsData: cloudsData ?? this.cloudsData,
        humidityData: humidityData ?? this.humidityData,
        temperatureData: temperatureData ?? this.temperatureData,
        graphic: graphic ?? this.graphic,
        graphicPoligon: graphicPoligon ?? this.graphicPoligon,
        rain: rain ?? this.rain,
      );

  @override
  List<Object> get props => [
        clime,
        climePredictions,
        humidity,
        temperature,
        clouds,
        cloudsData,
        humidityData,
        temperatureData,
        graphicPoligon,
        graphic,
        rain
      ];
}
