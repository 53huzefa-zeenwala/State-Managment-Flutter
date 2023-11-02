import 'package:about_bloc_first/bloc/bloc_actions.dart';
import 'package:about_bloc_first/bloc/person.dart';
import 'package:about_bloc_first/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show immutable;

extension IsEqualIgnoringOrdering<T> on Iterable<T> {
  bool isEqualIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isReterivedFromCache;

  const FetchResult(
      {required this.persons, required this.isReterivedFromCache});

  @override
  String toString() => '$isReterivedFromCache person = $persons';

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualIgnoringOrdering(other.persons) &&
      isReterivedFromCache == other.isReterivedFromCache;

  @override
  int get hashCode => Object.hash(persons, isReterivedFromCache);
}

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};

  PersonBloc() : super(null) {
    on<LoadPersonsAction>(
      (event, emit) async {
        final url = event.url;

        if (_cache.containsKey(url)) {
          final cachedPersons = _cache[url]!;

          final result =
              FetchResult(persons: cachedPersons, isReterivedFromCache: true);

          emit(result);
        } else {
          final loader = event.loader;
          final persons = await loader(url);
          _cache[url] = persons;

          final result =
              FetchResult(persons: persons, isReterivedFromCache: false);

          emit(result);
        }
      },
    );
  }
}
