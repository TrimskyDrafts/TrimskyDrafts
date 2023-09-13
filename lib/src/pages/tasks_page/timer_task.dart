part of '../tasks_page.dart';

/// A widget that based on task with timer data
class TimerTask extends StatefulWidget {
  final TimerTaskData data;

  const TimerTask({super.key, required this.data});
  
  @override
  State<TimerTask> createState() => _TimerTaskState();
}

class _TimerTaskState extends State<TimerTask> {
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
          const Icon(Icons.watch_later_outlined, size: 14.0, color: Color.fromARGB(255, 100, 181, 246)),
          !widget.data.isFinished ? Text(currentDateTime(), style: Styles.timeName) : const Text("Finished."),
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

  String currentDateTime() {
    final Duration duration = widget.data.date.difference(DateTime.now());
    return durationToString(duration);
  }

  static String durationToString(Duration duration) {
    final days = duration.inDays.toString();
    final hours = duration.inHours.remainder(24).toString();
    final minutes = duration.inMinutes.remainder(60).toString();
    final seconds = duration.inSeconds.remainder(60).toString();
    return "${days == "0" ? '' : '${days}d'} ${hours == "0" ? '' : '${hours}h'} ${minutes}m ${seconds}s";
  }
}