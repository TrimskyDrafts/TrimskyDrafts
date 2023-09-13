part of '../tasks_page.dart';

/// A widget that based on task with timer data
class TextTask extends StatefulWidget {
  final TextTaskData data;

  const TextTask({super.key, required this.data});
  
  @override
  State<TextTask> createState() => _TextTaskState();
}

class _TextTaskState extends State<TextTask> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onEditing, child: MouseRegion(
      onEnter: (e) => setState(() => isHover = true),
      onExit: (e) => setState(() => isHover = false),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.data.name, style: Styles.taskTitleName),
        Row(children: [
          const VerticalDivider(width: 10.0),
          const Spacer(),
          isHover ? buildTaskActions() : const SizedBox.shrink()
        ])
      ]))
    );
  }

  Widget buildTaskActions() {
    return Row(children: [
      IconButton(
        tooltip: "Edit",
        icon: const Icon(Icons.edit),
        onPressed: onEditing,
        splashRadius: 18
      ),
      const VerticalDivider(width: 15),
      IconButton(
        tooltip: "Remove task",
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: () {
          setState(() {
            currentCategory.tasks.remove(widget.data);
          });
        },
        splashRadius: 18
      ),
    ]);
  }

  void onEditing() {
    currentCategory.showDialogForm(this, taskData: widget.data);
  }
}