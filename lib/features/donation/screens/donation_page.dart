import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/constants/custom_button.dart';
import 'package:unitysocial/core/constants/snack_bar.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/donation/data/razor_pay_service.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:razorpay_web/razorpay_web.dart';

import 'widgets/amount_button.dart';
import 'widgets/amount_text_field.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key, required this.post});

  final RecruitmentPost post;
  @override
  DonationPageState createState() => DonationPageState();
}

class DonationPageState extends State<DonationPage> {
  final razorService = RazorPayService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  late final Razorpay razorpay;
  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
      razorService.handlePaymentSuccess(context, response, widget.post,amountController.text);
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
      razorService.handlePaymentError(context, response);
    });
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (response) {
      razorService.handleExternalWallet(context, response);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: UnityAppBar(
          title: 'Donate to',
          smallTitle: true,
          showBackBtn: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _showPostTitle(),
                _iconAndLocation(),
                const SizedBox(height: 20),
                _hint(),
                const SizedBox(height: 10),
                amountTextField(amountController),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AmountButton(controller: amountController, amount: '100'),
                    AmountButton(controller: amountController, amount: '500'),
                    AmountButton(controller: amountController, amount: '1000'),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 3.111),
                _continueButton(context),
                _cancelButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Refactored items

  Widget _cancelButton(BuildContext context) => CustomButton(
      color: Colors.white,
      label: 'Cancel',
      labelColor: CupertinoColors.destructiveRed,
      onPressed: () => Navigator.pop(context),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15));

  CustomButton _continueButton(BuildContext context) {
    return CustomButton(
      label: 'Continue',
      onPressed: () async {
        if (!_formKey.currentState!.validate()) {
          showSnackbar(context, 'Choose the donation amount to continue',
              CupertinoColors.systemMint.highContrastColor);
        } else {
          razorService.openCheckout(razorpay, amountController.text);
        }
      },
    );
  }

  Text _hint() {
    return const Text(
      'Choose donation amount',
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
    );
  }

  Align _showPostTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.post.title,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _iconAndLocation() => Row(
        children: [
          const Icon(
            CupertinoIcons.location_fill,
            size: 12,
            color: Colors.black54,
          ),
          const SizedBox(width: 2),
          Text(
            widget.post.location.address.split(',').first,
            overflow: TextOverflow.fade,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      );
}
