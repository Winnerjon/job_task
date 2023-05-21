import 'package:equatable/equatable.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final String region;
  final double tempC;
  final double tempF;

  const WeatherSuccess(
      {required this.region,
        required this.tempC,
        required this.tempF});
}

class WeatherError extends WeatherState {
  final String error;
  const WeatherError({required this.error});
}
