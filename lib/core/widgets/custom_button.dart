import 'package:flutter/material.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.label,
      this.onPressed,
      this.width = 200,
      this.height = 44,
      this.padding = const EdgeInsets.all(5),
      this.color,
      this.labelColor,
      this.borderRadius = 12,
      this.loading = false});

  String? label;
  Function()? onPressed;
  double? width;
  double? height;
  EdgeInsetsGeometry padding;
  Color? color;
  Color? labelColor;
  double borderRadius;
  bool loading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(Size(width!, height!)),
            backgroundColor: MaterialStatePropertyAll(color ?? buttonGreen),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)))),
        onPressed: onPressed,
        child: loading
            ? CircularProgressIndicator(color: buttonGreen, strokeWidth: 1.5)
            : Text(
                label??'',
                style: TextStyle(color: labelColor ?? Colors.white),
              ),
      ),
    );
  }
}
