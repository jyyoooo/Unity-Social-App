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
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: buttonGreen.withOpacity(.1),
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignInside)),
          focusColor: Colors.black,
          hintStyle: const TextStyle(fontSize: 15),
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          labelText: labelText,
          errorMaxLines: 2,
          errorStyle: const TextStyle(),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          prefixIcon: const SizedBox(width: 15),
          suffixIcon: obscure
              ? IconButton(
                  onPressed: () => obscurity.toggleObscure(),
                  icon: Icon(
                    context.watch<Obscurity>().state
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                    size: 20,
                    color: Colors.black54,
                  ),
                )
              : null,
        ),
        obscureText: obscure ? obscurity.state : false,
      ),
    );
  }
}
