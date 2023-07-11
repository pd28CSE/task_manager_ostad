import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/style.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login-screen/';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  'Get Started With',
                  style: head1Text(colorDarkBlue),
                ),
                const SizedBox(height: 1),
                Text(
                  'Learn with rabbil hasan',
                  style: head6Text(colorLightGray),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: appInputDecoration('Email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: appInputDecoration('Password'),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: appButtonStyle(),
                  onPressed: () {},
                  child: successButtonChild('Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
