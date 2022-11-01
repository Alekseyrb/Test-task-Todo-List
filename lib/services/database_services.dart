import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/todo_model.dart';

class DatabaseService {
  CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('Todos');

  Future createNewTodo(String title) async {
    return await todosCollection.add({
      'title': title,
      'isComplete': false,
    });
  }

  Future completeTask(id) async {
    await todosCollection.doc(id).update({'isComplete': true});
  }

  Future notCompleteTask(id) async {
    await todosCollection.doc(id).update({'isComplete': false});
  }

  Future removeTodo(id) async {
    await todosCollection.doc(id).delete();
  }

  List<TodoModel>? todoFromFirestore(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return TodoModel(
        id: e.id,
        title: (e.data() as dynamic)!['title'],
        isComplete: (e.data() as dynamic)!['isComplete'],
      );
    }).toList();
  }

  Stream<List<TodoModel>?> listTodos() {
    return todosCollection.snapshots().map(todoFromFirestore);
  }
}
