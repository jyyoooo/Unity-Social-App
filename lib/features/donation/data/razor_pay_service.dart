import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:unitysocial/core/widgets/snack_bar.dart';
import 'package:unitysocial/features/donation/screens/dontaion_success_page.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class RazorPayService {
  void openCheckout(Razorpay razorpay, String amount) {
    var options = {
      "key": "rzp_test_KVdVVjVysrpQS4",
      "amount": num.parse(amount) * 100,
      "name": "Unity Social",
      "description": 'Donation test',
      "timeout": "180",
      "currency": "INR",
      "prefill": {
        "contact": "6282983296",
        "email": "jyo@mail.com",
      }
    };
    razorpay.open(options);
  }

  handlePaymentSuccess(BuildContext context, PaymentSuccessResponse reponse,
      RecruitmentPost post) {
    showSnackbar(context, 'Payment Success', CupertinoColors.systemGreen);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DonationSuccessPage(postTitle: post.title)));
  }

  handlePaymentError(BuildContext context, PaymentFailureResponse response) {
    if (response.code == 2) {
      showSnackbar(context, 'Payment cancelled', CupertinoColors.systemBlue);
    } else {
      showSnackbar(context, 'Payment error', CupertinoColors.destructiveRed);
    }
  }

  handleExternalWallet(BuildContext context, ExternalWalletResponse response) {
    showSnackbar(context, 'Wallet stuff', CupertinoColors.destructiveRed);
  }
}
