import 'dart:developer';

import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../utilitys/task_status_options.dart';

class TaskListTile extends StatefulWidget {
  final Future<void> Function(String) onDelete;
  final Future<void> Function(String, String) onStatusUpdate;
  final Data task;
  const TaskListTile({
    required this.task,
    required this.onDelete,
    required this.onStatusUpdate,
    super.key,
  });

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  late TaskStatusList currentStatus;

  @override
  void initState() {
    initialStatus();
    super.initState();
  }

  void initialStatus() {
    if (widget.task.status!.contains(TaskStatusList.New.name)) {
      currentStatus = TaskStatusList.New;
    } else if (widget.task.status!.contains(TaskStatusList.Progress.name)) {
      currentStatus = TaskStatusList.Progress;
    } else if (widget.task.status!.contains(TaskStatusList.Completed.name)) {
      currentStatus = TaskStatusList.Completed;
    } else if (widget.task.status!.contains(TaskStatusList.Cancled.name)) {
      currentStatus = TaskStatusList.Cancled;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title.toString()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(widget.task.description.toString()),
          Text("Date: ${widget.task.createdDate!.replaceAll('-', '/')}"),
          Row(
            children: <Widget>[
              Chip(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                backgroundColor: getColor(widget.task.status.toString()),
                label: Text(
                  widget.task.status.toString(),
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
      onLongPress: () {
        showTaskStatus(context);
      },
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
        await widget.onDelete(widget.task.sId.toString());
      }
    });
  }

  void showTaskStatus(BuildContext context) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      showDragHandle: true,
      context: context,
      builder: (cntxt1) {
        return StatefulBuilder(builder: (cntxt, newState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RadioListTile<TaskStatusList>(
                  title: Text(TaskStatusList.New.name),
                  value: TaskStatusList.New,
                  groupValue: currentStatus,
                  onChanged: (value) {
                    newState(() {
                      currentStatus = value!;
                    });
                  },
                ),
                RadioListTile<TaskStatusList>(
                  title: Text(TaskStatusList.Progress.name),
                  value: TaskStatusList.Progress,
                  groupValue: currentStatus,
                  onChanged: (value) {
                    newState(() {
                      currentStatus = value!;
                    });
                  },
                ),
                RadioListTile<TaskStatusList>(
                  title: Text(TaskStatusList.Cancled.name),
                  value: TaskStatusList.Cancled,
                  groupValue: currentStatus,
                  onChanged: (value) {
                    newState(() {
                      currentStatus = value!;
                    });
                  },
                ),
                RadioListTile<TaskStatusList>(
                  title: Text(TaskStatusList.Completed.name),
                  value: TaskStatusList.Completed,
                  groupValue: currentStatus,
                  onChanged: (value) {
                    newState(() {
                      currentStatus = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                buildButton(cntxt, newState),
              ],
            ),
          );
        });
      },
    );
  }

  ElevatedButton buildButton(
      BuildContext cntxt, void Function(void Function()) newState) {
    return ElevatedButton(
      onPressed: () async {
        if (mounted) {
          newState(() {});
        }
        log(mounted.toString());
        //  if (mounted) {
        Navigator.pop(cntxt);
        // }
        await widget.onStatusUpdate(widget.task.sId!, currentStatus.name);
      },
      child: const Text('Confirm'),
    );
  }
}
