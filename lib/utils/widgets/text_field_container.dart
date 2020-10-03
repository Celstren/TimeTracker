import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:TimeTracker/utils/general/app_colors.dart';
import 'package:TimeTracker/utils/general/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldContainer extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final String leftLabel;
  final TextStyle leftLabelStyle;
  final double leftLabelWidth;
  final TextStyle style;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final Size size;
  final bool collapsed;
  final Color backgroundColor;
  final Color enableColor;
  final Color focusedColor;
  final Color borderColor;
  final Color errorColor;
  final BorderRadius borderRadius;
  final Border border;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final bool obscureText;
  final EdgeInsets contentPadding;
  final Widget suffixIcon;
  final Widget prefixIcon;
  const TextFieldContainer({
    Key key,
    this.controller,
    this.size,
    this.hint = "",
    this.hintStyle,
    this.collapsed = false,
    this.label = "",
    this.leftLabel = "",
    this.style,
    this.labelStyle,
    this.backgroundColor = AppColors.PrimaryWhite,
    this.enableColor = AppColors.PrimaryWhite,
    this.focusedColor = AppColors.PrimaryWhite,
    this.borderColor = AppColors.PrimaryWhite,
    this.errorColor = AppColors.PrimaryWhite,
    this.leftLabelStyle,
    this.leftLabelWidth = 100,
    this.borderRadius,
    this.border,
    this.onChanged,
    this.inputFormatters,
    this.onSubmitted,
    this.obscureText = false,
    this.contentPadding = EdgeInsets.zero,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: size?.width ?? 300,
      height: size?.height ?? 50,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: borderRadius, border: border),
      child: Row(
        children: <Widget>[
          leftLabel.isNotEmpty
              ? SizedBox(
                  width: leftLabelWidth,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        leftLabel,
                        style: leftLabelStyle ??
                            AppTextStyle.blackStyle(
                                fontSize: AppFontSizes.text12),
                      ),
                    ),
                  ),
                )
              : Container(),
          Expanded(
            child: Row(
              children: <Widget>[
                prefixIcon ?? SizedBox(),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    inputFormatters: inputFormatters,
                    onSubmitted: onSubmitted,
                    obscureText: obscureText,
                    style: style ??
                        AppTextStyle.blackStyle(fontSize: AppFontSizes.text12),
                    decoration: collapsed
                        ? InputDecoration.collapsed(
                            hintText: hint,
                            hintStyle: hintStyle ??
                                AppTextStyle.blackStyle(
                                    fontSize: AppFontSizes.text12),
                          )
                        : InputDecoration(
                            contentPadding: contentPadding,
                            labelText: label,
                            labelStyle: labelStyle ??
                                AppTextStyle.blackStyle(
                                    fontSize: AppFontSizes.text12),
                            hintStyle: hintStyle ??
                                AppTextStyle.blackStyle(
                                    fontSize: AppFontSizes.text12),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: enableColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: focusedColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: errorColor),
                            ),
                          ),
                  ),
                ),
                suffixIcon ?? SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
