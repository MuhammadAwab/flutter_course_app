import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _myBar(),
      body: _myBody(context,width,height),
    );
  }

  PreferredSizeWidget _myBar(){
    return AppBar(
      title: Text('My Bar'),
    );
  }

  Widget _myBody(BuildContext context,double width,double height){
    return Center(
        child: Container(
          width: width*0.33,
          height: height*0.2,
          color: Colors.deepPurple,
          child: _myContainer(context, width, height),
        )
    );
  }

  Widget _myContainer(BuildContext context,double width,double height){
    return Container(
        width: width*0.2,
        height: height*0.15,
        padding: EdgeInsets.fromLTRB(width*0.05, height*0.05, width*0.05, height*0.05),
        margin: EdgeInsets.fromLTRB(width*0.01, height*0.01, width*0.01, height*0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        child: Image.asset('images/logo_latest.png',fit: BoxFit.fill,)//Text('My Container'),
    );
  }

}
