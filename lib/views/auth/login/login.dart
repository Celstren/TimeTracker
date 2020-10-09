
import 'package:TimeTracker/utils/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30),
          SizedBox(
            height: 60,
            width: 60,
            child: Placeholder(),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
