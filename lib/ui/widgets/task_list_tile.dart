import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('gsdg'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Title will be here'),
          const Text('Date'),
          Row(
            children: <Widget>[
              const Chip(
                backgroundColor: Colors.blue,
                label: Text(
                  'New',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
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
}
