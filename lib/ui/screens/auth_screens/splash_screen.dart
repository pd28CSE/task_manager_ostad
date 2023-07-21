import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilitys/assets_utils.dart';
import '../../widgets/screen_background.dart';
import './login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash-screen/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToLoginScreen();
    super.initState();
  }

  void navigateToLoginScreen() {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (cntxt) {
              return const LoginScreen();
            },
          ),
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(AssetsUtils.logoSVG),
        ),
      ),
    );
  }
}
