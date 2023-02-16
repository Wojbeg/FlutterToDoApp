import 'package:flutter/material.dart';
import 'package:to_do_flutter_app/blocs/bloc_exports.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {

  AddTaskScreen({ 
    Key? key,
    this.isFavourite = false,
    this.isDone = false,
  }) : super(key: key);

  bool isFavourite;
  bool isDone;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool _validate = false;

  bool _isFavourite = false;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    _isFavourite = widget.isFavourite;
    _isDone = widget.isDone;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Add Task",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: TextField(
              autofocus: true,
              controller: titleController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                label: const Text('Title'),
                errorText: _validate ? "Title can't be empty!" : null,
                floatingLabelStyle: TextStyle(
                  color: Theme.of(context).primaryColor
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color:Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color:Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (newTitle) {
                setState(() {
                  _validate = titleController.text.trim().isEmpty;
                });
              },
            ),
          ),

          TextField(
            autofocus: true,
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              label: const Text('Description'),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).primaryColor
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:  Theme.of(context).primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                Row(
                  children: [
                    Checkbox(
                      value: _isDone, 
                      onChanged: (newValue) { 
                        setState(() {
                          _isDone = newValue ?? _isDone;
                        });
                      },
                    ),

                    Text(
                      _isDone == true ? "Task done" : "Task undone",
                    ),
                  ],
                ),

                Row(
                  children: [
                    Checkbox(
                      value: _isFavourite, 
                      onChanged: (newValue) { 
                        setState(() {
                          _isFavourite = newValue ?? _isFavourite;
                        });
                      },
                    ),

                    Text(
                      _isFavourite == true ? "Favorite" : "Not favorite",
                    ),
                  ],
                ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle1?.color,
                      ),
                    ),
                ),

                ElevatedButton(
                  onPressed: () {
                    if(titleController.text.trim().isNotEmpty) {
                      var task = Task(
                        id: UniqueKey().toString(),
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                        date: DateTime.now().toString(),
                        isFavorite: _isFavourite,
                        isDone: _isDone,
                      );
                      context.read<TasksBloc>().add(AddTask(task: task));
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _validate = true;
                      });
                    }

                  }, 

                  child: const Text('Add')),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
