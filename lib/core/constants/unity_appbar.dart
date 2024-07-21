// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/community/cubit/segment_cubit.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bloc.dart';

class UnityAppBar extends StatelessWidget {
  const UnityAppBar(
      {Key? key,
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
      this.showSlider = false})
      : super(key: key);

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
  final bool showSlider;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: const BoxDecoration(
              border: BorderDirectional(
                  bottom: BorderSide(
                      color: CupertinoColors.systemGrey3, width: .2))),
          child: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: AppBar(
              // surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.white.withOpacity(.5),
              titleSpacing: showBackBtn ? 0 : 20,
              scrolledUnderElevation: 1,
              leadingWidth: showBackBtn ? 50 : 0,
              automaticallyImplyLeading: false,
              forceMaterialTransparency: false,
              leading: showBackBtn ? _backButton(context) : const SizedBox(),
              toolbarHeight: 80,
              title: activateOntap
                  ? SizedBox(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      child: _pageTitle())
                  : _pageTitle(),
              actions: [
                showInfoIcon ? _showInfoIcon() : const SizedBox(),
                enableCloseAction ? _closeAction(context) : const SizedBox()
              ],
              bottom: showSlider
                  ? _cupertinoSlider(context)
                  : search
                      ? _showSearchField()
                      : null,
            ),
          ),
        ),
      ),
    );
  }

 PreferredSize _cupertinoSlider(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(25),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Center(
        child: BlocBuilder<SegmentCubit, int>(
          builder: (context, state) =>
              CupertinoSlidingSegmentedControl<int>(
            groupValue: context.read<SegmentCubit>().state,
            children: const {
              0: Text('Global'),
              1: Text('Messages'),
            },
            onValueChanged: (page) {
              context.read<SegmentCubit>().onPressed(page!);
            },
          ),
        ),
      ),
    ),
  );
}

  Widget _showInfoIcon() {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        padding: const EdgeInsets.only(top: 2.5),
        icon: const Icon(CupertinoIcons.info, size: 23),
        color: CupertinoColors.activeBlue,
        onPressed: onInfoTap,
      ),
    );
  }

  Widget _closeAction(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
          context.read<NavigationCubit>().showNavBar();
        },
        icon: const Icon(
          CupertinoIcons.xmark,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }

  PreferredSize _showSearchField() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20),
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CupertinoSearchTextField(
            enabled: true,
            onChanged: onChanged,
            focusNode: focusNode,
          ),
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          backgroundColor: Colors.transparent,
          fontWeight: smallTitle ? FontWeight.normal : FontWeight.bold,
          fontSize: smallTitle ? 17 : 27,
          color: smallTitle ? CupertinoColors.activeBlue : Colors.black,
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<NavigationCubit>().showNavBar();
        log('popping');
        Navigator.of(context).pop();
      },
      icon: const Icon(
        CupertinoIcons.back,
        color: CupertinoColors.activeBlue,
      ),
    );
  }
}
