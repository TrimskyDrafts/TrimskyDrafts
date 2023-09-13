import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trimsky_draft/src/dialog_form/abstract_task_dialog_form.dart';
import 'package:trimsky_draft/src/util/date.dart';
import 'package:trimsky_draft/src/util/timer_task_data.dart';

/* 
TODO: make TimerTaskDialogForm description
*/
class TimerTaskDialogForm extends AbstractTaskDialogForm<TimerTaskData> {
  const TimerTaskDialogForm({super.key, required super.afterValidationCallback, super.taskData});

  @override
  State<TimerTaskDialogForm> createState() => _TimerTaskDialogFormState();
}

/*
TODO: make _NewTaskDialogFormState description
*/
class _TimerTaskDialogFormState extends State<TimerTaskDialogForm> {
  final GlobalKey<FormState> _requiredFormKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  late String _name;
  late String _date;
  late String? _desc;

  @override
  void initState() {
    super.initState();
    if(widget.taskData == null) return;
    final taskDate = Date(widget.taskData!.date, formatType: DateFormatType.yearMonthDay, showNamed: false).toString();
    _dateController.value = TextEditingValue(text: taskDate);
    _descController.value = TextEditingValue(text: widget.taskData!.desc ?? '');
    _nameController.value = TextEditingValue(text: widget.taskData!.name);
    _name = widget.taskData!.name;
    _date = taskDate;
    _desc = widget.taskData!.desc;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.taskData == null ? DateTime.now() : widget.taskData!.date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (picked != null) {
      DateTime now = DateTime.now();
      DateTime pickedNormalize;
      if(picked.year == now.year && picked.month == now.month && picked.day == now.day) {
        pickedNormalize = DateTime(picked.year, picked.month, picked.day, now.hour, now.minute, now.second);
      } else {
        pickedNormalize = picked;
      }
      setState(() {
        _date = Date(pickedNormalize, formatType: DateFormatType.yearMonthDay, showNamed: false).toString();
        _dateController.value = TextEditingValue(text: _date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _requiredFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) return "Field is required.";
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
              controller: _nameController,
            )
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: "Date", border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null) {
                    return "Field is required.";
                  }
                  else if(Date.parse(value, DateFormatType.yearMonthDay, false) == null) {
                    return "Date is invalid.";
                  }
                  return null;
                },
                onSaved: (value) {
                  if(value == null) return;
                  _date = value;
                },
                controller: _dateController,
              ),
            )),
            IconButton(
              onPressed: () => _selectDate(context), 
              icon: const Icon(Icons.calendar_month_outlined), 
              iconSize: 24,
              splashRadius: 24,
            ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(labelText: "Description?"),
              onSaved: (value) {
                _desc = value;
              },
              controller: _descController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_requiredFormKey.currentState!.validate()) {
                  _requiredFormKey.currentState?.save();
                  // Cannot be invalid date
                  var date = Date.parse(_date, DateFormatType.yearMonthDay, true) as Date;
                  setState(() {
                    widget.afterValidationCallback(oldData: widget.taskData,
                      data: TimerTaskData(name: _name, date: date.rawTime, desc: _desc));
                    Navigator.pop(context);
                  });
                }
              },
              child: const Text("Confirm"),
            ),
          )
        ],
      )
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _descController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}