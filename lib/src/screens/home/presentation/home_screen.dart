import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/animations/theme_animation.dart';
import '../../../common/providers/theme_vm.dart';
import '../application/home/home_bloc.dart';
import '../application/home/home_event.dart';
import '../application/home/home_state.dart';
import '../application/weather/weather_bloc.dart';
import '../application/weather/weather_event.dart';
import 'widget/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void changeTheme() {
    Provider.of<ThemeVM>(context, listen: false).switchTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeVM>(
      builder: (context, provider, child) {
        return ThemeAnimation(
          isDark: provider.isDark,
          offset: Offset(40, MediaQuery.of(context).size.height - 40),
          childBuilder: (context, index) {
            return BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                  appBar: AppBar(
                    centerTitle: true,
                    title: const Text("Weather Counter"),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 100,
                        ),

                        /// Weather ui view
                        const WeatherView(),

                        /// increment and decriment ui view
                        const Text(
                          'You have pushed the button this many times:',
                        ),
                        Text(
                          "${state is HomeSuccess ? state.counter : "0"}",
                          style: const TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: Container(
                    height: 150,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// left buttons ui view
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Weather button ui view
                            FloatingActionButton(
                              onPressed: () {
                                context.read<WeatherBloc>().add(WeatherSearchLocationEvent());
                              },
                              child: const Icon(Icons.cloud),
                            ),

                            /// Theme button ui view
                            FloatingActionButton(
                              onPressed: changeTheme,
                              child: const Icon(Icons.palette),
                            ),
                          ],
                        ),

                        /// free space ui view
                        const Expanded(child: SizedBox.shrink()),

                        /// right buttons ui view
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// increment button ui view
                            if (state is HomeSuccess ? state.isAdd : true)
                              FloatingActionButton(
                                onPressed: () {
                                  context.read<HomeBloc>().add(
                                      HomeAddCountEvent(
                                          isDark: provider.isDark));
                                },
                                child: const Text(
                                  "+",
                                  style: TextStyle(fontSize: 30),
                                ),
                              )
                            else
                              const SizedBox.shrink(),

                            /// decriment button ui view
                            if (state is HomeSuccess
                                ? state.isSubtraction
                                : false)
                              FloatingActionButton(
                                onPressed: () {
                                  context.read<HomeBloc>().add(
                                      HomeSubtractionCountEvent(
                                          isDark: provider.isDark));
                                },
                                child: const Text(
                                  "-",
                                  style: TextStyle(fontSize: 30),
                                ),
                              )
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
