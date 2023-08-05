import 'package:flutter/material.dart';

import '../../data/models/auth_utility.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/profile_screens/profile_update_screen.dart';

class UserProfileBanner extends StatelessWidget {
  final bool? isCurrectPageIsProfile;
  const UserProfileBanner({
    this.isCurrectPageIsProfile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: isCurrectPageIsProfile == true
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (cntxt) => const ProfileUpdateScreen(),
                  ),
                );
              },
        child: Row(
          children: <Widget>[
            Visibility(
              visible: isCurrectPageIsProfile == null,
              child: const Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80'),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${AuthUtility.userModel.data?.firstName ?? ''} ${AuthUtility.userModel.data?.lastName ?? ''}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AuthUtility.userModel.data?.email ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () async {
            await AuthUtility.clearUserInfo();
            Future.delayed(Duration.zero).then((value) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (cntxt) {
                    return const LoginScreen();
                  },
                ),
                (route) => false,
              );
            });
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
