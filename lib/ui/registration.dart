import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_app/ui/firstscreen.dart';
import 'package:flutter_course_app/ui/login.dart';
import 'package:flutter_course_app/utils/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  TextEditingController eTC = new TextEditingController();
  TextEditingController pTC = new TextEditingController();

  IconData passwordIcon = Icons.airplanemode_inactive;
  bool hiddenPassword = true;

  @override
  initState(){
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
                _registerUser(eTC.text, pTC.text);
              },
              child: Text('Register'),
            ),
            _loginLink(context)
          ],
        ),
      ),
    );
  }

  Widget _loginLink(BuildContext context){
    return RichText(
        text: TextSpan(
          children: [
            TextSpan(text: "Account already exists ",style: TextStyle(color: AppColors.blackColor)),
            TextSpan(
                text: 'Sign In',style: TextStyle(color: AppColors.primary),
                recognizer: TapGestureRecognizer()..onTap = () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return LoginScreen();
                      }
                  ));
                },
            ),
          ]
    ));
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

  void _registerUser(String e,String p) async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(msg: 'The account already exists for that email.');
      }
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
             CircularProgressIndicator(),
             Text('Loading'),
           ],
         ),
        )
    );
  }
}
