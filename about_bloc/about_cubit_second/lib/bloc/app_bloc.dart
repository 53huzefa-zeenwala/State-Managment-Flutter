import 'package:about_cubit_pac/apis/login_apis.dart';
import 'package:about_cubit_pac/apis/notes_apis.dart';
import 'package:about_cubit_pac/bloc/actions.dart';
import 'package:about_cubit_pac/bloc/app_state.dart';
import 'package:about_cubit_pac/models/login_handle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>(
      (event, emit) async {
        emit(
          const AppState(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            fetchedNotes: null,
          ),
        );

        final loginHandle =
            await loginApi.login(email: event.email, password: event.password);

        emit(
          AppState(
            isLoading: false,
            loginError: loginHandle == null ? LoginError.invalidHandle : null,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      },
    );

    on<LoadNotesAction>(
      (event, emit) async {
        emit(
          AppState(
            isLoading: true,
            loginError: null,
            loginHandle: state.loginHandle,
            fetchedNotes: null,
          ),
        );

        final loginHandle = state.loginHandle;

        if (loginHandle != const LoginHandle.fooBar()) {
          emit(
            AppState(
              isLoading: false,
              loginError: LoginError.invalidHandle,
              loginHandle: loginHandle,
              fetchedNotes: null,
            ),
          );
          return;
        }

        final notes = await notesApi.getNotes(loginHandle: loginHandle!);

        emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: loginHandle,
            fetchedNotes: notes,
          ),
        );
      },
    );
  }
}
