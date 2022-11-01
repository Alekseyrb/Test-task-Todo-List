import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAYLC37ko3QZQEmNrKVequL9oUZqYCcO0s',
      appId: '1:143945180100:android:650289e234a33fc18afa91',
      messagingSenderId: '143945180100',
      projectId: 'todo-app-55b56',
    ),
  );
  runApp(const Todo());
}
