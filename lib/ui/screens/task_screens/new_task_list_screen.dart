import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data/models/network_response.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utilitys/urls.dart';
import '../../utilitys/toast_message.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';
import './add_new_task_screen.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  List<Data> taskList = [];
  bool isLoading = true;

  @override
  void initState() {
    getNewTaskList();
    super.initState();
  }

  @override
  void dispose() {
    taskList.clear();
    super.dispose();
  }

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
              child: Visibility(
                visible: isLoading == true,
                replacement: RefreshIndicator(
                  onRefresh: getNewTaskList,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: taskList.length,
                    itemBuilder: (cntxt, index) {
                      return TaskListTile(
                        task: taskList[index],
                        onDelete: deleteTask,
                      );
                    },
                    separatorBuilder: (cntxt, index) => const Divider(),
                  ),
                ),
                child: const Center(child: CircularProgressIndicator()),
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

  Future<void> getNewTaskList() async {
    final NetworkResponse networkResponse = await NetworkCaller()
        .getTaskListByStatus(url: Urls.getTaskListByStatus, status: 'New');
    if (networkResponse.isSuccess == true) {
      TaskListModel responseBody =
          TaskListModel.fromJson(networkResponse.body!);
      taskList = responseBody.data!;
      if (mounted) {
        isLoading = false;
        setState(() {});
      }
    }
  }

  Future<void> deleteTask(String taskId) async {
    if (mounted) {
      isLoading = true;
      setState(() {});
    }
    final NetworkResponse networkResponse =
        await NetworkCaller().deleteTaskById(url: Urls.deleteTask, id: taskId);

    if (networkResponse.isSuccess == true) {
      showToastMessage('Delete Successful', Colors.green);
      taskList.clear();
      await getNewTaskList();
    } else {
      showToastMessage('Delete request failed!', Colors.red);
    }
  }
}
