import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitysocial/core/utils/validators/validators.dart';
import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/snack_bar.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class BackupDonationPage extends StatelessWidget {
  BackupDonationPage({Key? key, required this.post}) : super(key: key);

  final RecruitmentPost post;
  final TextEditingController amountController = TextEditingController();
  final donationFormKey = GlobalKey<FormState>();
  int donationAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _donatePageAppbar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: donationFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        post.title,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    _iconAndLocation(),
                    const SizedBox(height: 20),
                    const Text(
                      'Choose donation amount',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: amountController,
                      validator: amountValidator,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                          hintStyle:
                              TextStyle(fontSize: 30, color: Colors.white),
                          counter: SizedBox(),
                          hintText: '₹',
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.5)),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          constraints: BoxConstraints(maxWidth: 160)),
                      cursorColor: Colors.blue,
                      maxLength: 5,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      label: 'Continue',
                      onPressed: () {
                        if (!donationFormKey.currentState!.validate()) {
                          showInfoSnackBar(context,
                              'Choose the donation amount to continue');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _donatePageAppbar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: UnityAppBar(
        title: 'Donate to',
        titleColor: CupertinoColors.activeBlue,
        titleSize: 17,
        showBackBtn: true,
        boldTitle: false,
      ),
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
          post.location.address.split(',').first,
          overflow: TextOverflow.fade,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
