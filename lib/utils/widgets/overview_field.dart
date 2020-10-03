import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:flutter/material.dart';

enum OverviewFieldOrientation { Vertical, Horizontal }

class OverviewField extends StatelessWidget {
  final String label;
  final String text;
  final double width;
  final OverviewFieldOrientation orientation;
  const OverviewField(
      {Key key,
      this.label = "",
      this.text = "",
      this.orientation = OverviewFieldOrientation.Vertical,
      this.width = 200})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orientation == OverviewFieldOrientation.Vertical
        ? verticalOverview
        : horizontalOverview;
  }

  Widget get verticalOverview => SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              child: Text(
                "$label:",
                style: AppTextStyle.blackStyle(
                  fontSize: AppFontSizes.subitle18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "$text",
                  style: AppTextStyle.blackStyle(
                    fontSize: AppFontSizes.subitle18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget get horizontalOverview => SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              child: Text(
                "$label:",
                style: AppTextStyle.blackStyle(
                  fontSize: AppFontSizes.subitle18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              child: Text(
                "$text",
                style: AppTextStyle.blackStyle(
                  fontSize: AppFontSizes.subitle18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
}
