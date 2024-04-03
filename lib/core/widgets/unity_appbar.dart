// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bloc.dart';

class UnityAppBar extends StatelessWidget {
  const UnityAppBar(
      {Key? key,
      required this.title,
      this.showBackBtn = false,
      this.search = false,
      this.onChanged,
      this.focusNode,
      this.titleSize = 27,
      this.titleColor = Colors.black,
      this.boldTitle = true,
      this.onTap,
      this.activateOntap = false})
      : super(key: key);

  final String title;
  final bool showBackBtn;
  final bool search;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final double titleSize;
  final Color titleColor;
  final bool boldTitle;
  final bool activateOntap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: AppBar(titleSpacing: 0,
            scrolledUnderElevation: 1,
            leadingWidth: showBackBtn ? 50 : 0,
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            leading: showBackBtn ? _backButton(context) : null,
            toolbarHeight: 80,
            title: activateOntap
                ? InkWell(
                    onTap: onTap,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: _pageTitle()))
                : _pageTitle(),
            bottom: search ? _showSearchField() : null,
          )),
    );
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
        overflow: TextOverflow.fade,
        ' $title',
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
        onPressed: () {
          context.read<NavigationCubit>().showNavBar();
          log('popping');
          Navigator.of(context).pop();
        },
        icon: const Icon(CupertinoIcons.back,color: CupertinoColors.activeBlue,),
      ),
    );
  }
}
