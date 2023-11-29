import 'package:flutter/material.dart';

/// The header [Widget] of setting on [TextFormField].
class TextFormHeader extends StatelessWidget {
  const TextFormHeader({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
