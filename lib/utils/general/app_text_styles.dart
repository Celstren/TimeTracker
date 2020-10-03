import 'package:TimeTracker/utils/general/app_colors.dart';
import 'package:TimeTracker/utils/general/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle whiteStyle({
    String fontFamily = AppFonts.Montserrat_Regular,
    double fontSize = 16,
    List<Shadow> shadows,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextDecoration decoration,
  }) =>
      TextStyle(
        color: AppColors.PrimaryWhite,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        shadows: shadows,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  static TextStyle blackStyle({
    String fontFamily = AppFonts.Montserrat_Regular,
    double fontSize = 16,
    List<Shadow> shadows,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextDecoration decoration,
  }) =>
      TextStyle(
        color: AppColors.PrimaryBlack,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        shadows: shadows,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  static TextStyle greyStyle({
    String fontFamily = AppFonts.Montserrat_Regular,
    double fontSize = 16,
    List<Shadow> shadows,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextDecoration decoration,
  }) =>
      TextStyle(
        color: AppColors.PrimaryGrey,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        shadows: shadows,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  static TextStyle darkGreyStyle({
    String fontFamily = AppFonts.Montserrat_Regular,
    double fontSize = 16,
    List<Shadow> shadows,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextDecoration decoration,
  }) =>
      TextStyle(
        color: AppColors.PrimaryDarkGrey,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        shadows: shadows,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  static TextStyle transparentStyle({
    String fontFamily = AppFonts.Montserrat_Regular,
    double fontSize = 16,
    List<Shadow> shadows,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextDecoration decoration,
  }) =>
      TextStyle(
        color: Colors.transparent,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        shadows: shadows,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  static TextStyle redStyle({
    String fontFamily = AppFonts.Montserrat_Regular,
    double fontSize = 16,
    List<Shadow> shadows,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextDecoration decoration,
  }) =>
      TextStyle(
        color: AppColors.PrimaryRed,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        shadows: shadows,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  static TextStyle greenStyle({
    String fontFamily = AppFonts.Montserrat_Regular,
    double fontSize = 16,
    List<Shadow> shadows,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextDecoration decoration,
  }) =>
      TextStyle(
        color: AppColors.PrimaryGreen,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        shadows: shadows,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );
}
