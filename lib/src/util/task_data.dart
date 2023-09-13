import 'package:flutter/material.dart';

/// Immutable task data that contains the name of the task,
/// an optional description of task and the date when it needs to be completed
abstract class TaskData {
  const TaskData();
  Widget toWidget();
}