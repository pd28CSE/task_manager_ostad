import 'package:flutter/material.dart';

import '../../styles/style.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const String routeName = 'email-verification-screen/';
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
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
                  'Your Email Address',
                  style: head1Text(colorDarkBlue),
                ),
                const SizedBox(height: 1),
                Text(
                  '6 digit verification pin will send to your email address.',
                  style: head6Text(colorLightGray),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: appInputDecoration('Email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: appButtonStyle(),
                  onPressed: () {},
                  child: successButtonChild('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
