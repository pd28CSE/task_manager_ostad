import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../../data/models/auth_utility.dart';
import '../../../data/models/user_model.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/user_profile_banner.dart';

class ProfileUpdateScreen extends StatefulWidget {
  static const String routeName = 'registration-screen/';
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  late GlobalKey<FormState> formKey;
  late bool isPasswordHidden;
  late bool isConfirmPasswordHidden;
  late Map<String, String> userData;
  late TextEditingController imagePathController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNoController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    AuthUserModel authUserModel = AuthUtility.userModel;
    userData = {
      'email': authUserModel.data!.email!,
      'mobile': authUserModel.data!.mobile!,
      'firstName': authUserModel.data!.firstName!,
      'lastName': authUserModel.data!.lastName!,
    };
    formKey = GlobalKey<FormState>();
    isPasswordHidden = true;
    isConfirmPasswordHidden = true;
    imagePathController = TextEditingController();
    firstNameController = TextEditingController(text: userData['firstName']);
    lastNameController = TextEditingController(text: userData['lastName']);
    phoneNoController = TextEditingController(text: userData['mobile']);
    emailController = TextEditingController(text: userData['email']);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    userData.clear();
    imagePathController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: <Widget>[
            const Material(
              elevation: 8,
              child: UserProfileBanner(
                isCurrectPageIsProfile: true,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Update Profile',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: imagePathController,
                          decoration: InputDecoration(
                            prefixIcon: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black54,
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                await pickImageFromGallery();
                              },
                              child: const Text('Image'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your last name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: phoneNoController,
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your mobile number';
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
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          obscureText: isPasswordHidden,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter new password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordHidden =
                                      !isConfirmPasswordHidden;
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
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your Confirm Password';
                            } else if (value!.length < 8) {
                              return 'Minimum length must be 8 characters long';
                            } else if (value != passwordController.text) {
                              return 'Password and Confirm Password is not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() == true) {
                              formKey.currentState!.reset();
                            }
                          },
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ImageSource?> storageSelection() {
    return showDialog<ImageSource?>(
      context: context,
      builder: (cntxt) {
        return AlertDialog(
            content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              onTap: () {
                if (mounted) {
                  Navigator.pop(context, ImageSource.camera);
                }
              },
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Camera'),
            ),
            ListTile(
              onTap: () {
                if (mounted) {
                  Navigator.pop(context, ImageSource.gallery);
                }
              },
              leading: const Icon(Icons.camera),
              title: const Text('Gallery'),
            ),
          ],
        ));
      },
    );
  }

  Future<void> pickImageFromGallery() async {
    try {
      ImageSource? imageSource = await storageSelection();
      if (imageSource == null) {
        return;
      }
      final XFile? image = await ImagePicker().pickImage(source: imageSource);
      print(image?.path);
      if (image != null) {
        imagePathController.text = image.name;
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
