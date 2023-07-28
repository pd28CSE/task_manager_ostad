import 'package:flutter/material.dart';

import '../../../data/models/auth_utility.dart';
import '../../../data/models/network_response.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utilitys/urls.dart';
import '../../utilitys/toast_message.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';
import '../auth_screens/login_screen.dart';
import './add_new_task_screen.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  late List<Data> taskList;
  late bool isLoading;

  @override
  void initState() {
    taskList = [];
    isLoading = true;
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
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
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
    } else if (networkResponse.isSuccess == false) {
      await goToLoginScreen();
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
      await getNewTaskList();
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
    final NetworkResponse networkResponse = await NetworkCaller()
        .getRequest('${Urls.updateTaskByStatus}/$taskId/$status');

    if (networkResponse.isSuccess == true) {
      showToastMessage('Update Successful', Colors.green);
      await getNewTaskList();
    } else {
      showToastMessage('Update request failed!', Colors.red);
    }
  }
}
