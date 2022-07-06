import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Platform.isIOS
        ? CupertinoButton(
      onPressed: onPressed,
      color: theme.colorScheme.primary,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Text(
        label,
      ),
    )
        : ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: theme.textTheme.button?.color,
        ),
      ),
    );
  }
}
