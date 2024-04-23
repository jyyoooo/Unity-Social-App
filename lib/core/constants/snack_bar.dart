import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showSnackbar(BuildContext context, String message,
    [Color color = const Color.fromARGB(255, 37, 204, 140)]) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    showCloseIcon: true,
    elevation: 12,
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    margin: const EdgeInsets.fromLTRB(10,10,10,80),
    content: Text(message),
    duration: const Duration(seconds: 2),
  ));
}

showErrorSnackBar(BuildContext context, String message) {
  return showTopSnackBar(
    dismissType: DismissType.onSwipe,
    animationDuration: Durations.long1,
    padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
    Overlay.of(context),
    CustomSnackBar.error(
      message: message,
      textScaleFactor: .9,
    ),
  );
}

showInfoSnackBar(BuildContext context, String message) {
  return showTopSnackBar(
    dismissType: DismissType.onSwipe,
    animationDuration: Durations.long4,
    padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
    Overlay.of(context),
    CustomSnackBar.info(
      message: message,
      textScaleFactor: .9,
    ),
  );
}

showSuccessSnackBar(BuildContext context, String message) {
  return showTopSnackBar(
    dismissType: DismissType.onSwipe,
    animationDuration: Durations.long4,
    padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
    Overlay.of(context),
    CustomSnackBar.success(
      message: message,
      textScaleFactor: .9,
    ),
  );
}
