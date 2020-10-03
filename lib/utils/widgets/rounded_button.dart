import 'package:TimeTracker/utils/general/app_colors.dart';
import 'package:TimeTracker/utils/general/app_text_styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color;
  final TextStyle style;
  final Size size;
  const RoundedButton({
    Key key,
    this.text,
    this.onPress,
    this.color = AppColors.PrimaryLightBlue,
    this.style,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size?.height ?? 50,
      width: size?.width ?? 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: onPress != null ? FlatButton(
          padding: EdgeInsets.zero,
          color: color,
          onPressed: onPress,
          child: Center(
            child: Text(
              text,
              style: style ?? AppTextStyle.blackStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ) : Material(
          color: AppColors.PrimaryGrey,
          child: Center(
            child: Text(
              text,
              style: style ?? AppTextStyle.blackStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
