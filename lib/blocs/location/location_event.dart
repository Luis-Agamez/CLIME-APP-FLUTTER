part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class SetCurrentPositionEvent extends LocationEvent {
  final String ltd;
  final String lgd;
  const SetCurrentPositionEvent(this.ltd, this.lgd);
}
