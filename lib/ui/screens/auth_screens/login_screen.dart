import 'package:flutter/material.dart';

import '../../../styles/style.dart';
import '../../widgets/screen_background.dart';

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
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Get Started With',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 1),
              Text(
                'Learn with rabbil hasan',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
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
      ),
    );
  }
}
