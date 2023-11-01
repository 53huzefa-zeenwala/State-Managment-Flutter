import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

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

const apiUrl = "http://127.0.0.1:5501/api/people.json";

@immutable
class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;

  @override
  String toString() => "$name $age";
}

Future<Iterable<Person>> getPerson() => http
    .get(Uri.http(apiUrl))
    .then((resp) => resp.body)
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

// HttpClient()
//     .getUrl(Uri.parse(apiUrl)))
//     .then((req) => req.close())
//     .then((resp) => resp.transform(utf8.decoder).join())
//     .then((str) => json.decode(str) as List<dynamic>)
//     .then((list) => list.map((e) => Person.fromJson(e))

@immutable
abstract class Action {
  const Action();
}

@immutable
class LoadPeopleAction extends Action {
  const LoadPeopleAction();
}

@immutable
class SuccessfullyFetchedPeopleAction extends Action {
  final Iterable<Person> persons;
  const SuccessfullyFetchedPeopleAction({required this.persons});
}

@immutable
class FailedToFetchPeopleAction extends Action {
  final Object error;
  const FailedToFetchPeopleAction({required this.error});
}

@immutable
class State {
  final bool isLoading;
  final Iterable<Person>? fetchPersons;
  final Object? error;

  const State(
      {required this.isLoading,
      required this.fetchPersons,
      required this.error});

  const State.empty()
      : isLoading = false,
        fetchPersons = null,
        error = null;
}

State reducer(State oldState, action) {
  if (action is LoadPeopleAction) {
    return const State(isLoading: true, fetchPersons: null, error: null);
  } else if (action is SuccessfullyFetchedPeopleAction) {
    return State(
      error: null,
      fetchPersons: action.persons,
      isLoading: false,
    );
  } else if (action is FailedToFetchPeopleAction) {
    return State(
        isLoading: false,
        fetchPersons: oldState.fetchPersons,
        error: action.error);
  }

  return oldState;
}

void loadPeopleMiddleware(Store<State> store, action, NextDispatcher next) {
  if (action is LoadPeopleAction) {
    getPerson().then((persons) {
      store.dispatch(SuccessfullyFetchedPeopleAction(persons: persons));
    }).catchError((e) {
      store.dispatch(FailedToFetchPeopleAction(error: e));
    });
  }
  next(action);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Store(
      reducer,
      initialState: const State.empty(),
      middleware: [loadPeopleMiddleware],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: StoreProvider(
        store: store,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                store.dispatch(const LoadPeopleAction());
              },
              child: const Text("Load Persons"),
            ),
            StoreConnector<State, bool>(
                converter: (store) => store.state.isLoading,
                builder: (context, isLoading) {
                  if (isLoading) {
                    return const CircularProgressIndicator();
                  }

                  return SizedBox();
                }),
            StoreConnector<State, Iterable<Person>?>(
                converter: (store) => store.state.fetchPersons,
                builder: (context, people) {
                  if (people == null) {
                    return const SizedBox();
                  }

                  return Expanded(
                      child: ListView.builder(
                    itemCount: people.length,
                    itemBuilder: (context, index) {
                      final person = people.elementAt(index);

                      return ListTile(
                        title: Text(person.name),
                        subtitle: Text("${person.age} year old"),
                      );
                    },
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
