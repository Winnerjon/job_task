import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../models/weather.dart';
import '../../../../services/weather_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherSearchEvent>(_searchAddressWeather);
    on<WeatherSearchLocationEvent>(_searchCurrentLocationWeather);
  }

  WeatherService weatherService = WeatherService();

  /// Search data function
  _searchAddressWeather(WeatherSearchEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      String? res = await weatherService.getWeatherData(event.text);
      if (res != null) {
        Weather weather = Weather.fromJson(jsonDecode(res));
        emit(WeatherSuccess(
            region: weather.location?.region ?? "",
            tempC: weather.current?.tempC ?? 0,
            tempF: weather.current?.tempF ?? 0));
      } else {
        emit(const WeatherError(error: "Bunday joy yo'q"));
      }
    } catch (e) {
      emit(const WeatherError(error: "Internet bilan bog'liq xatolik"));
    }
  }

  /// Get current location function
  Future<Position?> getLocation() async {
    bool serviceEnabled;

    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  _searchCurrentLocationWeather(WeatherSearchLocationEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    Position? pos = await getLocation();
    try {
      String place = "${pos!.latitude},${pos.longitude}";
      String? res = await weatherService.getWeatherData(place);
      if (res != null) {
        Weather weather = Weather.fromJson(jsonDecode(res));
        emit(WeatherSuccess(
            region: weather.location?.region ?? "",
            tempC: weather.current?.tempC ?? 0,
            tempF: weather.current?.tempF ?? 0));
      } else {
        emit(const WeatherError(error: "Bunday joy yo'q"));
      }
    } catch (e) {
      emit(const WeatherError(error: "Internet bilan bog'liq xatolik"));
    }
  }
}
