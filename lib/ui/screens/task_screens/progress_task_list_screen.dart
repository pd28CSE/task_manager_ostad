import 'package:flutter/material.dart';

import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';

class ProgressTaskListScreen extends StatelessWidget {
  const ProgressTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const UserProfileBanner(
              fullName: 'Partho Debnath',
              userEmail: 'parthodebnath28@gmail.com',
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: 10,
                itemBuilder: (cntxt, index) {
                  return const TaskListTile();
                },
                separatorBuilder: (cntxt, index) => const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
