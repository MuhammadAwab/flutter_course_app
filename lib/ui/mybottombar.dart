import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_app/ui/firstscreen.dart';
import 'package:flutter_course_app/ui/profile.dart';
import 'package:flutter_course_app/ui/records.dart';
import 'package:flutter_course_app/ui/settings.dart';
import 'package:flutter_course_app/utils/app_colors.dart';

class MyBottomBar extends StatefulWidget {
  MyBottomBar({Key? key,required this.currIndex}) : super(key: key);
  final int currIndex;
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: [
          _myNavBarItem(context, 'Home',Icons.home),
          _myNavBarItem(context, 'Profile',Icons.person),
          _myNavBarItem(context, 'Settings',Icons.settings),
          _myNavBarItem(context, 'Records',Icons.bar_chart),
        ],
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.blackColor.withOpacity(0.5),
      showSelectedLabels: false,
      currentIndex: widget.currIndex,
      onTap: (int index){
          print('INDEX CLICKED IS : $index');
          if(widget.currIndex==0){
            if(index==1){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return Profile();
                  })
              );
            }
            if(index==2){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return Settings();
                  })
              );
            }
            if(index==3){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return Records();
                  })
              );
            }
          }
          else{
            if(index==0 && widget.currIndex!=index){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context){
                    return FirstScreen();
                  })
              );
            }
            if(index==1 && widget.currIndex!=index){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context){
                    return Profile();
                  })
              );
            }
            if(index==2 && widget.currIndex!=index){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context){
                    return Settings();
                  })
              );
            }
            if(index==3 && widget.currIndex!=index){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context){
                    return Records();
                  })
              );
            }
          }

      },
    );
  }

  BottomNavigationBarItem _myNavBarItem(BuildContext context,String type,IconData iconData){
    return BottomNavigationBarItem(
      label: type,
      icon: Icon(iconData),
    );
  }
}
