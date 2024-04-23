import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/auth/screens/auth_page.dart';

import 'sign_out_cubit/cubit.dart';

class AnimatedSignOutButton extends StatefulWidget {
  const AnimatedSignOutButton({Key? key}) : super(key: key);

  @override
  AnimatedSignOutButtonState createState() => AnimatedSignOutButtonState();
}

class AnimatedSignOutButtonState extends State<AnimatedSignOutButton> {
  bool _isPressed = false;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignOutCubit, bool>(
      builder: (context, signingOut) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              setState(() {
                _isPressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isPressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                _isPressed = false;
              });
            },
            onHorizontalDragStart: (_) {
              if (_isPressed) {
                setState(() {
                  _isDragging = true;
                });
              }
            },
            onHorizontalDragUpdate: (_) {
              if (!_isPressed) {
                setState(() {
                  _isDragging = false;
                });
              }
            },
            onHorizontalDragEnd: (_) {
              if (_isDragging) {
                context.read<SignOutCubit>().startSignOut();
                if (signingOut) {
                  signOut(context);
                }
              }
              setState(() {
                _isPressed = false;
                _isDragging = false;
              });
            },
            child: AnimatedContainer(
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              transform: _isPressed
                  ? Matrix4.identity().scaled(0.95, 0.95)
                  : Matrix4.identity(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: CupertinoColors.lightBackgroundGray.withOpacity(0.6),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                enableFeedback: true,
                leading: const Icon(
                  CupertinoIcons.square_arrow_right,
                  color: CupertinoColors.systemRed,
                  // size: _isPressed? 35:25,
                ),
                title: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      tileMode: TileMode.repeated,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.red, Colors.red],
                      // stops: [0.0, 1.0],
                    ).createShader(bounds);
                  },
                  child: Text(
                    _isPressed ? 'Swipe to sign out' : 'Sign out',
                    style: const TextStyle(
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ),
                trailing: _isPressed
                    ? TextButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9))),
                            fixedSize:
                                const MaterialStatePropertyAll(Size(80, 10)),
                            elevation: const MaterialStatePropertyAll(0),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          setState(() {
                            _isPressed = false;
                          });
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: CupertinoColors.activeBlue),
                        ))
                    : const SizedBox(),
                tileColor: _isPressed
                    ? CupertinoColors.systemGrey4
                    : CupertinoColors.lightBackgroundGray.withOpacity(.6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        );
      },
    );
  }

  void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut().then((_) {
        context.read<SignOutCubit>().completeSignOut();
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ),
        );
      });
    } on FirebaseAuthException catch (error) {
      // Handle sign-out error
      print(error.toString());
    }
  }
}
