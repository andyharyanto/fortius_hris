import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/colors.dart';

class FortiusAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleBar;
  final VoidCallback? onLeadingPressed; //left button
  final VoidCallback? onActionPressed;

  const FortiusAppBar(
      {super.key,
      required this.titleBar,
      required this.onLeadingPressed,
      this.onActionPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // Navigation bar
          statusBarColor: blackPrimary, // Status
          statusBarBrightness: Brightness.light // bar
          ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 16,
      title: Container(
        margin: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Leading Widget
            InkWell(
              onTap: onLeadingPressed,
              child: const SizedBox(
                height: 36,
                width: 36,
                child: Icon(Icons.arrow_back),
              ),
            ),
            //Title
            Expanded(
              child: Container(
                margin: (onActionPressed == null)
                    ? const EdgeInsets.only(right: 36)
                    : const EdgeInsets.only(left: 12, right: 12),
                child: Text(titleBar,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        color: blackPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),

            //Trailing Widget / Actions
            if (onActionPressed != null)
              InkWell(
                onTap: onActionPressed,
                child: const SizedBox(
                  width: 36,
                  height: 36,
                  child: Icon(Icons.calendar_today),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
