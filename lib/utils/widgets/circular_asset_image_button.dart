import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:TimeTracker/utils/general/app_colors.dart';
import 'package:flutter/material.dart';

class CircularAssetImageButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final TextStyle style;
  final double size;
  final String path;
  const CircularAssetImageButton({
    Key key,
    this.label = "",
    this.onPress,
    this.style,
    this.size = 100,
    this.path = "",
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
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(3.0, 3.0),
                    color: AppColors.PrimaryBlack.withOpacity(.25),
                    blurRadius: 5.0,
                    spreadRadius: 5.0)
              ],
              image: path != null ? DecorationImage(
                image: AssetImage(path),
                fit: BoxFit.fill,
              ) : null,
            ),
          ),
        ),
        SizedBox(height: 15),
        Text(label, style: AppTextStyle.blackStyle(fontSize: AppFontSizes.text14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
