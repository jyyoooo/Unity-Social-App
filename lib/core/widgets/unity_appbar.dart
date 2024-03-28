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
    this.titleSize = 30,
    this.titleColor = Colors.black,
    this.boldTitle = true,
  }) : super(key: key);

  final String title;
  final bool showBackBtn;
  final bool search;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final double titleSize;
  final Color titleColor;
  final bool boldTitle;

  @override
  Widget build(BuildContext context) {
    return 
    // ClipPath(
      // child: BackdropFilter(
        // filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        // child:
         AppBar(
          forceMaterialTransparency: true,
          leading: showBackBtn ? _backButton(context) : null,
          toolbarHeight: 80,
          title: _pageTitle(),
          bottom: search ? _showSearchField() : null,
        );
      // ),
    // );
  }

  PreferredSize _showSearchField() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CupertinoSearchTextField(
            onChanged: onChanged,
            focusNode: focusNode,
          ),
        ),
      ),
    );
  }

  Padding _pageTitle() {
    return Padding(
      padding:
          EdgeInsets.only(top: 27.0, left: showBackBtn ? 0 : 20, bottom: 15),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: boldTitle ? FontWeight.bold : FontWeight.normal,
            fontSize: titleSize,
            color: titleColor),
      ),
    );
  }

  Padding _backButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
      ),
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(CupertinoIcons.back),
      ),
    );
  }
}
