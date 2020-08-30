import 'package:flutter/material.dart';
import 'Utils/base_scaffold.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mixercon Assistance',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: BaseScaffold(),
    );
  }
}
