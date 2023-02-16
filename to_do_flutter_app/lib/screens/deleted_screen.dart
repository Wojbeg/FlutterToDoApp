import 'package:flutter/material.dart';
import '../blocs/bloc_exports.dart';
import '../widgets/tasks_list.dart';
import 'side_drawer.dart';

class DeletedScreen extends StatelessWidget {
  const DeletedScreen({Key? key}) : super(key: key);

  static const id = 'deleted_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title: const Text("Deleted Tasks"),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null, 
                      icon: const Icon(Icons.delete_forever), 
                      label: const Text("Delete all tasks")
                    ),
                    onTap: () => context
                      .read<TasksBloc>()
                      .add(DeleteAllTasks()),
                  )
                ]
              )
            ],
          ),
          drawer: SideDrawer(initialColor: Theme.of(context).primaryColor),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Chip(
                    label: Text(
                      state.removedTasks.length > 1 
                      ? '${state.removedTasks.length} Deleted Tasks'
                      : '${state.removedTasks.length} Deleted Task',
                    ),
                  ),
                ),
                TasksList(tasksList: state.removedTasks)
              ]),
        );
      },
    );
  }
}
