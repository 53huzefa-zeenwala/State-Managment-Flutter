import 'package:about_bloc_first/bloc/bloc_actions.dart';
import 'package:about_bloc_first/bloc/person.dart';
import 'package:about_bloc_first/bloc/person_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const Iterable<Person> mockedPerson1 = [
  Person(
    name: 'jhdfbasjhdfbajs',
    description:
        'fowekfkf fsofkwe fkmfwe  f jfe fwfj wejf wefjwe f    fjsenfnefnefjknwejkf',
    imageUrl: 'fmsdlfkmsdlkmvv kvmlsdkvm k.jpg',
    tagline: 'csdjckjsdnc jkcnsjnc',
    brewersTips: 'fwefjwelkf',
    id: 1,
  ),
  Person(
    id: 2,
    name: 'Trashy Blonde',
    tagline: 'You Know You Shouldn"t',
    brewersTips: '04/2008',
    description:
        'A titillating, neurotic, peroxide punk of a Pale Ale. Combining attitude, style, substance, and a little bit of low self esteem for good measure what would your mother say? The seductive lure of the sassy passion fruit hop proves too much to resist. All that is even before we get onto the fact that there are no additives, preservatives, pasteurization or strings attached. All wrapped up with the customary BrewDog bite and imaginative twist.',
    imageUrl: 'https://images.punkapi.com/v2/2.png',
  )
];

const mockedPerson2 = [
  Person(
    id: 6,
    name: 'Electric India',
    tagline: 'Vibrant Hoppy Saison.',
    brewersTips: '05/2013',
    description:
        'Re-brewed as a spring seasonal, this beer – which appeared originally as an Equity Punk shareholder creation – retains its trademark spicy, fruity edge. A perfect blend of Belgian Saison and US IPA, crushed peppercorns and heather honey are also added to produce a genuinely unique beer.',
    imageUrl: 'https://images.punkapi.com/v2/6.png',
  ),
  Person(
    id: 7,
    name: 'AB:12',
    tagline: 'Imperial Black Belgian Ale.',
    brewersTips: '07/2012',
    description:
        'An Imperial Black Belgian Ale aged in old Invergordon Scotch whisky barrels with mountains of raspberries, tayberries and blackberries in each cask. Decadent but light and dry, this beer would make a fantastic base for ageing on pretty much any dark fruit - we used raspberries, tayberries and blackberries beause they were local.',
    imageUrl: 'https://images.punkapi.com/v2/7.png',
  )
];

Future<Iterable<Person>> mockGetPerson1(String _) =>
    Future.value(mockedPerson1);
Future<Iterable<Person>> mockGetPerson2(String _) =>
    Future.value(mockedPerson2);

void main() {
  group(
    'testing Person Bloc',
    () {
      late PersonBloc bloc;

      setUp(() {
        bloc = PersonBloc();
      });

      blocTest<PersonBloc, FetchResult?>(
        'Test Initial State',
        build: () => bloc,
        verify: (bloc) => expect(bloc.state, null),
      );

      // fetch mock data person1 and then compare it with iterable
      blocTest<PersonBloc, FetchResult?>(
        'Mock receiving person1 rom first iterable',
        build: () => bloc,
        // verify: (bloc) => bloc.state == null,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
                loader: mockGetPerson1, url: 'dummy_url_one'),
          );
          bloc.add(
            const LoadPersonsAction(
                loader: mockGetPerson1, url: 'dummy_url_one'),
          );
        },
        expect: () {
          const FetchResult(
              persons: mockedPerson1, isReterivedFromCache: false);
          const FetchResult(persons: mockedPerson1, isReterivedFromCache: true);
        },
      );
    },
  );
}
