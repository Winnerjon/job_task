import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/weather.dart';
import '../../../../services/weather_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherSearchEvent>(_search);
  }

  WeatherService weatherService = WeatherService();

  /// Search data function
  _search(WeatherSearchEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    String? res = await weatherService.getWeatherData(event.text);
    if(res != null) {
      Weather weather = Weather.fromJson(jsonDecode(res));
      emit(WeatherSuccess(
          region: weather.location?.region ?? "",
          tempC: weather.current?.tempC ?? 0,
          tempF: weather.current?.tempF ?? 0));
    }else {
      emit(const WeatherError(error: "Bunday joy yo'q"));
    }
  }
}
