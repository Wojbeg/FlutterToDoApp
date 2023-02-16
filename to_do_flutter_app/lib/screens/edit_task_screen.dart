import 'package:flutter/material.dart';
import 'package:to_do_flutter_app/blocs/bloc_exports.dart';

import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({ 
    Key? key, 
    required this.oldTask
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController titleController = TextEditingController(text: oldTask.title);
    TextEditingController descriptionController = TextEditingController(text: oldTask.description);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Edit Task",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          TextField(
            autofocus: true,
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              label: Text('Description'),
              border: OutlineInputBorder(),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),

              ElevatedButton(
                onPressed: () {
                  var task = Task(
                      id: oldTask.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      isFavorite: oldTask.isFavorite,
                      isDone: false,
                      date: DateTime.now().toString(),
                    );
                  context.read<TasksBloc>().add(EditTask(oldTask: oldTask, newTask: task));
                  Navigator.pop(context);
                }, 

                child: const Text('Save')),
            ],
          ),

        ],
      ),
    );
  }
}
