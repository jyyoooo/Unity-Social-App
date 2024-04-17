import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unitysocial/features/auth/screens/auth_page.dart';

class AnimatedSignOutButton extends StatefulWidget {
  const AnimatedSignOutButton({Key? key}) : super(key: key);

  @override
  AnimatedSignOutButtonState createState() => AnimatedSignOutButtonState();
}

class AnimatedSignOutButtonState extends State<AnimatedSignOutButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onLongPressDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTap: () => setState(() {
          _isPressed = false;
        }),
        onHorizontalDragEnd: (_) async {
          setState(() {
            _isPressed = false;
          });
          try {
            await FirebaseAuth.instance.signOut().then((_) {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              );
            });
          } on FirebaseAuthException catch (error) {
            log(error.toString());
          }
        },
        child: AnimatedContainer(
          transformAlignment: Alignment.center,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          transform: _isPressed
              ? Matrix4.identity().scaled(0.95, 0.95)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _isPressed
                ? CupertinoColors.destructiveRed
                : CupertinoColors.lightBackgroundGray.withOpacity(0.6),
          ),
          child: ListTile(
            enableFeedback: true,
            splashColor: Colors.orange,
            title: Text(_isPressed ? 'Swipe to sign out' : 'Sign out',
                style: TextStyle(
                    color:
                        _isPressed ? Colors.white : CupertinoColors.systemRed)),
            leading: Icon(CupertinoIcons.square_arrow_right,
                color: _isPressed ? Colors.white : CupertinoColors.systemRed),
          ),
        ),
      ),
    );
  }
}
