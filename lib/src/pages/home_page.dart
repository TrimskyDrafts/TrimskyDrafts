import 'page.dart';
import 'package:flutter/material.dart';
import '../additional_functions.dart';

class HomePage extends IPage {
  const HomePage({super.key});

  @override
  Widget buildBody(BuildContext context) {
    var references = _buildReferenceList(context);
    return Row(children: [
        references,
        const Icon(Icons.brush)
      ]);
  }

  SizedBox _buildReferenceList(BuildContext context) {
    return SizedBox(
        width: getDeviceWidth(context) / 2,
        child: ListView(
          padding: EdgeInsets.only(left: 120, top: getDeviceWidth(context) / 4),
          children: const [
            ListTile(
              title: Text(
                "Get Started!",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add, color: Colors.blue),
              title: Text(
                "New note",
                style: TextStyle(fontSize: 13, color: Colors.blue),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_outlined, color: Colors.blue),
              title: Text(
                "Go to calendar",
                style: TextStyle(fontSize: 13, color: Colors.blue),
              ),
            ),
          ],
        ));
  }
}
