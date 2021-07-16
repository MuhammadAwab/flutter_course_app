import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_app/ui/mybottombar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _profileBody(context),
      bottomNavigationBar: MyBottomBar(currIndex: 1,),
    );
  }

  Widget _profileBody(BuildContext context){
    return Center(
        child:Container(
            child:Text('PROFILE')
        )
    );
  }
}
