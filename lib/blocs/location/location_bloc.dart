import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<SetCurrentPositionEvent>((event, emit) {
      emit(state.copyWith(getPosition: true, ltd: event.ltd, lgd: event.lgd));
    });
  }
  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    print('Position: ${position.latitude} ${position.longitude}');
    add(SetCurrentPositionEvent(
        '${position.latitude}', '${position.longitude}'));
  }
}
