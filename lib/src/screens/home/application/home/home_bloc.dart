import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeAddCountEvent>(_addCount);
    on<HomeSubtractionCountEvent>(_subtractionCount);
  }

  bool isSubtraction = false;
  bool isAdd = true;
  int _counter = 0;

  /// count increment and decriment function
  int _increment(bool isDark) {
    if(isDark) {
      return 2;
    }else{
      return 1;
    }
  }

  /// check limit counter function
  void _changeCount() {
    if(_counter == 0) {
      isSubtraction = false;
      isAdd = true;
    }else if(_counter == 10){
      isSubtraction = true;
      isAdd = false;
    }else{
      isSubtraction = true;
      isAdd = true;
    }
  }

  /// add count function
  void _addCount(HomeAddCountEvent event, Emitter<HomeState> emit) {
    emit(HomeInitial());
    int count = _increment(event.isDark);

    if(_counter > -1 && _counter + count < 11) {
      _counter = _counter + count;
      _changeCount();
    }else if(_counter + count == 11) {
      _counter = 10;
      _changeCount();
    }
    emit(HomeSuccess(counter: _counter, isAdd: isAdd, isSubtraction: isSubtraction));
  }

  /// subtraction count function
  void _subtractionCount(HomeSubtractionCountEvent event, Emitter<HomeState> emit) {
    emit(HomeInitial());
    int count = _increment(event.isDark);

    if(_counter - count > -1 && _counter < 11) {
      _counter = _counter - count;
      _changeCount();
    }else if(_counter - count == -1){
      _counter = 0;
      _changeCount();
    }
    emit(HomeSuccess(counter: _counter, isAdd: isAdd, isSubtraction: isSubtraction));
  }
}
