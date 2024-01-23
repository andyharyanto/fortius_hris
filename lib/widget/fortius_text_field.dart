import 'package:flutter/material.dart';
import 'package:fortius_hris/common/colors.dart';

class FortiusTextField extends StatefulWidget {
  final String hints;
  final String? initialValue;
  final TFType type;
  final TextEditingController textEditingController;
  final TextInputType? inputType;

  const FortiusTextField(
      {super.key,
      required this.hints,
      this.initialValue,
      required this.type,
      required this.textEditingController,
      this.inputType});

  @override
  State<FortiusTextField> createState() => _FortiusTextFieldState();
}

class _FortiusTextFieldState extends State<FortiusTextField> {
  late String hints;
  late String? initialValue;
  late TFType type;
  late TextEditingController textEditingController;
  late TextInputType? inputType;

  bool _boolHidePassword = true;

  @override
  void initState() {
    hints = widget.hints;
    initialValue = widget.initialValue;
    type = widget.type;
    textEditingController = widget.textEditingController;
    inputType = widget.inputType;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (type == TFType.email) {
      return TextField(
        controller: textEditingController,
        keyboardType: inputType ?? TextInputType.text,
        style: const TextStyle(
          color: blackPrimary,
        ),
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email_outlined),
            counterText: "",
            contentPadding:
                const EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: darkBluePrimary, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey, width: 1)),
            filled: false,
            hintStyle: const TextStyle(color: Colors.grey),
            hintText: hints,
            fillColor: Colors.transparent),
      );
    }
    return TextField(
      controller: textEditingController,
      keyboardType: inputType ?? TextInputType.text,
      style: const TextStyle(color: blackPrimary),
      obscureText: _boolHidePassword,
      enableSuggestions: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding:
            const EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: blackPrimary, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: blackPrimary, width: 1)),
        filled: false,
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
        hintText: hints,
        fillColor: Colors.transparent,
        suffixIcon: (_boolHidePassword)
            ? SizedBox(
                width: 30,
                height: 30,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        _boolHidePassword = !_boolHidePassword;
                      });
                    },
                    icon: const Icon(Icons.remove_red_eye)),
              )
            : SizedBox(
                width: 30,
                height: 30,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        _boolHidePassword = !_boolHidePassword;
                      });
                    },
                    icon: const Icon(Icons.visibility_off_outlined)),
              ),
      ),
    );
  }
}

enum TFType { email, password }
