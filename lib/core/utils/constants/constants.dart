import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




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

ValueNotifier<bool> isValid = ValueNotifier(false);
ValueNotifier<bool> isObscure = ValueNotifier(true);
ValueNotifier<bool> isAvailable = ValueNotifier(false);
ValueNotifier<bool> isEditMode = ValueNotifier(false);
ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
ValueNotifier<bool> isReadMore = ValueNotifier(false);



final TextEditingController nameController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController bioController = TextEditingController();
