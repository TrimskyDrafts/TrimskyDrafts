import 'package:flutter/material.dart';
import 'package:trimsky_draft/src/util/common_task_data.dart';
import 'package:trimsky_draft/src/util/const_values.dart';

import 'package:trimsky_draft/tasks_service.dart';
import 'package:trimsky_draft/src/util/timer_task_data.dart';

part 'tasks_page/add_action.dart';
part 'tasks_page/timer_task.dart';
part 'tasks_page/text_task.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    tasksPageCallback = () async => setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    tasksPageCallback = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      makeActionPanel(context),
      const VerticalDivider(),
      makeCategoryPanel(context),
      const VerticalDivider(),
      Expanded(child: ListView.builder(
        primary: false,
        itemCount: currentCategory.tasks.length,
        itemBuilder: (context, index) => buildTaskWidgetWithIndex(index)
      )),
    ]);
  }

  void onTap() async {
    await currentCategory.showDialogForm(this);
    setState(() {});
  }

  Widget makeCategoryPanel(BuildContext context) {
    return Column(children: [
      TextButton(
        child: const Text("Common", style: Styles.titleName),
        onPressed: () {
          setState(() => currentCategory = categoryManager["common"]!);
        }
      ),
      const Divider(height: 15),
      TextButton(
        child: const Text("Timers", style: Styles.titleName),
        onPressed: () {
          setState(() => currentCategory = categoryManager["timers"]!);
        },
      ),
      // TODO: Add categories panel and sorting
    ]);
  }

  Widget makeActionPanel(BuildContext context) {
    return SizedBox(
            height: double.infinity, 
            width: 30,
            child: Column(children: [
              // Actions list
              AddAction(onTap: onTap)
            ]),
      );
  }

  Padding buildTaskWidgetWithIndex(int index) {
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: currentCategory.tasks[index].toWidget());
  }
}