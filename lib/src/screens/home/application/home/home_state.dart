import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final bool isAdd;
  final bool isSubtraction;
  final int counter;

  const HomeSuccess(
      {required this.counter,
      required this.isAdd,
      required this.isSubtraction});
}
