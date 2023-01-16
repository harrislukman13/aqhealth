import 'package:aqhealth/controller/Authcountroller.dart';
import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/pages/dashboard/home/home.dart';
import 'package:aqhealth/pages/profile/profile.dart';
import 'package:aqhealth/pages/queusystem/queue.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aqhealth/widget/custom_animated_bottom_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
//import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({
    Key? key,
    required this.data,
    required this.user,
  }) : super(key: key);

  final Map<dynamic, dynamic> data;
  final UserModel user;

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody(), bottomNavigationBar: _buildBottomBar());
  }

  //appbar widget////
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.indigo[800],
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      iconTheme: IconThemeData(color: Colors.white),
      actions: [
        Container(
          padding: EdgeInsets.all(2.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello',
                style: TextStyle(color: Colors.white, fontSize: 8.sp),
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                widget.data['name'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }

  /////////////////
  ///bottom navigation
  ///////////
  Widget _buildBottomBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: _currentIndex,
      selectedFontSize: 3.w,
      unselectedFontSize: 3.w,
      iconSize: 6.w,
      selectedItemColor: AppColor.primary,
      onTap: (index) => setState(() => _currentIndex = index),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: Icon(Ionicons.grid),
          icon: Icon(Ionicons.grid_outline),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Ionicons.contract),
          icon: Icon(Ionicons.contract_outline),
          label: 'Queue ',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Ionicons.person),
          icon: Icon(Ionicons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Home(
        data: widget.data,
        user: widget.user,
      ),
      Queue(
        user: widget.user,
        data: widget.data,
      ),
      Profile(
        data: widget.data,
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
