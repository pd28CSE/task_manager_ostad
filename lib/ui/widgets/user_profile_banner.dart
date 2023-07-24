import 'package:flutter/material.dart';

import '../screens/profile_screens/profile_update_screen.dart';

class UserProfileBanner extends StatelessWidget {
  final String fullName;
  final String userEmail;
  const UserProfileBanner({
    super.key,
    required this.fullName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.green,
      leading: const CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80'),
      ),
      title: Text(
        fullName,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        userEmail,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (cntxt) => const ProfileUpdateScreen()),
        );
      },
    );
  }
}
