import 'package:flutter/material.dart';

import '../../../data/models/network_response.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utilitys/urls.dart';
import '../../utilitys/toast_message.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  List<Data> taskList = [];
  bool isLoading = true;

  @override
  void initState() {
    getProgressTaskList();
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
      body: ScreenBackground(
        child: Column(
          children: <Widget>[
            const UserProfileBanner(),
            const SizedBox(height: 10),
            Expanded(
              child: Visibility(
                visible: isLoading == true,
                replacement: RefreshIndicator(
                  onRefresh: getProgressTaskList,
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

  Future<void> getProgressTaskList() async {
    final NetworkResponse networkResponse =
        await NetworkCaller().getRequest(Urls.taskListByProgress);
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
        await NetworkCaller().getRequest(Urls.taskDeleteById(taskId));

    if (networkResponse.isSuccess == true) {
      showToastMessage('Delete Successful', Colors.green);
      taskList.clear();
      taskList.removeWhere((task) => task.sId == taskId);
    } else {
      showToastMessage('Delete request failed!', Colors.red);
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> updateTaskByStatus(String taskId, String status) async {
    isLoading = true;
    setState(() {});
    final NetworkResponse networkResponse =
        await NetworkCaller().getRequest(Urls.taskSatusUpdate(taskId, status));

    if (networkResponse.isSuccess == true) {
      showToastMessage('Update Successful', Colors.green);
      await getProgressTaskList();
    } else {
      showToastMessage('Update request failed!', Colors.red);
    }
  }
}
