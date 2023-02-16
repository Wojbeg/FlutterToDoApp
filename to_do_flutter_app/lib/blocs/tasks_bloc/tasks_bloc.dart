import 'package:equatable/equatable.dart';
import 'package:to_do_flutter_app/models/task.dart';

import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<AddRemoveFavorite>(_onAddRemoveFavorite);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> pendingTasks = List.from(state.pendingTasks);
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if(event.task.isDone ?? false) {
      completedTasks.add(event.task);
    } else {
      pendingTasks.add(event.task);
    }

    if(event.task.isFavorite ?? false) {
      favoriteTasks.add(event.task);
    }

    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if(task.isDone == false) {
      pendingTasks = List.from(pendingTasks)..remove(task);
      completedTasks.insert(0, task.copyWith(isDone: true));

      if(task.isFavorite != false) {
        var taskIndex = favoriteTasks.indexOf(task);
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {

      completedTasks = List.from(completedTasks)..remove(task);
      pendingTasks = List.from(pendingTasks)
        ..insert(0, task.copyWith(isDone: false));
        
      if(task.isFavorite != false) {
        var taskIndex = favoriteTasks.indexOf(task);
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }

    // task.isDone == false
    //     ? {
    //         pendingTasks = List.from(pendingTasks)..remove(task),
    //         completedTasks = List.from(completedTasks)
    //           ..insert(0, task.copyWith(isDone: true)),
    //       }
    //     : {
    //         completedTasks = List.from(completedTasks)..remove(task),
    //         pendingTasks = List.from(pendingTasks)
    //           ..insert(0, task.copyWith(isDone: false)),
    //       };

    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true)),
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task)
      )
    );
  }

  void _onAddRemoveFavorite(AddRemoveFavorite event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if(event.task.isDone == false) {
      var taskIndex = pendingTasks.indexOf(event.task);
      if(event.task.isFavorite == false) {
        
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {

        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      var taskIndex = completedTasks.indexOf(event.task);

      if(event.task.isFavorite == false) {

        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {

        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }

    emit(
      TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      )
    );
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouiteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favouiteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }

    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: state.completedTasks..remove(event.oldTask),
        favoriteTasks: favouiteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    bool isCompleted = event.taskToRestore.isDone ?? false;
    bool isFavorite = event.taskToRestore.isFavorite ?? false;
    Task taskToAdd = event.taskToRestore.copyWith(isDeleted: false);

    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..remove(event.taskToRestore),
        pendingTasks: List.from(state.pendingTasks)..insert(0, taskToAdd),
        completedTasks: isCompleted ? (List.from(state.completedTasks)..insert(0, taskToAdd)) : state.completedTasks,
        favoriteTasks: isFavorite ? (List.from(state.favoriteTasks)..insert(0, taskToAdd)) : state.favoriteTasks,
      )
    );
  }

  void _onDeleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      )
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
