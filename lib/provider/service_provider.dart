import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';

final serviceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});

final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  try {
    final getData = FirebaseFirestore.instance
        .collection('todoApp')
        .snapshots()
        .map((event) => event.docs
            .map((snapshot) => TodoModel.fromSnapshot(snapshot))
            .toList());

    yield* getData;
  } catch (error) {
    debugPrint('Error fetching stream data: $error');
    yield [];
  }
});
