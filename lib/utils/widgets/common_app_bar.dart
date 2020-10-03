import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final bool showHeader;
  final bool showLogout;
  final Function handleBack;
  const CommonAppBar(
      {Key key,
      this.title = "",
      this.showHeader = false,
      this.showLogout = false,
      this.handleBack,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.PrimaryLightBlue,
        borderRadius:
            AppBorderRadius.onlyBottom(bottomRadius: AppRadius.radius15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    if (!showHeader) return _bottomContent(context);
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          _headerContent(context),
          _bottomContent(context),
        ],
      ),
    );
  }

  Widget _headerContent(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton(onPressed: () => handleBack != null ? handleBack() : Navigator.pop(context), child: Icon(Icons.arrow_back, size: 40, color: AppColors.PrimaryWhite)),
          _actions(context),
        ],
      ),
    );
  }

  Widget _bottomContent(BuildContext context) {
    return Container(
      height: showHeader ? 70 : 100,
      padding: EdgeInsets.only(bottom: 30),
      child: !showHeader && showLogout
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: AppTextStyle.whiteStyle(
                      fontSize: AppFontSizes.title24,
                      fontFamily: AppFonts.Montserrat_Black),
                ),
                _actions(context),
              ],
            )
          : Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: AppTextStyle.whiteStyle(
                    fontSize: AppFontSizes.title24,
                    fontFamily: AppFonts.Montserrat_Bold),
              ),
            ),
    );
  }

  Widget _actions(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: <Widget>[
          showLogout
              ? SizedBox(
                height: 50,
                width: 50,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Icon(Icons.exit_to_app, size: 40, color: AppColors.PrimaryWhite),
                ),
              )
              : Container(),
          SizedBox(width: 10),
          SizedBox(
            height: 40,
            width: 40,
            child: Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications,
                      size: 35,
                      color: AppColors.PrimaryGrey),
                  onPressed: () => {},
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.PrimaryOrange,
                        border: Border.all(
                            width: 3.0, color: AppColors.PrimaryWhite)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
