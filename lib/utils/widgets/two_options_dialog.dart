import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:TimeTracker/utils/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class TwoOptionsDialog extends StatefulWidget {
  final String title;
  final String leftOptionText;
  final String rightOptionText;
  final Function onLeftPress;
  final Function onRightPress;
  TwoOptionsDialog(
      {Key key,
      this.title = "",
      this.leftOptionText = "",
      this.onLeftPress,
      this.rightOptionText = "",
      this.onRightPress})
      : super(key: key);

  @override
  _TwoOptionsDialogState createState() => _TwoOptionsDialogState();
}

class _TwoOptionsDialogState extends State<TwoOptionsDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 360,
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.all(radius: AppRadius.radius20),
        color: AppColors.PrimaryWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.title,
                style: AppTextStyle.blackStyle(
                    fontSize: AppFontSizes.title18,
                    fontWeight: FontWeight.w700)),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RoundedButton(
                text: widget.leftOptionText,
                size: Size(150, 40),
                color: AppColors.PrimaryLightBlue,
                style: AppTextStyle.whiteStyle(
                    fontSize: AppFontSizes.text16, fontWeight: FontWeight.w500),
                onPress: widget.onLeftPress,
              ),
              RoundedButton(
                text: widget.rightOptionText,
                size: Size(150, 40),
                color: AppColors.PrimaryLightBlue,
                style: AppTextStyle.whiteStyle(
                    fontSize: AppFontSizes.text16, fontWeight: FontWeight.w500),
                onPress: widget.onRightPress,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
