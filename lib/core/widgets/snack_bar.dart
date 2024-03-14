import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    showCloseIcon: true,
    elevation: 12,
    backgroundColor: Colors.black54,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    margin: const EdgeInsets.all(10),
    content: Text(message),
    duration: const Duration(seconds: 3),
  ));
}
