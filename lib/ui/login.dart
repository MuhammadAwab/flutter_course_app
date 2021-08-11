import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'firstscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController eTC = new TextEditingController();
  TextEditingController pTC = new TextEditingController();
  IconData passwordIcon = Icons.airplanemode_inactive;
  bool hiddenPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _textFieldsBody(context),
            RaisedButton(
              onPressed: (){
                _showLoadingDialog(context);
                _loginUser(eTC.text, pTC.text);
              },
              child: Text('Login'),
            )
          ],
        ),
      ),
    );
  }

  Widget _textFieldsBody(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: width*0.7,
          height: height*0.1,
          child: TextField(
            controller: eTC,
            decoration: InputDecoration(
                hintText: 'Enter Email'
            ),
          ),
        ),
        SizedBox(
          width: width*0.7,
          height: height*0.1,
          child: TextField(
            controller: pTC,
            obscureText: (hiddenPassword)?true:false,
            decoration: InputDecoration(
                hintText: 'Enter Password',
                suffixIcon: IconButton(
                  icon: Icon(passwordIcon),
                  onPressed: () {
                    setState(() {
                      if(hiddenPassword){
                        hiddenPassword=false;
                        passwordIcon=Icons.airplanemode_active;
                      }
                      else{
                        hiddenPassword=true;
                        passwordIcon=Icons.airplanemode_inactive;
                      }
                    });
                  },
                )
            ),
          ),
        ),
      ],
    );
  }

  void _loginUser(String e,String p) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: e,
          password: p
      ).then((value){
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return FirstScreen();
            }
        ));
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: e.code);
    } catch (e) {
      Navigator.pop(context);
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void _showLoadingDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Loading'),
              CircularProgressIndicator()
            ],
          ),
        )
    );
  }
}
