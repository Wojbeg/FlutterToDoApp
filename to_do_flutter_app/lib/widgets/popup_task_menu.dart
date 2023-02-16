
import 'package:flutter/material.dart';
import 'package:to_do_flutter_app/models/task.dart';

class PopupTaskMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback addToFavoriteCallback;
  final VoidCallback removeFavoriteCallback;
  final VoidCallback editCallback;
  final VoidCallback restoreCallback;

  const PopupTaskMenu({
    Key? key,
    required this.task,
    required this.cancelOrDeleteCallback,
    required this.addToFavoriteCallback,
    required this.removeFavoriteCallback,
    required this.editCallback,
    required this.restoreCallback,
    }
    ) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return PopupMenuButton(
    itemBuilder: task.isDeleted == false 
    ? ((context) => 
      [
        PopupMenuItem(onTap: null,
        child: 
          TextButton.icon(
            onPressed: editCallback, 
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).textTheme.subtitle1?.color,
            ), 
            label: Text(
              'Edit',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1?.color
              ),
            ),
          ),
        ),

        PopupMenuItem(
          onTap: task.isFavorite == false 
            ? addToFavoriteCallback
            : removeFavoriteCallback,
          child: 
          TextButton.icon(
            onPressed: null, 
            icon: task.isFavorite == false 
            ? Icon(
              Icons.bookmark_add,
                color: Theme.of(context).textTheme.subtitle1?.color
            ) 
            : Icon(
              Icons.bookmark_remove,
                color: Theme.of(context).textTheme.subtitle1?.color
            ), 
            label: task.isFavorite == false 
            ? Text(
              "Add to \nfavourites",
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1?.color
              ),
            ) 
            : Text(
              'Remove from \nfavourites',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1?.color
              ),
            ),
          ),
        ),

        PopupMenuItem(onTap: cancelOrDeleteCallback,
        child: 
          TextButton.icon(
            onPressed: null, 
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).textTheme.subtitle1?.color
            ), 
            label: Text(
              'Delete',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1?.color
              ),
            ),
          ),
        ),
      ]
      )
      : (context) => [
        PopupMenuItem(onTap: restoreCallback,
        child: 
          TextButton.icon(
            onPressed: restoreCallback, 
            icon: Icon(
              Icons.restore_from_trash,
              color: Theme.of(context).textTheme.subtitle1?.color
            ), 
            label: Text(
              'Restore',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1?.color
              ),
            ),
          ),
        ),
        PopupMenuItem(onTap: cancelOrDeleteCallback,
        child: 
          TextButton.icon(
            onPressed: null, 
            icon: Icon(
              Icons.delete_forever,
              color: Theme.of(context).textTheme.subtitle1?.color
            ), 
            label: Text(
              'Delete Forever',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1?.color
              ),
            ),
          ),
        ),
      ]
    );
  }
}