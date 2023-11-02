import 'dart:convert';

import 'package:about_bloc_first/bloc/bloc_actions.dart';
import 'package:about_bloc_first/bloc/person.dart';
import 'package:about_bloc_first/bloc/person_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
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
      home: BlocProvider(
        create: (_) => PersonBloc(),
        child: const HomePage(),
      ),
    );
  }
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

Future<Iterable<Person>> getPersons(String url) => http
        .get(Uri.parse(url))
        .then((res) => res.body)
        .then((str) => json.decode(str) as List<dynamic>)
        .then((value) => value.map((e) => Person.fromJson(e)))
        .catchError((e) {
      print(e);
      throw Exception(e);
    });

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<PersonBloc>().add(const LoadPersonsAction(
                      url: personOneUrl, loader: getPersons));
                },
                child: const Text('Get Data One'),
              ),
              TextButton(
                onPressed: () {
                  context.read<PersonBloc>().add(const LoadPersonsAction(
                      url: personTwoUrl, loader: getPersons));
                },
                child: const Text('Get Data Two'),
              ),
            ],
          ),
          BlocBuilder<PersonBloc, FetchResult?>(
            buildWhen: (previous, current) {
              return previous?.persons != current?.persons;
            },
            builder: (context, state) {
              final persons = state?.persons;

              if (persons == null) {
                return const SizedBox();
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  final person = persons[index]!;
                  return ListTile(
                    title: Text(person.name),
                    subtitle: Text(person.description),
                    trailing:
                        Image.network(person.imageUrl, fit: BoxFit.scaleDown),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
