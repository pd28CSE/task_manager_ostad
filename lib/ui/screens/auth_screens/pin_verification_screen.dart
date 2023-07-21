import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../styles/style.dart';
import '../../widgets/screen_background.dart';

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
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'PIN Verification',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'A 6 digit pin has been send to your phone number',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 20),
                  PinCodeTextField(
                    pinTheme: appOTPStyle(),
                    appContext: context,
                    length: 6,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
