import 'package:about_bloc_image_load/bloc/app_state.dart';
import 'package:about_bloc_image_load/bloc/bloc_event.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef AppBlocRandomUrlPicker = String Function(Iterable<String> sllUrls);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  AppBloc({
    AppBlocRandomUrlPicker? urlPicker,
    Duration? waitBeforeLoading,
    required Iterable<String> urls,
  }) : super(
          const AppState.empty(),
        ) {
    on<LoadNextUrlEvent>((event, emit) async {
      emit(
        const AppState(isLoading: true, data: null, error: null),
      );

      final url = (urlPicker ?? _pickRandomUrl)(urls);

      try {
        if (waitBeforeLoading != null) {
          await Future.delayed(waitBeforeLoading);
        }

        emit(AppState(isLoading: false, data: url, error: null));
      } catch (e) {
        print(e);
        emit(AppState(isLoading: false, data: null, error: e));
      }
    });
  }
}
