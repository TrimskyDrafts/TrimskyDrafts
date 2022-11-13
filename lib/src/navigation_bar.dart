import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Center(
            child: ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            context.go("/");
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month_outlined),
          title: const Text("Calendar"),
          onTap: () {
            context.go('/calendar');
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () {
            // TODO: make Settings page
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text("Exit"),
          onTap: () {
            SystemNavigator.pop();
          },
        )
      ],
    )));
  }
}
