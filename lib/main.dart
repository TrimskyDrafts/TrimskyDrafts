import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'src/pages/home_page.dart';
import 'src/pages/tasks_page.dart';

final GoRouter _router = GoRouter(routes: <GoRoute>[
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
  GoRoute(path: '/calendar', builder: (context, state) => const TasksPage())
]);
void main() {
  runApp(MaterialApp.router(
    theme: ThemeData(
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
    routeInformationProvider: _router.routeInformationProvider,
    routeInformationParser: _router.routeInformationParser,
    routerDelegate: _router.routerDelegate,
    themeMode: ThemeMode.dark,
    title: "Trimsky's Drafts",
  ));
}