import 'package:flutter/material.dart';

class FortiusErrorWidget extends StatelessWidget {
  final String errorText;

  const FortiusErrorWidget({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.red),
      child: Text(
        errorText,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
