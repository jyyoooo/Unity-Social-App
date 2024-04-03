import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountButton extends StatelessWidget {
  const AmountButton({
    super.key,
    required TextEditingController controller,
    required this.amount,
  }) : _amountController = controller;

  final TextEditingController _amountController;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
      onPressed: () => _amountController.text = amount,
      child: Text(
        '₹$amount',
        style: GoogleFonts.inter(),
      ),
    );
  }
}