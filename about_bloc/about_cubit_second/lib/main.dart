import 'package:about_cubit_pac/apis/login_apis.dart';
import 'package:about_cubit_pac/apis/notes_apis.dart';
import 'package:about_cubit_pac/bloc/actions.dart';
import 'package:about_cubit_pac/bloc/app_bloc.dart';
import 'package:about_cubit_pac/bloc/app_state.dart';
import 'package:about_cubit_pac/dialog/generic_dialog.dart';
import 'package:about_cubit_pac/dialog/loading_screen.dart';
import 'package:about_cubit_pac/strings.dart';
import 'package:about_cubit_pac/views/iterable_list_view.dart';
import 'package:about_cubit_pac/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bl';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(loginApi: LoginApi(), notesApi: NotesApi()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            if (appState.isLoading) {
              LoadingScreen.instance().show(context: context, text: pleaseWait);
            } else {
              LoadingScreen.instance().hide();
            }

            // display error
            final loginError = appState.loginError;
            if (loginError != null) {
              showGenericDialog(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionsBuilder: () => {ok: true},
              );
            }
            print([
              appState.isLoading,
              appState.loginError,
              appState.loginHandle,
              appState.fetchedNotes,
            ]);
            if (appState.isLoading == false &&
                appState.loginError == null &&
                appState.loginHandle != null &&
                appState.fetchedNotes == null) {
              context.read<AppBloc>().add(const LoadNotesAction());
            }
          },
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            if (notes == null) {
              return LoginView((email, password) {
                context.read<AppBloc>().add(
                      LoginAction(email: email, password: password),
                    );
              });
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
