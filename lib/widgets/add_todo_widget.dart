import 'package:flutter/material.dart';
import 'package:todo_list/services/database_services.dart';

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({Key? key}) : super(key: key);

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  TextEditingController todoTitleController = TextEditingController();

  @override
  void dispose() {
    todoTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        TextFormField(
          maxLines: 2,
          controller: todoTitleController,
          autofocus: true,
          style: const TextStyle(
            fontSize: 20,
            height: 1.5,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'write your todo',
            hintStyle: const TextStyle(color: Colors.white60),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                todoTitleController.clear();
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: width,
          height: 50,
          child: TextButton(
            onPressed: () async {
              if (todoTitleController.text.isNotEmpty) {
                await DatabaseService()
                    .createNewTodo(todoTitleController.text.trim());
                todoTitleController.clear();
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
