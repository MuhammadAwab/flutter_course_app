import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mybottombar.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name="";
  TextEditingController nC = new TextEditingController();

  @override
  void initState(){
    super.initState();
    _getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _settingsBody(context),
      bottomNavigationBar: MyBottomBar(currIndex: 2,),
    );
  }
  Widget _settingsBody(BuildContext context){
    return Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child:Text('My Name is $name')
            ),
            RaisedButton(onPressed: (){
              showCustomDialog(context);
            },
            child: Text("Set Name"),)
          ],
        )
    );
  }

  void _setName(String nameValue) async{
    SharedPreferences _myPrefs = await SharedPreferences.getInstance();
    await _myPrefs.setString("name", nameValue);
  }

  void _getName() async{
    SharedPreferences _myPrefs = await SharedPreferences.getInstance();
    setState(() {
      name = _myPrefs.getString("name")??"";
    });
  }

  void showCustomDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Enter your name'),
            content: CupertinoTextField(
              controller: nC,
            ),//Text('This is a testing Dialog'),
            actions: [
              FlatButton(
                  child: Text('OK'),
                  onPressed: (){
                    if(nC.text.isNotEmpty) {
                      _setName(nC.text);
                      nC.clear();
                    }
                    _getName();
                    Navigator.of(context).pop();
                  })
            ],

          );}
    );
  }


}
