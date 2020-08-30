import 'package:flutter/material.dart';

class ScreenUtils {
  Size screenSize;

  ScreenUtils(this.screenSize);

  double wp(percentage) {
    return percentage / 100 * screenSize.width;
  }

  double hp(percentage) {
    return percentage / 100 * screenSize.height;
  }
}
