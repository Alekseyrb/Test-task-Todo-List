import 'package:flutter/material.dart';
import 'package:todo_list/services/database_services.dart';

import '../model/todo_model.dart';

class TodoListWidget extends StatelessWidget {
  final AsyncSnapshot<List<TodoModel>?> snapshot;

  const TodoListWidget({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TodoModel>? todos = snapshot.data;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: todos?.length ?? 0,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(todos![index].title),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(Icons.delete, size: 28,),
          ),
          onDismissed: (direction) async {
            await DatabaseService().removeTodo(todos[index].id);
          },
          child: _TodoListItemWidget(
            todos: todos,
            index: index,
            context: context,
          ),
        );
      },
    );
  }
}

Widget _TodoListItemWidget({
  required List<TodoModel> todos,
  required int index,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      onTap: () {
        DatabaseService().completeTask(todos[index].id);
      },
      onLongPress: () {
        DatabaseService().notCompleteTask(todos[index].id);
      },
      leading: Container(
        padding: const EdgeInsets.all(2),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: todos[index].isComplete
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : const SizedBox(),
      ),
      title: Text(
        todos[index].title,
        style: TextStyle(
          color: Colors.grey[200],
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      // );
    ),
  );
}
