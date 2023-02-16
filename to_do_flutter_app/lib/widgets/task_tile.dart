import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_flutter_app/screens/edit_task_screen.dart';
import 'package:to_do_flutter_app/widgets/popup_task_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOdReleteTask(BuildContext ctx, Task task) {
    task.isDeleted! 
      ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
      : ctx.read<TasksBloc>().add(RemoveTask(task: task)); 

    Fluttertoast.showToast(
      msg: task.isDeleted! 
        ? "Task: ${task.title} was deleted"
        :  "Task: ${task.title} was removed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
    ); 
  }

  void _addToFavorite(BuildContext ctx, Task task, bool isTryingToAdd) {
    ctx.read<TasksBloc>().add(AddRemoveFavorite(task: task));
    Fluttertoast.showToast(
      msg: isTryingToAdd 
        ? "Task: ${task.title} was added to favorite"
        :  "Task: ${task.title} was removed from favorite",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  void _editTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx, 
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),   
          child: EditTaskScreen(
            oldTask: task,
          ), 
        ),
      ) 
    );
  }

  void _restoreTask(BuildContext ctx, Task task) {
    ctx.read<TasksBloc>().add(RestoreTask(taskToRestore: task));

    Fluttertoast.showToast(
      msg: "Task: ${task.title} is restored",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  void _markTaskFinished(BuildContext ctx, Task task, bool isCompleted) {
    ctx.read<TasksBloc>().add(UpdateTask(task: task));

    Fluttertoast.showToast(
      msg: 
      isCompleted
        ? "Task: ${task.title} is now set as completed"
        : "Task: ${task.title} is now set as pending",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false 
                ? IconButton(
                    icon: Icon(
                      Icons.star_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => _addToFavorite(context, task, true),
                  )
                : IconButton(
                    icon: Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                      ),
                    onPressed: () => _addToFavorite(context, task, false),
                  ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                          decoration: 
                            task.isDone! 
                            ? TextDecoration.lineThrough
                            : null
                        ),
                      ),
                      Text(
                        DateFormat().add_yMMMd().add_Hms().format(DateTime.parse(task.date)),
                      ),
                    ],
                  )
                )
              ],
            )
          ),
          Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                onChanged: (v) => _markTaskFinished(context, task, v ?? false), 
                value: task.isDone,
              ),

              PopupTaskMenu(
                task: task,
                cancelOrDeleteCallback: () => _removeOdReleteTask(context, task), 
                addToFavoriteCallback: () => _addToFavorite(context, task, true), 
                removeFavoriteCallback: () => _addToFavorite(context, task, false), 
                restoreCallback: () => _restoreTask(context, task),
                editCallback: () { 
                  Navigator.of(context).pop();
                  _editTask(context);
                },
                ),
            ],
          ),
          
        ],
      ),
    );
}
}