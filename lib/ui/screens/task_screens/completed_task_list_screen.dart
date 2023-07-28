import 'package:flutter/material.dart';

import '../../../data/models/network_response.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utilitys/urls.dart';
import '../../utilitys/toast_message.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  List<Data> taskList = [];
  bool isLoading = true;

  @override
  void initState() {
    getCompletedTaskList();
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
            Expanded(
              child: Visibility(
                visible: isLoading == true,
                replacement: RefreshIndicator(
                  onRefresh: getCompletedTaskList,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: taskList.length,
                    itemBuilder: (cntxt, index) {
                      return TaskListTile(
                        task: taskList[index],
                        onDelete: deleteTask,
                        onStatusUpdate: updateTaskByStatus,
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
    );
  }

  Future<void> getCompletedTaskList() async {
    final NetworkResponse networkResponse = await NetworkCaller()
        .getTaskListByStatus(
            url: Urls.getTaskListByStatus, status: 'Completed');
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
    isLoading = true;
    setState(() {});
    final NetworkResponse networkResponse =
        await NetworkCaller().deleteTaskById(url: Urls.deleteTask, id: taskId);

    if (networkResponse.isSuccess == true) {
      showToastMessage('Delete Successful', Colors.green);
      taskList.clear();
      await getCompletedTaskList();
    } else {
      showToastMessage('Delete request failed!', Colors.red);
    }
  }

  Future<void> updateTaskByStatus(String taskId, String status) async {
    isLoading = true;
    setState(() {});
    final NetworkResponse networkResponse = await NetworkCaller()
        .getRequest('${Urls.updateTaskByStatus}/$taskId/$status');

    if (networkResponse.isSuccess == true) {
      showToastMessage('Update Successful', Colors.green);
      await getCompletedTaskList();
    } else {
      showToastMessage('Update request failed!', Colors.red);
    }
  }
}
