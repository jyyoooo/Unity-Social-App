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
    return SafeArea(
      child: AppBar(forceMaterialTransparency: true,
        leading: showBackBtn
            ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(CupertinoIcons.back)),
              )
            : const SizedBox.shrink(),
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
