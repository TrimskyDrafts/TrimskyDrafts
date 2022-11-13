import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trimsky_draft/src/custom_drag_detector.dart';
import '../navigation_bar.dart';

/*
*/
abstract class IPage extends StatelessWidget {
  const IPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Row(children: [
        const CustomDragDetector(),
        Flexible(child: buildBody(context))
      ]),
      drawer: const CustomNavigationBar(),
    );
  }

  Widget buildBody(BuildContext context);

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text("Trimsky's Drafts"),
        leading: IconButton(
            icon: const Icon(Icons.home_filled),
            onPressed: () => context.go("/")));
  }
}
