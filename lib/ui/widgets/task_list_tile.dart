import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';

class TaskListTile extends StatelessWidget {
  final Future<void> Function(String) onDelete;
  final Data task;
  const TaskListTile({
    required this.task,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title.toString()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(task.description.toString()),
          Text("Date: ${task.createdDate!.replaceAll('-', '/')}"),
          Row(
            children: <Widget>[
              Chip(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                backgroundColor: getColor(task.status.toString()),
                label: Text(
                  task.status.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  deleteConfirmation(context);
                },
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red.shade300,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color getColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blue;
      case 'Cancled':
        return Colors.red;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.purple;
    }
  }

  void deleteConfirmation(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (cntxt) {
        return AlertDialog(
          icon: const Icon(
            Icons.dangerous_outlined,
            size: 50,
            color: Colors.red,
          ),
          title: const Text('Are you sure?'),
          content: const Text('If you delete, you can not get it back.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    ).then((value) async {
      if (value == true) {
        await onDelete(task.sId.toString());
      }
    });
  }
}
