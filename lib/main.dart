import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import './screens/auth_screens/splash_screen.dart';
import './screens/auth_screens/login_screen.dart';
import './screens/auth_screens/registrations_screen.dart';
import './screens/auth_screens/email_verification_screen.dart';
import './screens/auth_screens/pin_verification_screen.dart';
import './screens/auth_screens/set_password_screen.dart';

void main() {
  runApp(const TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      initialRoute: SetPasswordScreen.routeName,
      routes: {
        SplashScreen.routeName: (cntxt) => const SplashScreen(),
        LoginScreen.routeName: (cntxt) => const LoginScreen(),
        RegistrationScreen.routeName: (cntxt) => const RegistrationScreen(),
        EmailVerificationScreen.routeName: (cntxt) =>
            const EmailVerificationScreen(),
        PinVerificationScreen.routeName: (cntxt) =>
            const PinVerificationScreen(),
        SetPasswordScreen.routeName: (cntxt) => const SetPasswordScreen(),
      },
    );
  }
}
