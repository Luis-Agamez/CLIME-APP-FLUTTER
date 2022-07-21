part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool getPosition;
  final String ltd;
  final String lgd;
  const LocationState({this.getPosition = false, this.ltd = '', this.lgd = ''});

  LocationState copyWith(
          {final bool? getPosition, final String? ltd, final String? lgd}) =>
      LocationState(
          getPosition: getPosition ?? this.getPosition,
          ltd: ltd ?? this.ltd,
          lgd: lgd ?? this.lgd);

  @override
  List<Object> get props => [getPosition, ltd, lgd];
}
