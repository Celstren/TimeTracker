import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:TimeTracker/utils/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class DescriptionDialog extends StatefulWidget {
  final String title;
  final String description;
  final String okText;
  final Function onPress;
  final bool dismissible;
  DescriptionDialog(
      {Key key,
      this.title = "",
      this.description = "",
      this.okText = "",
      this.onPress,
      this.dismissible = true})
      : super(key: key);

  @override
  _DescriptionDialogState createState() => _DescriptionDialogState();
}

class _DescriptionDialogState extends State<DescriptionDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          height: 180,
          width: 360,
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.all(radius: AppRadius.radius20),
            color: AppColors.PrimaryWhite,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.title != null && widget.title.isNotEmpty
                  ? Text(
                      widget.title,
                      style: AppTextStyle.blackStyle(
                          fontSize: AppFontSizes.title18,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    )
                  : SizedBox(),
              widget.description != null && widget.description.isNotEmpty
                  ? SizedBox(
                      height: 60,
                      width: 250,
                      child: SingleChildScrollView(
                        child: Text(
                          widget.description,
                          style: AppTextStyle.blackStyle(
                              fontSize: AppFontSizes.text14),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    )
                  : SizedBox(),
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
