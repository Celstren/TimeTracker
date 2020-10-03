import 'package:TimeTracker/utils/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

void displayLoadingScreen(BuildContext context) {
  showCustomDialog(
    context: context,
    child: CustomDialog(
      backgroundColor: Colors.transparent,
      child: LoadingScreen(),
    ),
  );
}
