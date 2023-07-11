import 'package:flutter/material.dart';

import '../../styles/style.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = 'registration-screen/';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          screenBackground(context),
          SingleChildScrollView(
            child: Ink(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Join With Us',
                    style: head1Text(colorDarkBlue),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'Learn with rabbil hasan',
                    style: head6Text(colorLightGray),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: appInputDecoration('First Name'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: appInputDecoration('Last Name'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: appInputDecoration('Email'),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: appInputDecoration('Phone'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: appInputDecoration('Password'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
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
                    child: successButtonChild('Registration'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
