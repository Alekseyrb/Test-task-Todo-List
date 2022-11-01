import 'package:flutter/material.dart';
import 'package:todo_list/widgets/add_todo_widget.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'package:todo_list/model/todo_model.dart';
import 'package:todo_list/services/database_services.dart';
import 'package:todo_list/widgets/todo_list_widget.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<TodoModel>?>(
          stream: DatabaseService().listTodos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loading();
            }
            return Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'All Todos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: Colors.grey[600],
                      height: 2,
                    ),
                    const SizedBox(height: 10),
                    const AddTodoWidget(),
                    const SizedBox(height: 20),
                    TodoListWidget(snapshot: snapshot),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
