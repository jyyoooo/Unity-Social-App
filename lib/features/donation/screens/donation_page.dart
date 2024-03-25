import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitysocial/core/utils/validators/validators.dart';
import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/snack_bar.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

import 'widgets/amount_button.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key, required this.post});

  final RecruitmentPost post;
  @override
  DonationPageState createState() => DonationPageState();
}

class DonationPageState extends State<DonationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: UnityAppBar(
          title: 'Donate to',
          titleColor: CupertinoColors.activeBlue,
          titleSize: 17,
          showBackBtn: true,
          boldTitle: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _showPostTitle(),
              _iconAndLocation(),
              const SizedBox(height: 20),
              _hint(),
              const SizedBox(height: 10),
              _amountTextField(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AmountButton(
                      amountController: _amountController, amount: '100'),
                  AmountButton(
                      amountController: _amountController, amount: '500'),
                  AmountButton(
                      amountController: _amountController, amount: '1000'),
                ],
              ),
              const Spacer(),
              CustomButton(
                label: 'Continue',
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    showInfoSnackBar(
                        context, 'Choose the donation amount to continue');
                  }
                },
              ),
            ],
          ),
        ),
      ),
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

  TextFormField _amountTextField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _amountController,
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

  Row _iconAndLocation() {
    return Row(
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
}
