import 'package:flutter/material.dart';

class AppBorderRadius {
  static BorderRadius onlyLeft({Radius bottomRadius = AppRadius.radius10})    => BorderRadius.only(bottomLeft: bottomRadius, topLeft: bottomRadius);
  static BorderRadius onlyRight({Radius bottomRadius = AppRadius.radius10})   => BorderRadius.only(bottomRight: bottomRadius, topRight: bottomRadius);
  static BorderRadius onlyBottom({Radius bottomRadius = AppRadius.radius10})  => BorderRadius.only(bottomLeft: bottomRadius, bottomRight: bottomRadius);
  static BorderRadius onlyTop({Radius bottomRadius = AppRadius.radius10})     => BorderRadius.only(topLeft: bottomRadius, topRight: bottomRadius);
  static BorderRadius all({Radius radius = AppRadius.radius10})               => BorderRadius.all(radius);
}

class AppRadius {
  
  static const Radius radius1 = Radius.circular(1);
  static const Radius radius5 = Radius.circular(5);
  static const Radius radius10 = Radius.circular(10);
  static const Radius radius15 = Radius.circular(15);
  static const Radius radius20 = Radius.circular(20);
  static const Radius radius25 = Radius.circular(25);
  static const Radius radius30 = Radius.circular(30);
}