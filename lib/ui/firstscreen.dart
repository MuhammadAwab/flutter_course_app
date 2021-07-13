import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_course_app/utils/app_colors.dart';

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
      drawer: _myDrawer(context),
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
  
  Widget _myDrawer(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          _myDHeader(context),
          _customListTile(context, 'Home'),
          _customListTile(context, 'Profile'),
          _customListTile(context, 'Sign Out'),
          /*ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            subtitle: Text('Go to Home'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            subtitle: Text('Go to Profile'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            subtitle: Text('Go to Login'),
            trailing: Icon(Icons.arrow_forward_ios),
          )*/
        ],
      ),
    );
  }

  Widget _customListTile(BuildContext context,String type){
    IconData iconData = IconData(0);
    if(type=="Home"){
      iconData= Icons.home;
    }
    if(type=="Profile"){
      iconData= Icons.person;
    }
    if(type=="Sign Out"){
      iconData= Icons.logout;
    }
    return ListTile(
      leading: Icon(iconData/*(type=="Home")?Icons.home:
                    (type=="Profile")?Icons.person:
                    (type=="Sign Out")?Icons.logout:Icons.not_interested*/),
      title: Text(type),
      subtitle: Text('Go to $type'),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _myDHeader(BuildContext context){
    return DrawerHeader(
      decoration: BoxDecoration(
          color: AppColors.primary
      ),
      child: _myDHBody(
          context,
          'Mark',
          'mark@gmail.com',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJkueqf2PfkXtUe_p_kd7j4SBwBEtacRFDmB7O5situL9zj1QSbuV9QWOx8wDqqEDPf5g&usqp=CAU'),
    );
  }

  Widget _myDHBody(BuildContext context,String name,String email,String imgLink){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imgLink),
          radius: 35,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),
        Text(name,style: TextStyle(color: AppColors.whiteColor),),
        Text(email,style: TextStyle(color: AppColors.whiteColor),)
      ],
    );
  }

}
