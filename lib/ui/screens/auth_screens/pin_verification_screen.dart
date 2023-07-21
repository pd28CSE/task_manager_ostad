import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../styles/style.dart';

class PinVerificationScreen extends StatefulWidget {
  static const String routeName = 'pin-verification-screen/';
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          screenBackground(context),
          Ink(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'PIN Verification',
                  style: head1Text(colorDarkBlue),
                ),
                const SizedBox(height: 1),
                Text(
                  'A 6 digit pin has been send to your phone number',
                  style: head6Text(colorLightGray),
                ),
                const SizedBox(height: 20),
                PinCodeTextField(
                  pinTheme: appOTPStyle(),
                  appContext: context,
                  length: 6,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: appButtonStyle(),
                  onPressed: () {},
                  child: successButtonChild('Confirm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
