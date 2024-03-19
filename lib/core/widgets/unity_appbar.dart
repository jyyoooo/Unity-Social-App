// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnityAppBar extends StatelessWidget {
  const UnityAppBar({
    Key? key,
    required this.title,
    this.showBackBtn = false,
    this.search = false,
    this.onChanged,
    this.focusNode,
  }) : super(key: key);

  final String title;
  final bool showBackBtn;
  final bool search;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        forceMaterialTransparency: true,
        leading: showBackBtn
            ? Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(CupertinoIcons.back),
                ),
              )
            : null,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(top: 50.0, left: showBackBtn ? 0 : 20),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        bottom: search
            ? PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CupertinoSearchTextField(
                      onChanged: onChanged,
                      focusNode: focusNode,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
