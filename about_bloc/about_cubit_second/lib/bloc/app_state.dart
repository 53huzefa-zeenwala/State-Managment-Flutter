import 'package:about_cubit_pac/models/login_handle.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppState {
  final bool isLoading;
  final LoginError? loginError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const AppState.empty()
      : fetchedNotes = null,
        isLoading = false,
        loginError = null,
        loginHandle = null;

  const AppState({
    required this.isLoading,
    required this.loginError,
    required this.loginHandle,
    required this.fetchedNotes,
  });
}
