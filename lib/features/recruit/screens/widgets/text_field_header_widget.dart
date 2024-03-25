import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldHeader extends StatelessWidget {
  const TextFieldHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        ' $title',
        style: const TextStyle(fontWeight: FontWeight.normal, color: CupertinoColors.systemGrey),
      ),
    );
  }
}
