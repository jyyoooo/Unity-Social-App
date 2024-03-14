import 'package:flutter/material.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.label, required this.onPressed});

  String label = '';
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(Size(200, 44)),
            backgroundColor: MaterialStatePropertyAll(buttonGreen),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
