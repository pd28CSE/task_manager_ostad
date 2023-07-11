import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles/style.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash-screen/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            screenBackground(context),
            SizedBox(
              child: SvgPicture.asset('assets/images/logo.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
