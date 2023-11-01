import 'package:flutter/material.dart';
import 'dart:math' show Random;
import 'dart:developer' as devtools show log;

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
  var _color1 = Colors.yellow.shade400;
  var _color2 = Colors.blue.shade400;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: AvailableColorsWidget(
        color1: _color1,
        color2: _color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _color1 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change color 1'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _color2 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change color 2'),
                ),
              ],
            ),
            const ColorWidget(color: AvailableColors.one),
            const ColorWidget(color: AvailableColors.two),
          ],
        ),
      ),
    );
  }
}

enum AvailableColors { one, two }

class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  final Color color1;
  final Color color2;

  const AvailableColorsWidget(
      {Key? key,
      required this.color1,
      required this.color2,
      required Widget child})
      : super(child: child, key: key);

  static AvailableColorsWidget of(
    BuildContext context,
    AvailableColors aspect,
  ) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(
      context,
      aspect: aspect,
    )!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    devtools.log("updateShouldNotify");
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorsWidget oldWidget,
    Set<AvailableColors> dependencies,
  ) {
    devtools.log(
      'updateShouldNotifyDependent',
    );
    if (dependencies.contains(AvailableColors.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.two) &&
        color2 != oldWidget.color2) {
      return true;
    }
    return false;
  }
}

class ColorWidget extends StatelessWidget {
  final AvailableColors color;
  const ColorWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailableColors.one:
        devtools.log('Color1 widget got reBuild');
        break;
      case AvailableColors.two:
        devtools.log('Color2 widget got reBuild');
        break;
    }

    final provider = AvailableColorsWidget.of(context, color);
    return Container(
      height: 100,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}

final colors = [
  Colors.red.shade200,
  Colors.red.shade300,
  Colors.red.shade400,
  Colors.red.shade500,
  Colors.red.shade600,
  Colors.red.shade700,
  Colors.red.shade800,
  Colors.red.shade900,
  Colors.red.shade200,
  Colors.red.shade300,
  Colors.red.shade400,
  Colors.red.shade500,
  Colors.red.shade600,
  Colors.red.shade700,
  Colors.red.shade800,
  Colors.red.shade900,
  Colors.blue.shade200,
  Colors.blue.shade300,
  Colors.blue.shade400,
  Colors.blue.shade500,
  Colors.blue.shade600,
  Colors.blue.shade700,
  Colors.blue.shade800,
  Colors.blue.shade900,
  Colors.blueGrey.shade200,
  Colors.blueGrey.shade300,
  Colors.blueGrey.shade400,
  Colors.blueGrey.shade500,
  Colors.blueGrey.shade600,
  Colors.blueGrey.shade700,
  Colors.blueGrey.shade800,
  Colors.blueGrey.shade900,
  Colors.brown.shade200,
  Colors.brown.shade300,
  Colors.brown.shade400,
  Colors.brown.shade500,
  Colors.brown.shade600,
  Colors.brown.shade700,
  Colors.brown.shade800,
  Colors.brown.shade900,
  Colors.cyan.shade200,
  Colors.cyan.shade300,
  Colors.cyan.shade400,
  Colors.cyan.shade500,
  Colors.cyan.shade600,
  Colors.cyan.shade700,
  Colors.cyan.shade800,
  Colors.cyan.shade900,
  Colors.deepOrange.shade200,
  Colors.deepOrange.shade300,
  Colors.deepOrange.shade400,
  Colors.deepOrange.shade500,
  Colors.deepOrange.shade600,
  Colors.deepOrange.shade700,
  Colors.deepOrange.shade800,
  Colors.deepOrange.shade900,
  Colors.deepPurple.shade200,
  Colors.deepPurple.shade300,
  Colors.deepPurple.shade400,
  Colors.deepPurple.shade500,
  Colors.deepPurple.shade600,
  Colors.deepPurple.shade700,
  Colors.deepPurple.shade800,
  Colors.deepPurple.shade900,
  Colors.green.shade200,
  Colors.green.shade300,
  Colors.green.shade400,
  Colors.green.shade500,
  Colors.green.shade600,
  Colors.green.shade700,
  Colors.green.shade800,
  Colors.green.shade900,
  Colors.indigo.shade200,
  Colors.indigo.shade300,
  Colors.indigo.shade400,
  Colors.indigo.shade500,
  Colors.indigo.shade600,
  Colors.indigo.shade700,
  Colors.indigo.shade800,
  Colors.indigo.shade900,
  Colors.lightBlue.shade200,
  Colors.lightBlue.shade300,
  Colors.lightBlue.shade400,
  Colors.lightBlue.shade500,
  Colors.lightBlue.shade600,
  Colors.lightBlue.shade700,
  Colors.lightBlue.shade800,
  Colors.lightBlue.shade900,
  Colors.lime.shade200,
  Colors.lime.shade300,
  Colors.lime.shade400,
  Colors.lime.shade500,
  Colors.lime.shade600,
  Colors.lime.shade700,
  Colors.lime.shade800,
  Colors.lime.shade900,
  Colors.pink.shade200,
  Colors.pink.shade300,
  Colors.pink.shade400,
  Colors.pink.shade500,
  Colors.pink.shade600,
  Colors.pink.shade700,
  Colors.pink.shade800,
  Colors.pink.shade900,
  Colors.teal.shade200,
  Colors.teal.shade300,
  Colors.teal.shade400,
  Colors.teal.shade500,
  Colors.teal.shade600,
  Colors.teal.shade700,
  Colors.teal.shade800,
  Colors.teal.shade900,
  Colors.yellow.shade200,
  Colors.yellow.shade300,
  Colors.yellow.shade400,
  Colors.yellow.shade500,
  Colors.yellow.shade600,
  Colors.yellow.shade700,
  Colors.yellow.shade800,
  Colors.yellow.shade900,
];

extension randomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}
