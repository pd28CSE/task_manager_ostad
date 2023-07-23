import 'package:flutter/material.dart';

import '../../widgets/screen_background.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = 'registration-screen/';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Join With Us',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 1),
                Text(
                  'Learn with rabbil hasan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
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
                    labelText: 'Phone',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                      icon: Visibility(
                        visible: isPasswordHidden,
                        replacement: const Icon(Icons.remove_red_eye),
                        child: const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: isPasswordHidden,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordHidden = !isConfirmPasswordHidden;
                        });
                      },
                      icon: Visibility(
                        visible: isConfirmPasswordHidden,
                        replacement: const Icon(Icons.remove_red_eye),
                        child: const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: isConfirmPasswordHidden,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Registration'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
