import 'package:flutter/material.dart';

import 'package:to_do_flutter_app/blocs/bloc_exports.dart';
import 'package:to_do_flutter_app/models/task.dart';

import '../widgets/tasks_list.dart';

class FavouriteTasksScreen extends StatelessWidget {
  const FavouriteTasksScreen({Key? key}) : super(key: key);
  static const id = 'tasks_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.favoriteTasks;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  tasksList.length > 1 
                  ? '${tasksList.length} Favourite Tasks'
                  : '${tasksList.length} Favourite Tasks',
                ),
              ),
            ),
            TasksList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
