import 'package:flutter/material.dart';
import 'package:trimsky_draft/src/pages/tasks_page.dart';
import 'package:trimsky_draft/src/util/task_data.dart';

class TimerTaskData extends TaskData {
  final bool isFinished;
  final String name;
  final String? desc;
  final DateTime date;
  const TimerTaskData({required this.name, required this.date, this.desc, this.isFinished = false});
  
  @override
  Widget toWidget() {
    return TimerTask(data: this);
  }

  @override
  bool operator==(Object other) {
    return other is TimerTaskData && date == other.date && name == other.name && desc == other.desc && isFinished == other.isFinished;
  }
  
  @override
  int get hashCode => (date.hashCode + (isFinished ? 1 : 0)) ^ desc.hashCode;
}