import 'dart:async';

import 'package:flutter/material.dart';


class ThreeScreen extends StatefulWidget {
  const ThreeScreen({Key? key}) : super(key: key);

  @override
  State<ThreeScreen> createState() => _ThreeScreenState();
}

class _ThreeScreenState extends State<ThreeScreen> {
  List<MaterialColor> colors = Colors.primaries;
  late Timer _timer;

  void adAnons() {
    _timer = Timer.periodic(const Duration(minutes: 10), (Timer t) {
    });
  }

  @override
  void initState() {
    adAnons();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}