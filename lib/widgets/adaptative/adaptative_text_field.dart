import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeTextFiel extends StatelessWidget {
  const AdaptativeTextFiel({
    Key? key,
    required this.label,
    required this.controller,
    this.inputType = TextInputType.text,
    required this.onSubmitted,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final TextInputType inputType;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: inputType,
              onSubmitted: onSubmitted,
              placeholder: label,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            keyboardType: inputType,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
