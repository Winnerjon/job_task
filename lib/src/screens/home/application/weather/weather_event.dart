import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class WeatherSearchEvent extends WeatherEvent {
  final String text;

  const WeatherSearchEvent({required this.text});
}

class WeatherSearchLocationEvent extends WeatherEvent {}