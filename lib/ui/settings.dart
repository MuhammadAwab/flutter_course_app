import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mybottombar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _settingsBody(context),
      bottomNavigationBar: MyBottomBar(currIndex: 2,),
    );
  }
  Widget _settingsBody(BuildContext context){
    return Center(
        child:Container(
            child:Text('SETTINGS')
        )
    );
  }
}
