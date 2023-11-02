import 'package:about_bloc_first/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LoadAction {
  const LoadAction();
}

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

const personOneUrl = 'https://api.punkapi.com/v2/beers?page=1&per_page=5';
const personTwoUrl = 'https://api.punkapi.com/v2/beers?page=2&per_page=5';

@immutable
class LoadPersonsAction extends LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({required this.loader, required this.url}) : super();
}
