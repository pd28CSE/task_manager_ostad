import 'package:flutter/material.dart';

import '../../styles/style.dart';

class SetPasswordScreen extends StatefulWidget {
  static const String routeName = 'set-password-screen/';
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
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
                  'Set New Password',
                  style: head1Text(colorDarkBlue),
                ),
                const SizedBox(height: 1),
                Text(
                  'Minimum length password 8 character with Latter and Number combination',
                  style: head6Text(colorLightGray),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: appInputDecoration('Password'),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: appInputDecoration('Confirm Password'),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
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
