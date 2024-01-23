import 'package:flutter/material.dart';
import 'package:fortius_hris/common/styles.dart';
import 'package:styled_widget/styled_widget.dart';

import '../helper/helper.dart';

class FortiusLiveClockWidget extends StatelessWidget {
  const FortiusLiveClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return CustomText()
            .textNormal(
                Helper.convertDateFormatTimeToSecond(DateTime.now().toString()))
            .textColor(Colors.white);
      },
    );
  }
}
