import 'page.dart';
import 'package:flutter/material.dart';

class TasksPage extends IPage {
  const TasksPage({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Tasks();
  }
}

class Tasks extends StatefulWidget {
  Tasks({super.key});
  final List<StatelessWidget> tasks = <StatelessWidget>[];

  @override
  State<Tasks> createState() => _TasksState();
}

/* 
TODO: make ValidateCallback description
*/
typedef ValidateCallback = Function(BuildContext context,
    {required String name, required String date, String? desc});

class _TasksState extends State<Tasks> {
  void _onValidated(BuildContext context,
      {required String name, required String date, String? desc}) {
    Navigator.pop(context);
    setState(() {
      widget.tasks.add(Task.fromString(name: name, date: date, desc: desc));
    });
  }

  void _onTap() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: DialogForm(
          validateCallback: _onValidated,
        ));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widget.tasks.insert(0, AddButton(onTap: _onTap));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: widget.tasks[index]),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        child: Row(children: const [Icon(Icons.add), Text("Add")]));
  }
}

class Task extends StatelessWidget {
  final TaskData data;
  Task.fromString(
      {super.key, required String name, required String date, String? desc})
      : data = TaskData(name: name, date: date, desc: desc);
  const Task({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.name),
      subtitle: Text((data.desc == null) ? "" : data.desc!),
      leading: Text(data.date),
    );
  }
}

class TaskData {
  final String name, date;
  String? desc;
  TaskData({required this.name, required this.date, this.desc});
}

/* 
TODO: make DialogForm description
*/
class DialogForm extends StatefulWidget {
  final ValidateCallback validateCallback;
  const DialogForm({super.key, required this.validateCallback});

  @override
  State<DialogForm> createState() => _DialogFormState();
}

/*
TODO: make _DialogFormState description
*/
class _DialogFormState extends State<DialogForm> {
  final GlobalKey<FormState> _requiredFormKey = GlobalKey<FormState>();
  late String _name, _date;
  String? _desc;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _requiredFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RequiredField(
              name: "Name",
              onSaved: (value) {
                _name = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RequiredField(
              name: "Date",
              onSaved: (value) {
                _date = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Description?",
              ),
              onSaved: (value) {
                _desc = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_requiredFormKey.currentState!.validate()) {
                  _requiredFormKey.currentState?.save();
                  widget.validateCallback(context,
                      name: _name, date: _date, desc: _desc);
                }
              },
              child: const Text("Confirm"),
            ),
          )
        ],
      ),
    );
  }
}

/*
TODO: make OnSavedCallback description
*/
typedef OnSavedCallback = void Function(String? value)?;

/*
TODO: make RequiredField description
*/
class RequiredField extends StatelessWidget {
  final String _name;
  final OnSavedCallback _onSaved;
  const RequiredField(
      {super.key, required String name, required OnSavedCallback onSaved})
      : _name = name,
        _onSaved = onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: _name, border: const OutlineInputBorder()),
      validator: (value) {
        if (value == null || value.isEmpty) return "Field is required.";
        return null;
      },
      onSaved: _onSaved,
    );
  }
}
