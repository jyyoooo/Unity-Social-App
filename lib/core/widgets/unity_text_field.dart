// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:unitysocial/core/utils/validators.dart';
import 'package:unitysocial/features/auth/data/repository/firestore_service.dart';

import '../utils/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function validator;
  final bool obscureText;
  final bool suffixIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        obscureText: obscureText ? isObscure.value : !isObscure.value,
        validator: (value) {
          if (value!.isEmpty) {
            return fieldIsEmpty(controller, context);
          } else if (!validation(validator, value)) {
            return validationResult(validator);
          }
          return null;
        },
        onChanged: (value) async {
          hintText.contains('password')
              ? controller.text.length >= 8
                  ? isValid.value = true
                  : isValid.value = false
              : null;
          hintText.contains('Username') && controller.text.isNotEmpty
              ? isAvailable.value =
                  await FireStoreService.existingUsername(value.trim())
              : null;
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          suffixIcon: suffixIcon
              ? obscureText
                  ? InkWell(
                      onTap: () {
                        isObscure.value = !isObscure.value;
                      },
                      child: IconButton(
                          onPressed: () {
                            isObscure.value = !isObscure.value;
                          },
                          icon: Icon(
                            size: 20,
                            isObscure.value
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: Colors.black54,
                          )),
                    )
                  : null
              : null,
        ),
      ),
    );
  }
}
