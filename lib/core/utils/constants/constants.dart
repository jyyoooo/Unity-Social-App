import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// reactive height
double screenHeight = 0;
double screenWidth = 0;
setScreenSize(BuildContext context) {
  screenHeight = MediaQuery.of(context).size.height;
  screenWidth = MediaQuery.of(context).size.width;
}

// constant heights
SizedBox height005 = SizedBox(height: screenHeight * 0.005);
SizedBox height05 = SizedBox(height: screenHeight * 0.01);
SizedBox height10 = SizedBox(height: screenHeight * 0.02);
SizedBox height20 = SizedBox(height: screenHeight * 0.04);
SizedBox height160 = SizedBox(height: screenHeight * 0.3);

//constant widths
SizedBox width10 = SizedBox(width: screenWidth * 0.03);
SizedBox width05 = SizedBox(width: screenWidth * 0.015);
SizedBox width20 = SizedBox(width: screenWidth * 0.06);
const fullWidth = SizedBox(width: double.infinity);

// constant divider
const divider = Divider(color: Colors.grey);

// constant border radius

final radius10 = BorderRadius.circular(10);
final radius20 = BorderRadius.circular(20);
final currentUser = FirebaseAuth.instance.currentUser!;
