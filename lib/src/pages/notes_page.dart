import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trimsky_draft/src/pages/notes_page/file_system_entity_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final Future<Directory> _documentsDirectory;

  @override
  void initState() {
    super.initState();
    _documentsDirectory = getApplicationSupportDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      buildFiles(context)
    ]);
  }

  Widget buildFiles(BuildContext context) {
    return FutureBuilder<Directory>(
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          print(snapshot.data!);
          final documentsDir = Directory('${snapshot.data!.path}/sources');
          documentsDir.create(recursive: true);
          final dirData = documentsDir.listSync();
          return Expanded(child: ListView.builder(
            primary: false,
            itemCount: dirData.length,
            itemBuilder: ((context, index) => FileWidget(dirData[index]))
          ));
        }
        return const SizedBox.shrink();
      },
      future: _documentsDirectory,
    );
  }

  Widget makeActionsPanel(BuildContext context) {
    return Column(children: const [

    ]);
  }
}