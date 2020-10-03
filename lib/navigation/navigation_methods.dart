import 'package:flutter/cupertino.dart';

class NavigationMethods {
  BuildContext context;
  NavigationMethods.of(this.context);

  void navigateTo(Widget screen) => Navigator.of(this.context).push(route(screen, 'fade'));

  void popAndNavigateTo(Widget screen) {
    Navigator.pop(this.context);
    navigateTo(screen);
  }

  void navigateReplacement(Widget screen) => Navigator.of(this.context).pushReplacement(route(screen, 'fade'));

  void navigateNamedAndReplacementTo({String path = "/"}) => Navigator.of(this.context).pushNamedAndRemoveUntil(path, (Route<dynamic> route) => false);

  void navigateNamedAndRemoveUntil({String path = "/"})=> Navigator.of(this.context).pushNamedAndRemoveUntil(path, (Route<dynamic> route) => false);

  void navigateAndRemoveUntil(Widget screen) => Navigator.of(this.context).pushAndRemoveUntil(route(screen, 'fade'), (Route<dynamic> route) => false);
}

Route route(page, String type) {
  if (type == 'fade') {
    return PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
      return page;
    }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return new FadeTransition(opacity: animation, child: child);
    });
  } else {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 0.1);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
