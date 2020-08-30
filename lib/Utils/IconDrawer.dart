import 'package:flutter/material.dart';

class IconDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.only(left: 15.0),
        child: Image(
          height: 40,
          width: 40,
          image: AssetImage("assets/Resources/Icons/MenuIcon.png"),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}