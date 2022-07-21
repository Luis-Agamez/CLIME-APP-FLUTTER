part of 'clime_bloc.dart';

abstract class ClimeEvent extends Equatable {
  const ClimeEvent();

  @override
  List<Object> get props => [];
}

class SetClimeEvent extends ClimeEvent {
  final ClimateResponse clime;

  const SetClimeEvent(this.clime);
}

class SetClimePredictionEvent extends ClimeEvent {
  final PredictionResponse climePredictions;
  const SetClimePredictionEvent(this.climePredictions);
}

class SetDataGraphicsEvent extends ClimeEvent {
  final List<int> humidity;
  final List<int> clouds;
  final List<double> temperature;

  const SetDataGraphicsEvent(this.humidity, this.clouds, this.temperature);
}

// ignore: must_be_immutable
class SetMapGraphicsEvent extends ClimeEvent {
  List<Map<dynamic, dynamic>> temperatureData;
  List<Map<dynamic, dynamic>> humidityData;
  List<Map<dynamic, dynamic>> cloudsData;
  List<Map<dynamic, dynamic>> graphic;
  List<Map<dynamic, dynamic>> graphicPoligon;

  SetMapGraphicsEvent(this.cloudsData, this.temperatureData, this.humidityData,
      this.graphic, this.graphicPoligon);
}

class SetRainEvent extends ClimeEvent {}
