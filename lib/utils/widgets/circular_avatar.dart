import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  final String path;
  final double size;
  final String initialName;
  const CircularAvatar(
      {Key key, this.path = "", this.size = 30, this.initialName = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.PrimaryWhite, width: 3.0),
        color: AppColors.PrimaryLightBlue,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 3.0,
            color: AppColors.PrimaryBlack.withOpacity(.5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initialName,
          style: AppTextStyle.whiteStyle(
            fontSize: size * .4,
            fontFamily: AppFonts.Montserrat_Black,
          ),
        ),
      ),
    );
  }
}
