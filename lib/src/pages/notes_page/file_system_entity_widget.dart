import 'dart:io';

import 'package:flutter/material.dart';

const List<String> file = <String>[];

class FileWidget extends StatefulWidget {

  final FileSystemEntity entity;
  const FileWidget(this.entity, {super.key});

  @override
  State<StatefulWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  bool isContextMenuOpened = true;
  late final String name;

  final List<PopupMenuItem<String>> options = <PopupMenuItem<String>>[
    PopupMenuItem<String>(
      value: "Delete",
      child: const Text("Delete"),
      onTap: () {
        // TODO: Options use
      },
    ),
    PopupMenuItem(
      value: "Rename",
      child: const Text("Rename"),
      onTap: () {
        // TODO: Options use
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    name = widget.entity.path.split(Platform.pathSeparator).last;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PopupMenuButton<String>(
        onSelected: _select,
        child: Text(name),
        itemBuilder: (context) => options,
      ),
      const Divider(),
    ]);
  }
  void _select(String optionName) {
    if(optionName[0] == 'R') {
      
    } else if(optionName[0] == 'D') {

    }
  }
}