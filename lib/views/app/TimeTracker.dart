import 'package:TimeTracker/data/shared_preference/preferences.dart';
import 'package:TimeTracker/views/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeTrackerApp extends StatefulWidget {
  TimeTrackerApp({Key key}) : super(key: key);

  @override
  _TimeTrackerAppState createState() => _TimeTrackerAppState();
}

class _TimeTrackerAppState extends State<TimeTrackerApp> {
  Widget view = Scaffold();

  @override
  void initState() {
    initializeConfig();
    super.initState();
  }

  void initializeConfig() async {
    await Preferences.initPrefs();
    if (mounted) {
      setState(() {
        bool isLoggedIn = true;
        if (isLoggedIn) {
          view = LoginView();
        } else {
          view = Scaffold();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Time Tracker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: view,
    );
  }
}
