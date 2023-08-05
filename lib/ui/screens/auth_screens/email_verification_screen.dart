import 'package:flutter/material.dart';
import 'package:testtaskmanager/data/utilitys/urls.dart';

import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../utilitys/toast_message.dart';
import '../../widgets/screen_background.dart';
import './pin_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const String routeName = 'email-verification-screen/';
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late bool isLoading;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 1),
                Text(
                  '6 digit verification pin will send to your email address.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildSubmitButton() {
    return ElevatedButton(
      onPressed: isLoading == true
          ? null
          : () {
              if (formKey.currentState!.validate() == false) {
                return;
              } else {
                verifyUserEmail(emailController.text.trim());
              }
            },
      child: Visibility(
        visible: isLoading == false,
        replacement: const CircularProgressIndicator(color: Colors.green),
        child: const Text('Next'),
      ),
    );
  }

  Future<void> verifyUserEmail(String email) async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse networkResponse =
        await NetworkCaller().getRequest(Urls.userRecoverVerifyEmail(email));
    if (networkResponse.body!['status'] == 'success') {
      formKey.currentState!.reset();
      showToastMessage('6 digit verification pin is send.', Colors.green);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (cntxt) => PinVerificationScreen(email: email),
          ),
        );
      }
    } else {
      showToastMessage('Enter valid email!', Colors.red);
    }
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }
}
