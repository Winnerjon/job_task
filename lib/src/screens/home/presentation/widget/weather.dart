import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/weather/weather_bloc.dart';
import '../../application/weather/weather_event.dart';
import '../../application/weather/weather_state.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Column(
          children: [
            if(state is WeatherLoading)
              /// Get data loading ui view
              const CircularProgressIndicator()
            else if(state is WeatherSuccess)
              /// Success data ui view
              Column(
                children: [
                  Text(state.region),
                  Text(state.tempC.toString()),
                  Text(state.tempF.toString()),
                ],
              )
            else if(state is WeatherError)
              /// Error ui view
              Text(state.error)
            else
              /// Default ui view
              const Text("Qayerning ob-havo ma'lumotini olmoqchisiz?"),

            /// Text Field ui view
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 50, vertical: 20),
              child: TextFormField(
                textAlign: TextAlign.center,
                onFieldSubmitted: (text) {
                  if(text.isNotEmpty) {
                    context.read<WeatherBloc>().add(WeatherSearchEvent(text: text));
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
