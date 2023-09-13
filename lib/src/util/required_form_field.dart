import 'package:flutter/material.dart';

/*
TODO: make OnSavedCallback description
*/
typedef OnSavedCallback = void Function(String? value)?;

/*
TODO: make RequiredField description
*/
class RequiredFormField extends StatelessWidget {
  final String _name;
  final OnSavedCallback _onSaved;
  const RequiredFormField(
      {super.key, required String name, required OnSavedCallback onSaved})
      : _name = name,
        _onSaved = onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: _name, border: const OutlineInputBorder()),
      validator: (value) {
        if (value == null || value.isEmpty) return "Field is required.";
        return null;
      },
      onSaved: _onSaved,
    );
  }
}