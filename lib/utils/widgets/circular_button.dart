import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:TimeTracker/utils/general/app_colors.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Function onPress;
  final Color color;
  final TextStyle style;
  final double size;
  const CircularButton({
    Key key,
    this.icon,
    this.label = "",
    this.onPress,
    this.color = AppColors.PrimaryWhite,
    this.style,
    this.size = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onPress,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(3.0, 3.0),
                    color: AppColors.PrimaryBlack.withOpacity(.25),
                    blurRadius: 5.0,
                    spreadRadius: 5.0)
              ],
            ),
            child: icon,
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          width: 120,
          child: Text(label, textAlign: TextAlign.center, style: AppTextStyle.blackStyle(fontSize: AppFontSizes.text12, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
