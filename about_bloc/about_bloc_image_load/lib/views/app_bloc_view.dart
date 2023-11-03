import 'package:about_bloc_image_load/bloc/app_bloc.dart';
import 'package:about_bloc_image_load/bloc/app_state.dart';
import 'package:about_bloc_image_load/bloc/bloc_event.dart';
import 'package:about_bloc_image_load/extensions/stream/start_with.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({super.key});

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 10),
      (_) => const LoadNextUrlEvent(),
    ).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return BlocBuilder<T, AppState>(
      builder: (context, AppState appState) {
        if (appState.error != null) {
          return const Text('An Error occurred. Try again');
        } else if (appState.data != null) {
          return Image.network(
            appState.data!,
            fit: BoxFit.fitHeight,
          );
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      },
    );
  }
}
