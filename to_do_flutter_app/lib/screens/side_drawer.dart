
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:to_do_flutter_app/screens/deleted_screen.dart';
import 'package:to_do_flutter_app/screens/tabs_screen.dart';

import '../blocs/bloc_exports.dart';

class SideDrawer extends StatefulWidget {
  final Color initialColor;

  const SideDrawer({
    Key? key,
    required this.initialColor,
  }) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  late Color pickerColor;

  @override
  void initState() {
    pickerColor = widget.initialColor;
    super.initState();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: Text(
                'Pick Your color',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline5?.color
                ),
              ),
              content: SingleChildScrollView(
                  child: HueRingPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
              )),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1?.color
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),

                TextButton(
                    child: Text(
                      'Select',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle1?.color
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        context
                            .read<ColorBloc>()
                            .add(ChangeColorEvent(newColor: pickerColor));
                      });
                      Navigator.of(context).pop();
                    })
              ]));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //wywalić
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Theme.of(context).primaryColor,
              child: BlocBuilder<SwitchBloc, SwitchState>(
                  builder: (context, state) {
                return Text('Task Drawer',
                    style: Theme.of(context).textTheme.headline5
                );
              }),
            ),

            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(TabsScreen.id),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text('My Tasks'),
                    trailing: Text(
                        '${state.pendingTasks.length} | ${state.completedTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(DeletedScreen.id),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Deleted'),
                    trailing: Text('${state.removedTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return ListTile(
                  title: state.switchValue
                      ? const Text("Night mode:")
                      : const Text("Light mode:"),
                  trailing: DayNightSwitcher(
                    isDarkModeEnabled: state.switchValue,
                    onStateChanged: (newValue) {
                      newValue
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                    },
                  ),
                );
              },
            ),
            const Divider(),

            ListTile(
                title: const Text("Main color:"),
                trailing: RawMaterialButton(
                  onPressed: () => pickColor(context),
                  elevation: 2.0,
                  fillColor: Theme.of(context).primaryColor,
                  child: null,
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                )),

            ListTile(
              trailing: TextButton(
                  onPressed: () {
                    context.read<ColorBloc>().add(ResetColorEvent());
                  },
                  child: Text(
                    "Reset color",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1?.color
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
