import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:trimsky_draft/tasks_service.dart';
import 'package:trimsky_draft/notifications_service.dart';
import 'package:trimsky_draft/local_settings_service.dart';

import 'package:trimsky_draft/src/pages/notes_page.dart';
import 'package:trimsky_draft/src/pages/settings_page.dart';
import 'package:trimsky_draft/src/pages/page.dart';
import 'package:trimsky_draft/src/pages/home_page.dart';
import 'package:trimsky_draft/src/pages/tasks_page.dart';
    
final GoRouter _router = GoRouter(routes: <GoRoute>[
  GoRoute(path: '/', builder: (context, state) => makePage(const HomePage())),
  GoRoute(path: '/settings', builder: (context, state) => makePage(const SettingsPage())),
  GoRoute(path: '/notes', builder: (context, state) => makePage(const NotesPage())),

  GoRoute(path: '/tasks', builder: (context, state) => makePage(const TasksPage()))
]);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.setup();
  Settings.loadData();
  initTasksData();

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
    themeMode: ThemeMode.light,
    title: "Trimsky's Drafts",
  ));
}