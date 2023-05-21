import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInitEvent extends HomeEvent {}

class HomeCountEvent extends HomeEvent {
  final bool isAdd;
  const HomeCountEvent({required this.isAdd});
}

class HomeAddCountEvent extends HomeEvent {
  final bool isDark;
  const HomeAddCountEvent({required this.isDark});
}

class HomeSubtractionCountEvent extends HomeEvent {
  final bool isDark;
  const HomeSubtractionCountEvent({required this.isDark});
}