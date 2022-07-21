import 'package:bloc/bloc.dart';
import 'package:clima_app/models/climate_response.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../global/enviroments.dart';
import '../../models/prediction_response.dart';
part 'clime_event.dart';
part 'clime_state.dart';

class ClimeBloc extends Bloc<ClimeEvent, ClimeState> {
  ClimeBloc() : super(ClimeState()) {
    on<SetClimeEvent>((event, emit) {
      final clime = [...state.clime, event.clime];
      emit(state.copyWith(clime: clime));
    });

    on<SetRainEvent>((event, emit) {
      emit(state.copyWith(rain: true));
    });

    on<SetClimePredictionEvent>((event, emit) {
      final climePrediction = [
        ...state.climePredictions,
        event.climePredictions
      ];
      emit(state.copyWith(climePredictions: climePrediction));
    });

    on<SetDataGraphicsEvent>((event, emit) {
      emit(state.copyWith(
          temperature: event.temperature,
          humidity: event.humidity,
          clouds: event.clouds));
    });

    on<SetMapGraphicsEvent>((event, emit) {
      emit(state.copyWith(
          temperatureData: event.temperatureData,
          humidityData: event.humidityData,
          cloudsData: event.cloudsData,
          graphic: event.graphic,
          graphicPoligon: event.graphicPoligon));
    });
  }

  void getClime(String latitude, String longitude) async {
    final uri = Uri.parse(
        '${Environment.apiUrlBase}?lat=$latitude&lon=$longitude&appid=${Environment.apiKey}&units=metric');
    if (latitude.isNotEmpty && longitude.isNotEmpty) {
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      // print(resp.body);
      if (resp.statusCode == 200) {
        final climeResponse = ClimateResponse.fromJson(resp.body);
        add(SetClimeEvent(climeResponse));
        if (climeResponse.weather[0].main == 'Rain') {
          add(SetRainEvent());
        }
      }
    }
  }

  void getClimePredictions(String latitude, String longitude) async {
    List<int> humidity = [];
    List<int> clouds = [];
    List<double> temperature = [];
    List<Map<dynamic, dynamic>> temperatureData = [];
    List<Map<dynamic, dynamic>> humidityData = [];
    List<Map<dynamic, dynamic>> cloudsData = [];
    List<Map<dynamic, dynamic>> graphic = [];
    List<Map<dynamic, dynamic>> graphicPoligon = [];

    final uri = Uri.parse(
        '${Environment.apiUrlPredictions}?lat=$latitude&lon=$longitude&appid=${Environment.apiKey}&units=metric');
    if (latitude.isNotEmpty && longitude.isNotEmpty) {
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 200) {
        final predictionResponse = PredictionResponse.fromJson(resp.body);
        final list = predictionResponse.list;
        add(SetClimePredictionEvent(predictionResponse));
        for (int i = 0; i < list.length; i++) {
          temperature.add(list[i].main.temp);
          humidity.add(list[i].main.humidity);
          clouds.add(list[i].clouds.all);

          Map tempMap = {
            'Date': list[i].dtTxt.toString(),
            'Temperature': list[i].main.temp
          };
          Map humMap = {
            'Date': list[i].dtTxt.toString(),
            'Humidity': list[i].main.humidity
          };
          Map cloudsMap = {
            'Date': list[i].dtTxt.toString(),
            'Clouds': list[i].clouds.all
          };

          Map tempMapGraphic = {
            'day': list[i]
                .dtTxt
                .toString()
                .replaceRange(0, 10, '')
                .replaceRange(5, 12, ''),
            'value': list[i].main.temp,
            'group': list[i]
                .dtTxt
                .toString()
                .replaceRange(0, 8, '')
                .replaceRange(2, 15, ''),
          };

          Map poligon = {
            "type":
                'Dia ${list[i].dtTxt.toString().replaceRange(0, 8, '').replaceRange(2, 15, '')} Temperatura',
            "index": list[i]
                .dtTxt
                .toString()
                .replaceRange(0, 10, '')
                .replaceRange(5, 12, ''),
            "value": list[i].main.temp
          };
          Map poli = {
            "type":
                'Dia ${list[i].dtTxt.toString().replaceRange(0, 8, '').replaceRange(2, 15, '')} Sensacion Termica',
            "index": list[i]
                .dtTxt
                .toString()
                .replaceRange(0, 10, '')
                .replaceRange(5, 12, ''),
            "value": list[i].main.feelsLike
          };

          temperatureData.add(tempMap);
          humidityData.add(humMap);
          cloudsData.add(cloudsMap);
          graphic.add(tempMapGraphic);

          graphicPoligon.add(poligon);
          graphicPoligon.add(poli);
        }

        // print(graphicPoligon);

        add(SetDataGraphicsEvent(humidity, clouds, temperature));
        add(SetMapGraphicsEvent(cloudsData, temperatureData, humidityData,
            graphic, graphicPoligon));
      }
    }
  }
}
