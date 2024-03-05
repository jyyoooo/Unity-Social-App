// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UnityAppBar extends StatelessWidget {
  const UnityAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.grey.withOpacity(.4),
      title: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }
}
