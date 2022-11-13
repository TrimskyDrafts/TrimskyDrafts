import 'package:flutter/material.dart';

/* Drag Detector class for CustomNavigationBar;
*/
class CustomDragDetector extends StatefulWidget {
  const CustomDragDetector({super.key});

  @override
  State<StatefulWidget> createState() => CustomDragDetectorState();
}

class CustomDragDetectorState extends State<CustomDragDetector> {
  bool isCursorIn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDrawer(),
      child: MouseRegion(
          onEnter: (e) {
            _handleHover();
          },
          onExit: (e) {
            _handleHover();
          },
          child: Container(
            alignment: AlignmentDirectional.topStart,
            height: double.infinity,
            width: 44.0,
            color: !isCursorIn
                ? const Color.fromARGB(45, 110, 110, 110)
                : const Color.fromARGB(45, 170, 170, 170),
            child: Container(
              padding: const EdgeInsets.only(left: 8),
              alignment: AlignmentDirectional.centerEnd,
              child: const Icon(Icons.keyboard_arrow_right,
                  color: Color.fromARGB(255, 120, 120, 120)),
            ),
          )),
    );
  }

  void _handleHover() {
    setState(() {
      isCursorIn = !isCursorIn;
    });
  }

  void _openDrawer() {
    setState(() {
      Scaffold.of(context).openDrawer();
    });
  }
}
