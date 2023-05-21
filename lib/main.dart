import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'src/common/providers/theme_vm.dart';
import 'src/common/styles/theme.dart';
import 'src/screens/home/application/home/home_bloc.dart';
import 'src/screens/home/application/weather/weather_bloc.dart';
import 'src/screens/home/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => WeatherBloc()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeVM(),
        child: Consumer<ThemeVM>(
          builder: (context, provider, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: provider.isDark ? AppTheme.dark() : AppTheme.light(),
              home: const HomeScreen(),
            );
          }
        ),
      ),
    );
  }
}

