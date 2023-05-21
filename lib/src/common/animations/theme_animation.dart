import 'dart:math';

import 'package:flutter/material.dart';

import '../styles/theme.dart';

class ThemeAnimation extends StatefulWidget {
  const ThemeAnimation(
      {required this.childBuilder,
      Key? key,
      this.offset = Offset.zero,
      this.themeController,
      this.radius,
      this.duration = const Duration(milliseconds: 500),
      this.isDark = false})
      : super(key: key);

  /// Deinfe the widget that will be transitioned
  /// int index is either 1 or 2 to identify widgets, 2 is the top widget
  final Widget Function(BuildContext, int) childBuilder;

  /// the current state of the theme
  final bool isDark;

  /// optional animation controller to controll the animation
  final AnimationController? themeController;

  /// centeral point of the circular transition
  final Offset offset;

  /// optional radius of the circle defaults to [max(height,width)*1.5])
  final double? radius;

  /// duration of animation defaults to 500ms
  final Duration? duration;

  @override
  State<ThemeAnimation> createState() => ThemeAnimationState();
}

class ThemeAnimationState extends State<ThemeAnimation>
    with SingleTickerProviderStateMixin {
  final _darkNotifier = ValueNotifier<bool>(false);
  late AnimationController _animationController;
  double x = 0;
  double y = 0;
  bool isDark = false;
  bool isDarkVisible = false;
  late double radius;
  Offset position = Offset.zero;

  @override
  void initState() {
    super.initState();
    if (widget.themeController == null) {
      _animationController =
          AnimationController(vsync: this, duration: widget.duration);
    } else {
      _animationController = widget.themeController!;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateRadius();
  }

  @override
  void didUpdateWidget(ThemeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _darkNotifier.value = widget.isDark;
    if (widget.isDark != oldWidget.isDark) {
      if (isDark) {
        _animationController.reverse();
        _darkNotifier.value = false;
      } else {
        _animationController.reset();
        _animationController.forward();
        _darkNotifier.value = true;
      }
      position = widget.offset;
    }
    if (widget.radius != oldWidget.radius) {
      _updateRadius();
    }
    if (widget.duration != oldWidget.duration) {
      _animationController.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _darkNotifier.dispose();
    super.dispose();
  }

  void _updateRadius() {
    final size = MediaQuery.of(context).size;
    if (widget.radius == null) {
      radius = _radius(size);
    } else {
      radius = widget.radius!;
    }
  }

  double _radius(Size size) {
    final maxVal = max(size.width, size.height);
    return maxVal * 1.5;
  }

  ThemeData getTheme(bool dark) {
    if (dark) {
      return AppTheme.dark();
    } else {
      return AppTheme.light();
    }
  }

  @override
  Widget build(BuildContext context) {
    isDark = _darkNotifier.value;
    Widget body(int index) {
      return ValueListenableBuilder<bool>(
        valueListenable: _darkNotifier,
        builder: (BuildContext context, bool isDark, Widget? child) {
          return Theme(
            data: index == 2 ? getTheme(!isDarkVisible) : getTheme(isDarkVisible),
            child: widget.childBuilder(context, index),
          );
        },
      );
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            body(1),
            ClipPath(
              clipper: CircularClipper(_animationController.value * radius, position),
              child: body(2),
            ),
          ],
        );
      },
    );
  }
}

class CircularClipper extends CustomClipper<Path> {
  const CircularClipper(this.radius, this.offset);

  final double radius;
  final Offset offset;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.addOval(Rect.fromCircle(radius: radius, center: offset));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
