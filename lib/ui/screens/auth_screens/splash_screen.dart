import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../styles/style.dart';
import '../../utilitys/assets_utils.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            screenBackground(context),
            SizedBox(
              child: SvgPicture.asset(AssetsUtils.logoSVG),
            ),
          ],
        ),
      ),
    );
  }
}
