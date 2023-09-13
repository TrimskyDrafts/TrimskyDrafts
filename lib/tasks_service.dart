import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:trimsky_draft/src/dialog_form/text_task_dialog_form.dart';
import 'package:trimsky_draft/src/util/common_task_data.dart';
import 'package:trimsky_draft/src/util/task_category_manager.dart';
import 'package:trimsky_draft/src/util/timer_task_data.dart';

import 'notifications_service.dart';
import 'src/dialog_form/timer_task_dialog_form.dart';

HashMap<String, TaskCategoryManager> categoryManager = HashMap();
late TaskCategoryManager currentCategory;
late Timer timer;
AsyncCallback? tasksPageCallback;

void initTasksData() {
  categoryManager["common"] = TaskCategoryManager<TextTaskData>(
    callback: emptyCheck, 
    builder: (taskData) => TextTaskDialogForm(afterValidationCallback: afterTextTaskValidated, taskData: taskData));

  categoryManager["timers"] = TaskCategoryManager<TimerTaskData>(
    callback: checkDatesExpiring, 
    builder: (taskData) => TimerTaskDialogForm(afterValidationCallback: afterTimerTaskValidated, taskData: taskData));
  
  currentCategory = categoryManager["common"]!;
  timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
    currentCategory.call();
    if(tasksPageCallback != null) {
      tasksPageCallback!();
    }
  });
}

Future<void> checkDatesExpiring(TaskCategoryManager<TimerTaskData> category) async {
  for (int i = 0; i < category.tasks.length; i++) {
    if(!category.tasks[i].isFinished && category.tasks[i].date.isBefore(DateTime.now())) {
      NotificationService.sendNotification(category.tasks[i].name);

      TimerTaskData prevData = category.tasks[i];
      category.tasks.add(TimerTaskData(name: prevData.name, date: prevData.date, 
        desc: prevData.desc, isFinished: true));
      
      category.tasks.removeAt(i);
    }
  }
}

Future<void> emptyCheck(TaskCategoryManager<TextTaskData> category) async {}

void afterTextTaskValidated({TextTaskData? oldData, required TextTaskData data}) {
  if(oldData != null) {
    currentCategory.tasks.remove(oldData);
  }
  currentCategory.tasks.add(data);
}

void afterTimerTaskValidated({TimerTaskData? oldData, required TimerTaskData data}) {
  if(oldData != null) {
    currentCategory.tasks.remove(oldData);
  }
  currentCategory.tasks.add(data);
}