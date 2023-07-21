import 'package:flutter/material.dart';

import './ui/screens/auth_screens/splash_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        brightness: Brightness.light,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1.0),
          // border: InputBorder.none,
          outlineBorder: BorderSide.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
