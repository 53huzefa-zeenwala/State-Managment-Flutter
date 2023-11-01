import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:bloc/bloc.dart';
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

const names = [
  "Foo",
  "Bar",
  "Baz",
  "know",
  "what",
  "state",
  "our",
  "application",
  "is",
  "in",
  "at any",
  "point",
  "in time",
];

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomNames() => emit(names.getRandomElement());
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NamesCubit cubit;

  @override
  void initState() {
    cubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home Page"),
      ),
      body: StreamBuilder<String?>(
          stream: cubit.stream,
          builder: (context, snapshot) {
            final button = TextButton(
              onPressed: () {
                cubit.pickRandomNames();
              },
              child: Text("Get Random"),
            );
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return Column(
                  children: [
                    Text(snapshot.data ?? ''),
                    button,
                  ],
                );
              case ConnectionState.done:
                return const SizedBox();
              case ConnectionState.none:
                return button;
              case ConnectionState.waiting:
                return button;
              default:
                return button;
            }
          }),
    );
  }
}
