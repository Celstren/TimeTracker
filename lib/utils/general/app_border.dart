import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:flutter/material.dart';

class AppBorder {
  static final Border blackBorder       = Border.all(color: AppColors.PrimaryBlack, width: 1.0);
  static final Border blackStartBorder  = Border(left: BorderSide(color: AppColors.PrimaryBlack, width: 1.0), bottom: BorderSide(color: AppColors.PrimaryBlack, width: 1.0), top: BorderSide(color: AppColors.PrimaryBlack, width: 1.0));
  static final Border blackEndBorder    = Border(right: BorderSide(color: AppColors.PrimaryBlack, width: 1.0), bottom: BorderSide(color: AppColors.PrimaryBlack, width: 1.0), top: BorderSide(color: AppColors.PrimaryBlack, width: 1.0));
}