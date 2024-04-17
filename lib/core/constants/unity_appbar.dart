// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bloc.dart';

class UnityAppBar extends StatelessWidget {
  const UnityAppBar({
    Key? key,
    required this.title,
    this.showBackBtn = false,
    this.enableCloseAction = false,
    this.search = false,
    this.onChanged,
    this.focusNode,
    this.activateOntap = false,
    this.onInfoTap,
    this.showInfoIcon = false,
    this.smallTitle = false,
  }) : super(key: key);

  final String title;
  final bool showBackBtn;
  final bool search;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool activateOntap;
  final VoidCallback? onInfoTap;
  final bool enableCloseAction;
  final bool showInfoIcon;
  final bool smallTitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: AppBar(backgroundColor: Colors.transparent,
          titleSpacing: 0,
          scrolledUnderElevation: 1,
          leadingWidth: showBackBtn ? 50 : 0,
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          leading: showBackBtn ? _backButton(context) : null,
          toolbarHeight: 80,
          title: activateOntap
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: _pageTitle())
              : _pageTitle(),
          actions: [
            showInfoIcon ? _showInfoIcon() : const SizedBox(),
            enableCloseAction ? _closeAction(context) : const SizedBox()
          ],
          bottom: search ? _showSearchField() : null,
        ),
      ),
    );
  }

  Padding _showInfoIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, top: 15),
      child: IconButton(
        icon: const Icon(CupertinoIcons.info, size: 23),
        color: CupertinoColors.activeBlue,
        onPressed: onInfoTap,
      ),
    );
  }

  Padding _closeAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, top: 15),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
          context.read<NavigationCubit>().showNavBar();
        },
        icon: const Icon(CupertinoIcons.xmark),
      ),
    );
  }

  PreferredSize _showSearchField() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20),
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ClipPath(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: CupertinoSearchTextField(
                onChanged: onChanged,
                focusNode: focusNode,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _pageTitle() {
    return Padding(
      padding: EdgeInsets.only(
        top: 27.0,
        left: showBackBtn ? 0 : 18,
        bottom: 15,
      ),
      child: Text(
        title,
        style: TextStyle(backgroundColor: Colors.transparent,
          fontWeight: smallTitle ? FontWeight.normal : FontWeight.bold,
          fontSize: smallTitle ? 17 : 27,
          color: smallTitle ? CupertinoColors.activeBlue : Colors.black,
        ),
      ),
    );
  }

  Padding _backButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: IconButton(
        onPressed: () {
          context.read<NavigationCubit>().showNavBar();
          log('popping');
          Navigator.of(context).pop();
        },
        icon: const Icon(
          CupertinoIcons.back,
          color: CupertinoColors.activeBlue,
        ),
      ),
    );
  }
}
