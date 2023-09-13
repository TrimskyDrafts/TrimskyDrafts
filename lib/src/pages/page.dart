import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:trimsky_draft/local_settings_service.dart';

import 'package:trimsky_draft/src/util/const_values.dart';

const EdgeInsets toolbarPadding = EdgeInsets.only(left: 38);
const windowsEventNotificationsPlatform = EventChannel('dev.trimsky/notifications_events');
// Stream events = windowsEventNotificationsPlatform.receiveBroadcastStream();
// StreamSubscription _stream = events.listen((value) => print("Addkdkdkkdkddkdk"));

// Function wrapper
IPage makePage(Widget body) {
  return IPage(body: body);
}

/// Widget that build standard Trimsky's Drafts page
/// with app bar, body and current page actions(Column in SizedBox).
class IPage extends StatefulWidget {
  const IPage({super.key, required this.body});
  final Widget body;
  
  @override
  State<IPage> createState() => _IPageState();
}

class _IPageState extends State<IPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        buildAppBar(context),
        const Divider(height: 8),
        Expanded(child: widget.body),
      ]);
  }
  
  Widget buildAppBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 38 + 12),
        child: Text("Trimsky's Drafts", style: Styles.titleName)
      ),
      Padding(padding: toolbarPadding, child: Row(children: [
        _getTasksButton(context),
        TextButton(
          onPressed: () {
            // TODO: Make notes page
            context.go('/notes');
          },
          child: const Text("Notes", style: Styles.toolbarItemName)
        ),
        TextButton(
          onPressed: () {
            context.go('/settings');
          },
          child: const Text("Settings", style: Styles.toolbarItemName)
        ),
        TextButton(
          onPressed: () => context.go('/'),
          child: const Text("Help", style: Styles.toolbarItemName)
        ),
        buildExitButton()
      ]))
    ]);
  }

  Widget buildExitButton() {
  if(Platform.isAndroid) {
      return const TextButton(
        onPressed: SystemNavigator.pop,
        child: Text("Exit", style: Styles.toolbarItemName)
      );
    } else if(Platform.isIOS || Platform.isMacOS) {
      return const SizedBox.shrink();
    } else {
      return const TextButton(
        onPressed: exitFromApp,
        child: Text("Exit", style: Styles.toolbarItemName)
      );
    }
  }

  static Widget _getTasksButton(BuildContext context) {
    if(Settings.isBeta) {
      return TextButton(
        onPressed: () => context.go('/tasks'),
        child: const Text("Tasks", style: Styles.toolbarItemName)
      );
    }
    return const SizedBox.shrink();
  }

  static void exitFromApp() {
    exit(0);
  }
}