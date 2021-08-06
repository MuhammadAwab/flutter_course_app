import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_course_app/ui/mybottombar.dart';
import 'package:flutter_course_app/ui/registration.dart';
import 'package:flutter_course_app/utils/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  GlobalKey<ScaffoldState> _gKey = new GlobalKey<ScaffoldState>();
  bool _showSheet = false;
  IconData myIcon = Icons.check;
  PersistentBottomSheetController _sheetController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _gKey,
          appBar: _myBar(),
          drawer: _myDrawer(context),
          body: _myTabBarViewBody(context),
          bottomNavigationBar: MyBottomBar(currIndex: 0,),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(!_showSheet){
                setState(() {
                  _sheetController = _gKey.currentState.showBottomSheet((context){
                    return _myBottomSheet();
                  });
                  myIcon = Icons.close;
                  _showSheet=true;
                });
                //Scaffold.of(context).showBottomSheet((context) =>_myBottomSheet());
              }
              else{
                setState(() {
                  _sheetController.close();
                  _sheetController=null;
                  myIcon = Icons.check;
                  _showSheet=false;
                });

              }
              //customShowSheet(context)
            },
            tooltip: 'Increment',
            child: Icon(myIcon),
          ),//_myBody(context,width,height),
    ));
  }

  customShowSheet(BuildContext context){
    if(!_showSheet){
      //_gKey.currentState!.showBottomSheet((context)=>_myBottomSheet());
      Scaffold.of(context).showBottomSheet((context) =>_myBottomSheet());
    }

  }

  Widget _myBottomSheet(){
    return BottomSheet(
        onClosing: onClosingSheet,
        builder: _sheetView
    );
  }

  Widget _myTabBarViewBody(BuildContext context){
    return TabBarView(
        children:[
          _myTabBody(context, 'Burger', Icons.fastfood_rounded),
          _myTabBody(context, 'Pizza', Icons.local_pizza),
          _myTabBody(context, 'Deals', Icons.fastfood_outlined),
          _myTabBody(context, 'Drinks', Icons.local_drink_rounded),
        ]
    );
  }

  Widget _myTabBody(BuildContext context,String type,IconData iconData){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(type,style: TextStyle(fontSize: 20),),
          Icon(iconData,size: 20,)
        ],
      ),
    );
  }

  PreferredSizeWidget _myBar(){
    return AppBar(
      title: Text('My Bar'),
      bottom: _myTabBar(context),
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

  Widget _sheetView(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
        color: AppColors.primary,
      ),
    );
  }

  void onClosingSheet(){
    print('SHEET CLOSED');
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
      onTap: (){
        Fluttertoast.showToast(
            msg: type,
            textColor: AppColors.whiteColor,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: AppColors.primary,
        );
        if(type=="Sign Out"){
          _showLoadingDialog(context);
          FirebaseAuth.instance.signOut().then((value){
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return Registration();
                }
            ));
          });
        }
      },
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
          //1- Image.asset()
          //2- Image.network(url)
          //3- AssetImage()
          //4- NetworkImage(url)
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

  PreferredSizeWidget _myTabBar(BuildContext context){
    return TabBar(
        tabs:[
          _myTab(context, 'Burger', Icons.fastfood_rounded),
          _myTab(context, 'Pizza', Icons.local_pizza),
          _myTab(context, 'Deals', Icons.fastfood_outlined),
          _myTab(context, 'Drinks', Icons.local_drink_rounded),
        ]
    );
  }

  Widget _myTab(BuildContext context,String type,IconData iconData){
    return Tab(
      text: type,
      icon: Icon(iconData),
    );
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
