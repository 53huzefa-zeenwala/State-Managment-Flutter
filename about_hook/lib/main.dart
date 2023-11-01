import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// useStream Hook

// Stream<String> getTime() => Stream.periodic(
//     const Duration(milliseconds: 100), (_) => DateTime.now().toIso8601String());

// class MyHomePage extends HookWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dateTiem = useStream(getTime());
//     return Scaffold(
//         appBar: AppBar(
//       title: Text(dateTiem.data ?? "Home Page"),
//     ));
//   }
// }

// useState || useTextEditingController || useEffect

// class MyHomePage extends HookWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = useTextEditingController();
//     final text = useState('');
//     useEffect(
//       () {
//         print("changed");
//         controller.addListener(() {
//           text.value = controller.text;
//         });

//         return null;
//       },
//       [controller],
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: controller,
//           ),
//           Text("You Typed: ${text.value}")
//         ],
//       ),
//     );
//   }
// }

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([E? Function(T?)? transform]) =>
      map(transform ?? (e) => e).where((element) => element != null).cast();
}

// useFuture || useMemoized

// const url = 'https://bit.ly/3qYOtDm';

// class MyHomePage extends HookWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final foo = NetworkAssetBundle(Uri.parse(url))
//         .load(url)
//         .then(
//           (value) => value.buffer.asUint8List(),
//         )
//         .then(
//           (value) => Image.memory(value),
//         );

//     final snapshot = useMemoized(() => foo);
//     final image = useFuture(snapshot);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: Column(
//           children: [
//         image.hasData ? image.data! : null,
//       ].compactMap().toList()),
//     );
//   }
// }

// uswListenable

// class CountDown extends ValueNotifier<int> {
//   late StreamSubscription sub;
//   CountDown({required int from}) : super(from) {
//     sub = Stream.periodic(const Duration(seconds: 1), (v) => from - v)
//         .takeWhile((value) => value >= 0)
//         .listen((value) {
//       this.value = value;
//     });
//   }

//   @override
//   void dispose() {
//     sub.cancel();
//     super.dispose();
//   }
// }

// class MyHomePage extends HookWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final countDown = useMemoized(() => CountDown(from: 20));
//     final notifier = useListenable(countDown);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: Column(
//         children: [Text(notifier.value.toString())],
//       ),
//     );
//   }
// }

// useAnimationController

const imageUrl =
    "https://images.pexels.com/photos/443446/pexels-photo-443446.jpeg?cs=srgb&dl=daylight-forest-glossy-443446.jpg&fm=jpg";

const imageHeight = 300.0;

extension Normalization on num {
  num normalized(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0.0,
    num normalizedRangeMax = 1.0,
  ]) =>
      (normalizedRangeMax - normalizedRangeMin) *
      ((this - selfRangeMin) / (selfRangeMax - selfRangeMin) +
          normalizedRangeMin);
}

// class MyHomePage extends HookWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final opacity = useAnimationController(
//       duration: const Duration(seconds: 1),
//       initialValue: 1,
//       upperBound: 1,
//       lowerBound: 0,
//     );

//     final size = useAnimationController(
//       duration: const Duration(seconds: 1),
//       initialValue: 1,
//       upperBound: 1,
//       lowerBound: 0,
//     );

//     final controller = useScrollController();

//     useEffect(() {
//       print("called");
//       controller.addListener(() {
//         final newOpacity = max(imageHeight - controller.offset, 0.0);
//         final normalized = newOpacity.normalized(0.0, imageHeight).toDouble();
//         opacity.value = normalized;
//         size.value = normalized;
//       });
//       return null;
//     }, [controller]);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: Column(
//         children: [
//           SizeTransition(
//             sizeFactor: size,
//             axis: Axis.vertical,
//             axisAlignment: -1.0,
//             child: FadeTransition(
//               opacity: opacity,
//               child: Image.network(
//                 imageUrl,
//                 height: imageHeight,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               controller: controller,
//               shrinkWrap: true,
//               itemCount: 100,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text("Person ${index + 1}"),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// useStreamController

// class MyHomePage extends HookWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     late final StreamController<double> controller;

//     controller = useStreamController<double>(onListen: () {
//       controller.sink.add(0.0);
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: Center(
//         child: StreamBuilder<double>(
//           stream: controller.stream,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const CircularProgressIndicator();
//             }
//             final rotation = snapshot.data!;
//             return GestureDetector(
//               onTap: () {
//                 controller.sink.add(rotation + 10.0);
//               },
//               child: RotationTransition(
//                   turns: AlwaysStoppedAnimation(rotation / 360.0),
//                   child: Image.network(imageUrl)),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// useReducer

// enum Action { rotateLeft, rotateRight, moreVisible, lessVisible }

// @immutable
// class State {
//   final double rotationDeg;
//   final double alpha;

//   const State({
//     required this.rotationDeg,
//     required this.alpha,
//   });

//   const State.zero()
//       : rotationDeg = 0.0,
//         alpha = 1.0;

//   State rotateRight() => State(alpha: alpha, rotationDeg: rotationDeg + 10.0);
//   State rotateLeft() => State(alpha: alpha, rotationDeg: rotationDeg - 10.0);
//   State increaseAlpha() =>
//       State(alpha: min(alpha + 0.1, 1.0), rotationDeg: rotationDeg);
//   State decreaseAlpha() =>
//       State(alpha: max(alpha - 0.1, 0.0), rotationDeg: rotationDeg);
// }

// State reducer(State oldState, Action? action) {
//   switch (action) {
//     case Action.rotateLeft:
//       return oldState.rotateLeft();
//     case Action.rotateRight:
//       return oldState.rotateRight();
//     case Action.moreVisible:
//       return oldState.increaseAlpha();
//     case Action.lessVisible:
//       return oldState.decreaseAlpha();
//     case null:
//       return oldState;
//   }
// }

// class MyHomePage extends HookWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final store = useReducer<State, Action?>(
//       reducer,
//       initialState: const State.zero(),
//       initialAction: null,
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: Column(
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   store.dispatch(Action.rotateLeft);
//                 },
//                 child: Text("Rotate Left"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   store.dispatch(Action.rotateRight);
//                 },
//                 child: Text("Rotate Right"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   store.dispatch(Action.moreVisible);
//                 },
//                 child: Text("Increse Opacity"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   store.dispatch(Action.lessVisible);
//                 },
//                 child: Text("Decrease Opacity"),
//               ),
//             ],
//           ),
//           const SizedBox(height: 50),
//           Opacity(
//             opacity: store.state.alpha,
//             child: RotationTransition(
//                 turns: AlwaysStoppedAnimation(store.state.rotationDeg / 360.0),
//                 child: Image.network(imageUrl)),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
