import 'package:flutter/material.dart';

import '../../../data/models/auth_utility.dart';
import '../../../data/models/network_response.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utilitys/urls.dart';
import '../../utilitys/toast_message.dart';
import '../../widgets/screen_background.dart';
import '../task_screens/bottom_nav_base_screen.dart';
import './email_verification_screen.dart';
import './registrations_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login-screen/';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late bool isPasswordHidden;
  late bool signinInProgress;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isPasswordHidden = true;
    signinInProgress = false;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Learn with rabbil hasan',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
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
                      obscureText: isPasswordHidden,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    buildSubmitButton(),
                    const SizedBox(height: 16.0),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (cntxt) =>
                                  const EmailVerificationScreen(),
                            ),
                          );
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Don\'t have an account?'),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (cntxt) => const RegistrationScreen(),
                              ),
                            );
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildSubmitButton() {
    return ElevatedButton(
      onPressed: signinInProgress == true
          ? null
          : () {
              if (formKey.currentState!.validate() == false) {
                return;
              } else {
                userSignIn();
              }
            },
      child: Visibility(
        visible: signinInProgress == false,
        replacement: const CircularProgressIndicator(color: Colors.green),
        child: const Text('Login'),
      ),
    );
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> userSignIn() async {
    signinInProgress = true;
    if (mounted == true) {
      setState(() {});
    }

    final Map<String, dynamic> requestBody = {
      'email': emailController.text.trim(),
      'password': passwordController.text,
    };

    final NetworkResponse networkResponse = await NetworkCaller().postRequest(
      url: Urls.login,
      body: requestBody,
    );

    signinInProgress = false;
    if (mounted == true) {
      setState(() {});
    }
    if (networkResponse.isSuccess == true) {
      AuthUserModel authUserModel =
          AuthUserModel.fromJson(networkResponse.body!);
      await AuthUtility.saveUserInfo(authUserModel);
      clearForm();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (cntxt) => const BottomNavBaseScreen(),
          ),
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        showToastMessage('Incorrect email or password!', Colors.red);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Incorrect email or password!'),
        //   ),
        // );
      }
    }
  }
}
