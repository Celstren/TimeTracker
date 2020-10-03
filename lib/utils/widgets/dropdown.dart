import 'package:TimeTracker/utils/exports/app_design.dart';
import 'package:flutter/material.dart';

class CustomDropdownItem {
  final String id;
  final String text;
  const CustomDropdownItem({this.id = "", this.text = ""});
}

class CustomSimpleDropdown extends StatelessWidget {
  @required final List<CustomDropdownItem> elements;
  final String hint;
  final String title;
  final TextStyle titleStyle;
  final CustomDropdownItem itemSelected;
  final Function(CustomDropdownItem) onChanged;
  final Size size;
  const CustomSimpleDropdown(
      {Key key,
      this.elements,
      this.hint = "",
      this.itemSelected,
      this.onChanged,
      this.size, 
      this.title = "", 
      this.titleStyle})
      : assert(elements != null),
      super(key: key);

  CustomDropdownItem getElementByID(String id) => elements.firstWhere((element) => element.id == id, orElse: () => null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: titleStyle ??
                  AppTextStyle.blackStyle(fontWeight: FontWeight.bold)),
          Container(
            height: size?.height ?? 50,
            width: size?.width ?? 200,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: AppBorder.blackBorder,
              borderRadius: AppBorderRadius.all(radius: AppRadius.radius5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(hint,
                    style: AppTextStyle.blackStyle(
                        fontSize: AppFontSizes.subitle16)),
                value: itemSelected.id.toString(),
                onChanged: onChanged != null ? (String value) => onChanged(getElementByID(value)) : null,
                items: elements.map<String>((e) => e.id).map((String value) {
                  CustomDropdownItem item = getElementByID(value);
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                      child: Text(item.text,
                          style: AppTextStyle.blackStyle(
                              fontSize: AppFontSizes.subitle16)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
