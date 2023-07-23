import 'package:flutter/material.dart';

import '../../widgets/screen_background.dart';

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
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Set New Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 1),
                Text(
                  'Minimum length password 8 character with Latter and Number combination',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
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
    );
  }
}
