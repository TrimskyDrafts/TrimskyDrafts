import 'package:flutter/material.dart';
import 'package:trimsky_draft/src/util/const_values.dart';
import 'package:trimsky_draft/local_settings_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text("Theme", style: Styles.settingsTitleName)
        ),
        const Divider(),
        
        const Divider(),
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text("Beta", style: Styles.settingsTitleName)
        ),
        const Divider(),
        Row(children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Checkbox(
              value: Settings.isBeta, 
              onChanged: (value) {
                Settings.setBetaVersion(value!);
                setState(() {});
              }
            )
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text("Enable beta features", style: TextStyle(fontSize: 15.0))
          )
        ])
      ]);
  }
}