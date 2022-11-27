import 'package:aqhealth/pages/dashboard/home/home.dart';
import 'package:aqhealth/pages/profile/profile.dart';
import 'package:aqhealth/pages/queusystem/queue.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aqhealth/widget/custom_animated_bottom_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
//import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: _buildAppBar(),
        body: getBody(),
        bottomNavigationBar: _buildBottomBar());
  }

  //appbar widget////
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.indigo[800],
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      iconTheme: IconThemeData(color: Colors.white),
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
          activeIcon: Icon(Ionicons.book),
          icon: Icon(Ionicons.book_outline),
          label: 'Appoinment',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Ionicons.contract),
          icon: Icon(Ionicons.contract_outline),
          label: 'Queue ',
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Home(),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Users",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Queue()
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: CircleAvatar(
              radius: 65,
              backgroundColor: AppColor.primary,
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('QR code'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => Profile()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
