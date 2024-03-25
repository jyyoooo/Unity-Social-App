import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/core/widgets/unity_text_field/obscurity_cubit.dart'; // Assuming your obscurity_cubit.dart file is here

class UnityTextField extends StatelessWidget {
  UnityTextField(
      {Key? key,
      required this.hintText,
      this.labelText,
      this.readOnly,
      this.validator,
      this.onChanged,
      this.controller,
      this.obscure = false,
      this.maxLines = 1,
      this.onlyNumbers = false})
      : super(key: key);

  final String hintText;
  final String? labelText;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  bool onlyNumbers;
  bool obscure;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    final obscurity = context.read<Obscurity>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: maxLines,
        keyboardType: onlyNumbers ? TextInputType.number : null,
        readOnly: readOnly ?? false,
        controller: controller,
        scrollPhysics: const BouncingScrollPhysics(),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        validator: validator,
        style: const TextStyle(fontSize: 15),
        onChanged: onChanged,
        decoration: InputDecoration(
          focusedBorder: _focusedBorder(),
          focusColor: Colors.black,
          hintStyle: const TextStyle(fontSize: 15),
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey[200],
          border: _borderRadius(),
          contentPadding: _symmetricPadding(),
          labelText: labelText,
          errorMaxLines: 2,
          errorStyle: const TextStyle(
              color: CupertinoColors.systemRed, fontWeight: FontWeight.w500),
          suffixIcon: obscure ? _suffixIcon(obscurity, context) : null,
        ),
        obscureText: obscure ? obscurity.state : false,
      ),
    );
  }

  IconButton _suffixIcon(Obscurity obscurity, BuildContext context) {
    return IconButton(
      onPressed: () => obscurity.toggleObscure(),
      icon: Icon(
        context.watch<Obscurity>().state
            ? CupertinoIcons.eye
            : CupertinoIcons.eye_slash,
        size: 20,
        color: Colors.black54,
      ),
    );
  }

  EdgeInsets _symmetricPadding() =>
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);

  OutlineInputBorder _borderRadius() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
          color: CupertinoColors.activeBlue.withOpacity(.5),
          width: 1.85,
          strokeAlign: BorderSide.strokeAlignInside),
    );
  }
}
