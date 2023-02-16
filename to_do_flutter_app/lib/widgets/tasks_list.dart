import 'package:flutter/material.dart';

import '../models/task.dart';
import 'task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasksList
              .map((task) => ExpansionPanelRadio(
                  value: task.id,
                  headerBuilder: (context, isOpen) => TaskTile(task: task),
                  body: ListTile(
                    title: SelectableText.rich(TextSpan(children: [
                      const TextSpan(
                          text: 'Title: \n', 
                          style: TextStyle(
                            fontWeight: 
                            FontWeight.bold
                            ),
                          ),
                      TextSpan(text: task.title),
                      const TextSpan(
                          text: '\n\nDescription: \n', 
                          style: TextStyle(
                            fontWeight: 
                            FontWeight.bold
                            ),
                          ),
                      TextSpan(text: task.description)
                    ])),
                  )))
              .toList(),
        ),
      ),
    );
  }
}