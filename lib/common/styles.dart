import 'package:flutter/cupertino.dart';
import 'package:styled_widget/styled_widget.dart';

class CustomText {
  Text textNormal(String txt) {
    return Text(txt).fontWeight(FontWeight.normal);
  }

  Text textMedium(String txt) {
    return Text(txt).fontWeight(FontWeight.w500);
  }

  Text textBold(String txt) {
    return Text(txt).fontWeight(FontWeight.bold);
  }
}
