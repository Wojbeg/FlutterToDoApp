import 'package:flutter/material.dart';
import 'package:to_do_flutter_app/screens/add_task_screen.dart';
import 'package:to_do_flutter_app/screens/completed_tasks_screen.dart';
import 'package:to_do_flutter_app/screens/favourite_tasks_screen.dart';
import 'package:to_do_flutter_app/screens/side_drawer.dart';
import 'package:to_do_flutter_app/screens/pending_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'pageName': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'pageName': const FavouriteTasksScreen(), 'title': 'Favourite Tasks'},
  ]; 

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context, {bool isTaskFavorite = false, bool isTaskDone = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: 
                MediaQuery.of(context).viewInsets.bottom
              ),
          child: AddTaskScreen(
            isFavourite: isTaskFavorite,
            isDone: isTaskDone,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageDetails[_selectedPageIndex]['title'],
          style: TextStyle(
            color: Theme.of(context).textTheme.headline5?.color
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              switch(_selectedPageIndex) {
                case 0: 
                  _addTask(context);
                  break;

                case 1:
                  _addTask(context, isTaskDone: true);
                  break;
                
                case 2:
                  _addTask(context, isTaskFavorite: true);
                  break;

                default:
                  _addTask(context);
              }
            },
            icon: Icon(
              Icons.add,
              color: Theme.of(context).textTheme.headline5?.color,
            ),
          )
        ],
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.headline5?.color),
      ),
      drawer: SideDrawer(initialColor: Theme.of(context).primaryColor),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
      ? FloatingActionButton(
          onPressed: () => _addTask(context),
          tooltip: 'Add Task',
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).textTheme.headline5?.color,
          ),
        ) 
      : null,
      bottomNavigationBar:
        BottomNavigationBar(
          currentIndex: _selectedPageIndex, 
          onTap: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          }, 
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.incomplete_circle_sharp ), label: 'Pending Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.done), label: 'Completed Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourite Tasks'),
      ]),
    );
  }
}
