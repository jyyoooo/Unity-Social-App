// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnityAppBar extends StatelessWidget {
  const UnityAppBar({
    Key? key,
    required this.title,
    this.showBackBtn = false,
  }) : super(key: key);

  final String title;
  final bool showBackBtn;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackBtn
          ? Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(CupertinoIcons.back)),
            )
          : const SizedBox.shrink(),
      toolbarHeight: 100,
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
