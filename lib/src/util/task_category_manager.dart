import 'package:flutter/material.dart';
import 'package:trimsky_draft/src/util/task_data.dart';

/// Tasks category class
/// If callback is null then no callback will be called
class TaskCategoryManager<T extends TaskData> {
  Future<void> Function(TaskCategoryManager<T> category) _callback = (category) async {};
  final List<T> tasks = <T>[];
  Widget Function(T? taskData) builder;

  TaskCategoryManager({
    Future<void> Function(TaskCategoryManager<T> category) ?callback,
    required this.builder}) {

    if(callback != null) _callback = callback;
  }

  Future<void> call() async {
    _callback(this);
  }

  Widget buildDialogForm(T? taskData) {
    return builder(taskData);
  }

  Future<void> showDialogForm(State state, {T? taskData}) async {
    return showDialog(context: state.context, builder: (context) {
      return AlertDialog(content: buildDialogForm(taskData));
    });
  }
}