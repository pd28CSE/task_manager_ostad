import 'package:flutter/material.dart';

import '../../widgets/summary_card.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';
import './add_new_task_screen.dart';

class NewTaskListScreen extends StatelessWidget {
  const NewTaskListScreen({super.key});

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
            const Row(
              children: <Widget>[
                Expanded(child: SummaryCard(title: 'New', number: 10)),
                Expanded(child: SummaryCard(title: 'In Progress', number: 10)),
                Expanded(child: SummaryCard(title: 'Cancle', number: 10)),
                Expanded(child: SummaryCard(title: 'Completed', number: 10)),
              ],
            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (cntxt) => const AddNewTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
