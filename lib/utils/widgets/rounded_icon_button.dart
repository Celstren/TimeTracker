import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData iconData;
  final Function onPress;
  final Color color;
  final Color iconColor;
  final double size;
  const RoundedIconButton({
    Key key,
    this.onPress,
    this.color = AppColors.PrimaryLightBlue,
    this.size = 60, 
    this.iconData = Icons.play_circle_filled, 
    this.iconColor = AppColors.PrimaryWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(double.infinity),
        child: onPress != null ? FlatButton(
          padding: EdgeInsets.zero,
          color: color,
          onPressed: onPress,
          child: Center(
            child: Icon(
              iconData, size: size * .75,
              color: iconColor,
            ),
          ),
        ) : Material(
          color: AppColors.PrimaryDarkGrey,
          child: Center(
            child: Icon(
              iconData, size: size * .75,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
