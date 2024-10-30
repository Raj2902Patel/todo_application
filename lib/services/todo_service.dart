import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection("todoApp");

  //createTask
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  //updateTask
  void updateTask(String? docID, bool? valueUpdate) {
    todoCollection.doc(docID).update({
      'isDone': valueUpdate,
    });
  }

  //deleteTask
  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }

  Future<void> checkAndDeleteOldTasks() async {
    final prefs = await SharedPreferences.getInstance();

    // Get last accessed date
    final lastDateString = prefs.getString('lastAccessedDate');
    final lastDate =
        lastDateString != null ? DateTime.parse(lastDateString) : null;

    final currentDate = DateTime.now();
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final formattedCurrentDate = dateFormatter.format(currentDate);

    // If the date has changed, delete all tasks
    if (lastDate == null ||
        dateFormatter.format(lastDate) != formattedCurrentDate) {
      await deleteAllTasks();
      await prefs.setString('lastAccessedDate', formattedCurrentDate);
    }
  }

  Future<void> deleteAllTasks() async {
    final snapshot = await todoCollection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
