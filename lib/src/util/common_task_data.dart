import 'package:flutter/material.dart';
import 'package:trimsky_draft/src/pages/tasks_page.dart';
import 'package:trimsky_draft/src/util/task_data.dart';

class TextTaskData extends TaskData {
  final bool isFinished;
  final String name;
  final String? desc;
  const TextTaskData({required this.name, required this.desc, this.isFinished = false});
  
  @override
  Widget toWidget() {
    return TextTask(data: this);
  }

  @override
  bool operator==(Object other) {
    return other is TextTaskData && name == other.name && desc == other.desc && isFinished == other.isFinished;
  }
  
  @override
  int get hashCode => (isFinished ? 1 : 0) ^ name.hashCode;
}