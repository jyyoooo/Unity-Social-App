import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitysocial/core/utils/validators/validators.dart';

TextFormField amountTextField(TextEditingController amountController) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: amountController,
    validator: amountValidator,
    textAlign: TextAlign.center,
    style: GoogleFonts.inter(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    decoration: const InputDecoration(
        hintStyle: TextStyle(fontSize: 30, color: Colors.white),
        counter: SizedBox(),
        hintText: '₹',
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.5)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8),
        constraints: BoxConstraints(maxWidth: 160)),
    cursorColor: Colors.blue,
    maxLength: 5,
    maxLines: 1,
  );
}
