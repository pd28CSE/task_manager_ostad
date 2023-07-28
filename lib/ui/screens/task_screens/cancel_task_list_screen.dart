import 'package:flutter/material.dart';

import '../../../data/models/network_response.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utilitys/urls.dart';
import '../../utilitys/toast_message.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';

class CancleTaskListScreen extends StatefulWidget {
  const CancleTaskListScreen({super.key});

  @override
  State<CancleTaskListScreen> createState() => _CancleTaskListScreenState();
}

class _CancleTaskListScreenState extends State<CancleTaskListScreen> {
  List<Data> taskList = [];
  bool isLoading = true;

  @override
  void initState() {
    getCancledTaskList();
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
                  onRefresh: getCancledTaskList,
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
    );
  }

  Future<void> getCancledTaskList() async {
    final NetworkResponse networkResponse = await NetworkCaller()
        .getTaskListByStatus(url: Urls.getTaskListByStatus, status: 'Cancled');
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
    final NetworkResponse networkResponse =
        await NetworkCaller().deleteTaskById(url: Urls.deleteTask, id: taskId);

    if (networkResponse.isSuccess == true) {
      showToastMessage('Delete Successful', Colors.green);
      await getCancledTaskList();
    } else {
      showToastMessage('Delete request failed!', Colors.red);
    }
  }
}
