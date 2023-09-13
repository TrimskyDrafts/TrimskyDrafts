import 'package:flutter/material.dart';

abstract class AbstractTaskDialogForm<T> extends StatefulWidget {
  final void Function({T? oldData, required T data}) afterValidationCallback;
  final T? taskData;

  const AbstractTaskDialogForm({
    required this.afterValidationCallback,
    this.taskData,
    super.key});
}