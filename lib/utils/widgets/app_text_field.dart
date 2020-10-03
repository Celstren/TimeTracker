import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:TimeTracker/utils/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppSimpleTextField extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final Size size;
  final List<TextInputFormatter> inputFormatters;
  final Function(String) onChanged;
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final String hint;
  final bool isValid;
  final bool obscureText;
  final String errorMsg;
  final Widget suffixIcon;

  const AppSimpleTextField({
    Key key,
    this.title = "",
    this.size,
    this.inputFormatters,
    this.onChanged,
    this.controller,
    this.onSubmitted,
    this.hint = "",
    this.isValid = true,
    this.errorMsg = "",
    this.titleStyle,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _validationSection = SizedBox();

    if (!isValid) {
      _validationSection = Text(errorMsg,
          style: AppTextStyle.redStyle(fontSize: AppFontSizes.text12));
    }

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              maxLines: null,
              style: titleStyle ??
                  AppTextStyle.blackStyle(fontWeight: FontWeight.bold)),
          TextFieldContainer(
            size: size ?? Size(375, 40),
            controller: controller,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            obscureText: obscureText,
            backgroundColor: AppColors.PrimaryWhite,
            hint: hint,
            hintStyle:
                AppTextStyle.blackStyle(fontSize: AppFontSizes.subitle16),
            style: AppTextStyle.blackStyle(fontSize: AppFontSizes.subitle16),
            borderRadius: AppBorderRadius.all(radius: AppRadius.radius5),
            border: AppBorder.blackBorder,
            collapsed: true,
            suffixIcon: suffixIcon,
          ),
          _validationSection,
        ],
      ),
    );
  }
}

class AppDateTextField extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final DateTime controller;
  final Function(DateTime) onSelected;
  final String hint;
  final String errorMsg;
  final bool isValid;
  const AppDateTextField(
      {Key key,
      this.title = "",
      this.titleStyle,
      this.controller,
      this.onSelected,
      this.hint,
      this.errorMsg,
      this.isValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: titleStyle ??
                  AppTextStyle.blackStyle(fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () async {
              DateTime dateSelected = await showDatePicker(
                  context: context,
                  initialDate: controller ?? DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 100),
                  lastDate: DateTime.now());
              if (dateSelected != null && onSelected != null) {
                onSelected(dateSelected);
              }
            },
            child: Container(
              width: 375,
              height: 40,
              decoration: BoxDecoration(
                border: AppBorder.blackBorder,
                borderRadius: AppBorderRadius.all(radius: AppRadius.radius5),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    controller != null
                        ? DateFormat("dd/MM/yyyy").format(controller)
                        : hint,
                    style: AppTextStyle.blackStyle(
                        fontSize: AppFontSizes.subitle16),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
          isValid
              ? SizedBox()
              : Text(errorMsg,
                  style: AppTextStyle.redStyle(fontSize: AppFontSizes.text12)),
        ],
      ),
    );
  }
}
