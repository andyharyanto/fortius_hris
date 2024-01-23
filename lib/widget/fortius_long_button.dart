import 'package:flutter/material.dart';
import 'package:fortius_hris/common/colors.dart';

class FortiusLongButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onButtonPress;
  final bool disabled;
  final bool isLoading;
  final bool? isBoxShape;
  final Color? buttonColor;

  const FortiusLongButton(
      {Key? key,
      required this.buttonText,
      required this.onButtonPress,
      required this.disabled,
      required this.isLoading,
      this.isBoxShape,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled || isLoading ? () {} : onButtonPress,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: disabled ? Colors.grey : (buttonColor ?? bluePrimary),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                isBoxShape != null && isBoxShape == true ? 9 : 32.0),
            side: BorderSide(
                color: disabled ? Colors.grey : (buttonColor ?? bluePrimary),
                width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
            : Text(
                buttonText,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
