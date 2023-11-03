import 'package:about_bloc_image_load/bloc/app_bloc.dart';
import 'package:about_bloc_image_load/bloc/bottom_bloc.dart';
import 'package:about_bloc_image_load/bloc/top_bloc.dart';
import 'package:about_bloc_image_load/models/constants.dart';
import 'package:about_bloc_image_load/views/app_bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopBloc>(
              create: (_) => TopBloc(
                urls: images,
                waitBeforeLoading: const Duration(
                  seconds: 0,
                ),
              ),
            ),
            BlocProvider(
              create: (_) => BottomBloc(
                urls: images,
                waitBeforeLoading: const Duration(
                  seconds: 0,
                ),
              ),
            ),
            BlocProvider(
              create: (_) => AppBloc(
                urls: [],
                urlPicker: (_) =>
                    'https://source.unsplash.com/random/500x500?sig=1',
                waitBeforeLoading: const Duration(seconds: 2),
              ),
            ),
          ],
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: AppBlocView<TopBloc>()),
              Expanded(child: AppBlocView<AppBloc>()),
            ],
          ),
        ),
      ),
    );
  }
}
