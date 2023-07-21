import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

const colorRed = Color.fromRGBO(231, 28, 36, 1);
const colorDark = Color.fromRGBO(136, 28, 32, 1);
const colorGreen = Color.fromRGBO(33, 191, 115, 1);
const colorBlue = Color.fromRGBO(52, 152, 219, 1.0);
const colorOrange = Color.fromRGBO(230, 126, 34, 1.0);
const colorWhite = Color.fromRGBO(255, 255, 255, 1.0);
const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1.0);
const colorLightGray = Color.fromRGBO(135, 142, 150, 1.0);
const colorLight = Color.fromRGBO(211, 211, 211, 1.0);

SizedBox itemSizeBox(Widget child) {
  return SizedBox(
    width: double.infinity,
    child: Container(
      padding: const EdgeInsets.all(10),
      child: child,
    ),
  );
}

PinTheme appOTPStyle() {
  return PinTheme(
    inactiveColor: colorLight,
    inactiveFillColor: colorWhite,
    selectedColor: colorGreen,
    activeColor: colorWhite,
    selectedFillColor: colorGreen,
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(5),
    fieldHeight: 50,
    borderWidth: 0.5,
    fieldWidth: 45,
    activeFillColor: Colors.white,
  );
}

TextStyle head1Text(Color textColor) {
  return TextStyle(
    color: Color.fromRGBO(44, 62, 80, 1.0),
    fontSize: 28,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );
}

TextStyle head6Text(Color textColor) {
  return TextStyle(
    color: Color.fromRGBO(135, 142, 150, 1.0),
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
}

TextStyle head7Text(Color textColor) {
  return TextStyle(
    color: textColor,
    fontSize: 13,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
}

TextStyle head9Text(Color textColor) {
  return TextStyle(
    color: textColor,
    fontSize: 9,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
}

InputDecoration appInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: colorGreen, width: 1),
    ),
    filled: true,
    fillColor: colorWhite,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: colorWhite, width: 0.0),
    ),
    border: const OutlineInputBorder(),
  );
}

DecoratedBox appDropDownStyle(Widget child) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.white, width: 1),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: child,
    ),
  );
}

SvgPicture screenBackground(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return SvgPicture.asset(
    'assets/images/screen_background.svg',
    alignment: Alignment.center,
    width: size.width,
    height: size.height,
    fit: BoxFit.cover,
  );
}

ButtonStyle appButtonStyle() {
  return ElevatedButton.styleFrom(
    elevation: 1,
    padding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  );
}

ButtonStyle appStatusButtonStyle(Color btnColor) {
  return ElevatedButton.styleFrom(
    elevation: 1,
    padding: EdgeInsets.zero,
    backgroundColor: btnColor,
  );
}

TextStyle buttonTextStyle() {
  return const TextStyle(
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
}

Ink successButtonChild(String buttonText) {
  return Ink(
    decoration: BoxDecoration(
      color: colorGreen,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: buttonTextStyle(),
      ),
    ),
  );
}

Container statusChild(String statusText, Color statusColor) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: statusColor,
    ),
    height: 20,
    width: 60,
    child: Text(
      statusText,
      style: const TextStyle(
        color: colorWhite,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

void successToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: colorGreen,
    textColor: colorWhite,
    fontSize: 16.0,
  );
}

void errorToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: colorRed,
    textColor: colorWhite,
    fontSize: 16.0,
  );
}
