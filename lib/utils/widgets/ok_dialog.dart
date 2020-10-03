import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:TimeTracker/utils/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class OkDialog extends StatefulWidget {
  final String title;
  final String okText;
  final Function onPress;
  final bool dismissible;
  OkDialog(
      {Key key,
      this.title = "",
      this.okText = "",
      this.onPress,
      this.dismissible = true})
      : super(key: key);

  @override
  _OkDialogState createState() => _OkDialogState();
}

class _OkDialogState extends State<OkDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          height: 120,
          width: 360,
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.all(radius: AppRadius.radius20),
            color: AppColors.PrimaryWhite,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.title != null && widget.title.isNotEmpty? Text(
                widget.title,
                style: AppTextStyle.blackStyle(
                    fontSize: AppFontSizes.title18,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ) : SizedBox(),
              SizedBox(height: 20),
              RoundedButton(
                text: widget.okText,
                size: Size(160, 40),
                color: AppColors.PrimaryLightBlue,
                style: AppTextStyle.whiteStyle(
                    fontSize: AppFontSizes.text16, fontWeight: FontWeight.w500),
                onPress: widget.onPress,
              ),
            ],
          ),
        ),
        onWillPop: () async => widget.dismissible);
  }
}
