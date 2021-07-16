import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mybottombar.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _recordsBody(context),
      bottomNavigationBar: MyBottomBar(currIndex: 3,),
    );
  }

  Widget _recordsBody(BuildContext context){
    return Center(
        child:Container(
            child:Text('RECORDS')
        )
    );
  }
}
