import 'package:flutter/material.dart';

import '../../data/models/auth_utility.dart';
import '../../data/models/user_model.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/profile_screens/profile_update_screen.dart';

class UserProfileBanner extends StatefulWidget {
  final String? fullName;
  final String? userEmail;
  final bool? isCurrectPageIsProfile;
  const UserProfileBanner({
    this.isCurrectPageIsProfile,
    this.fullName,
    this.userEmail,
    super.key,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  late AuthUserModel authUserModel;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.green,
      leading: Visibility(
        visible: authUserModel.data!.photo != '',
        replacement: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: Icon(Icons.person),
        ),
        child: const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80'),
        ),
      ),
      title: Text(
        '${authUserModel.data!.firstName} ${authUserModel.data!.lastName}',
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        '${authUserModel.data!.email}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthUtility.clearUserInfo();
          Future.delayed(Duration.zero).then((value) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (cntxt) {
                return const LoginScreen();
              }),
              (route) => false,
            );
          });
        },
        icon: const Icon(Icons.logout),
      ),
      onTap: widget.isCurrectPageIsProfile == true
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (cntxt) => const ProfileUpdateScreen(),
                ),
              );
            },
    );
  }

  Future<void> getUserData() async {
    authUserModel = AuthUtility.userModel;
  }
}
