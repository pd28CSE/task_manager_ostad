import 'package:flutter/material.dart';

import '../../../data/models/auth_utility.dart';
import '../../../data/models/network_response.dart';
import '../../../data/models/status_count.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utilitys/urls.dart';
import '../../utilitys/toast_message.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';
import '../auth_screens/login_screen.dart';
import './add_new_task_screen.dart';

class NewTaskListScreen extends StatefulWidget {
  final void Function(int) onChangeScreen;
  const NewTaskListScreen({super.key, required this.onChangeScreen});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  late List<Data> taskList;
  late List<TaskStatusModel> taskStatusList;
  late bool isLoading;
  Map<String, int> taskStatus = {
    'Progress': 0,
    'Completed': 0,
    'New': 0,
    'Cancled': 0,
  };

  @override
  void initState() {
    taskList = [];
    taskStatusList = [];
    isLoading = true;
    getNewTaskList();
    getTaskListStatus();
    super.initState();
  }

  @override
  void dispose() {
    taskList.clear();
    taskStatusList.clear();
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
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.onChangeScreen(0);
                    },
                    child:
                        SummaryCard(title: 'New', number: taskStatus['New']!),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.onChangeScreen(1);
                    },
                    child: SummaryCard(
                        title: 'In Progress', number: taskStatus['Progress']!),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.onChangeScreen(2);
                    },
                    child: SummaryCard(
                        title: 'Cancle', number: taskStatus['Cancled']!),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.onChangeScreen(3);
                    },
                    child: SummaryCard(
                        title: 'Completed', number: taskStatus['Completed']!),
                  ),
                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (cntxt) => const AddNewTaskScreen()),
          ).then((value) async {
            await getNewTaskList();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> getNewTaskList() async {
    final NetworkResponse networkResponse =
        await NetworkCaller().getRequest(Urls.taskListByNew);
    if (networkResponse.isSuccess == true) {
      TaskListModel responseBody =
          TaskListModel.fromJson(networkResponse.body!);
      taskList = responseBody.data!;
      await getTaskListStatus();
      if (mounted) {
        isLoading = false;
        setState(() {});
      }
    } else if (networkResponse.isSuccess == false) {
      await goToLoginScreen();
    }
  }

  Future<void> getTaskListStatus() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse networkResponse =
        await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (networkResponse.isSuccess == true) {
      StatusCount responseBody = StatusCount.fromJson(networkResponse.body!);
      taskStatusList = responseBody.data!;

      for (var data in taskStatusList) {
        taskStatus[data.sId!] = data.sum!;
      }

      if (mounted) {
        isLoading = false;
        setState(() {});
      }
    } else if (networkResponse.isSuccess == false) {
      // await goToLoginScreen();
    }
  }

  Future<void> deleteTask(String taskId) async {
    if (mounted) {
      isLoading = true;
      setState(() {});
    }
    final NetworkResponse networkResponse =
        await NetworkCaller().getRequest(Urls.taskDeleteById(taskId));

    if (networkResponse.isSuccess == true) {
      showToastMessage('Delete Successful', Colors.green);
      taskList.removeWhere((task) => task.sId == taskId);
    } else {
      showToastMessage('Delete request failed!', Colors.red);
    }
  }

  Future<void> goToLoginScreen() async {
    await AuthUtility.clearUserInfo();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (cntxt) {
            return const LoginScreen();
          },
        ),
        (route) => false,
      );
    }
  }

  Future<void> updateTaskByStatus(String taskId, String status) async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse networkResponse =
        await NetworkCaller().getRequest(Urls.taskSatusUpdate(taskId, status));

    if (networkResponse.isSuccess == true) {
      showToastMessage('Update Successful', Colors.green);
      await getNewTaskList();
    } else {
      showToastMessage('Update request failed!', Colors.red);
    }
  }
}
