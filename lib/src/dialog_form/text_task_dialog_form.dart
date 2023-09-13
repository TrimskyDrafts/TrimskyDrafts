import 'package:flutter/material.dart';
import 'package:trimsky_draft/src/dialog_form/abstract_task_dialog_form.dart';
import 'package:trimsky_draft/src/util/common_task_data.dart';

class TextTaskDialogForm extends AbstractTaskDialogForm<TextTaskData> {
  const TextTaskDialogForm({super.key, required super.afterValidationCallback, super.taskData});

  @override
  State<TextTaskDialogForm> createState() => _TextTaskDialogFormState();
}

/*
TODO: make _NewTaskDialogFormState description
*/
class _TextTaskDialogFormState extends State<TextTaskDialogForm> {
  final GlobalKey<FormState> _requiredFormKey = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  late String _name;
  late String? _desc;

  @override
  void initState() {
    super.initState();
    if(widget.taskData == null) return;
    _descController.value = TextEditingValue(text: widget.taskData!.desc ?? '');
    _nameController.value = TextEditingValue(text: widget.taskData!.name);
    _name = widget.taskData!.name;
    _desc = widget.taskData!.desc;
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
                  setState(() {
                    widget.afterValidationCallback(oldData: widget.taskData,
                      data: TextTaskData(name: _name, desc: _desc));
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
    _descController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}