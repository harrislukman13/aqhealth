import 'package:aqhealth/controller/Authcountroller.dart';
import 'package:aqhealth/pages/profile/profilesetting.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.data}) : super(key: key);
  final Map<dynamic, dynamic> data;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthController _auth = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo[800],
        elevation: 0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.indigo[800],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(23),
                      bottomRight: Radius.circular(23))),
              height: 21.h,
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
              child: Center(
                child: Column(children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.indigo,
                    backgroundImage: NetworkImage(widget.data['url']),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    widget.data['name'].toString().toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.data['role'].toString().toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            width: 30.h,
            child: Container(
              padding: EdgeInsets.fromLTRB(15.h, 0, 15.h, 0),
              width: 1.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  side: BorderSide.none,
                  shape: StadiumBorder(),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ProfileSetting(
                                data: widget.data,
                              )));
                },
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),

          Center(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.fromLTRB(2.h, 2.h, 2.h, 2.h),
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Ic No",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.data['ic'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Phone Number",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.data['phone'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "State",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.data['state'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
            child: const Divider(
              height: 1,
              thickness: 2,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent.withOpacity(0.1)),
                    child: Icon(
                      CupertinoIcons.settings,
                      color: Colors.indigo,
                    ),
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1)),
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent.withOpacity(0.1)),
                    child: Icon(
                      CupertinoIcons.money_dollar_circle,
                      color: Colors.indigo,
                    ),
                  ),
                  title: Text(
                    'App Purchase',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1)),
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent.withOpacity(0.1)),
                    child: Icon(
                      CupertinoIcons.person_crop_circle_badge_checkmark,
                      color: Colors.indigo,
                    ),
                  ),
                  title: Text(
                    'User Management',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1)),
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () => {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            padding: EdgeInsets.all(25),
            child: const Divider(
              height: 1,
              thickness: 2,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent.withOpacity(0.1)),
                    child: Icon(
                      Icons.logout_outlined,
                      color: Colors.indigo,
                    ),
                  ),
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.red),
                  ),
                  onTap: () => {_auth.signOut()},
                ),
              ],
            ),
          ),
          // Center(
          //   child: Padding(
          //     padding: EdgeInsets.all(2.h),
          //     child: Card(
          //       elevation: 5,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(5)),
          //       child: Column(
          //         children: [
          //           //qr
          //           QrImage(
          //             data: widget.data['name'],
          //             version: QrVersions.auto,
          //             size: 300.0,
          //             dataModuleStyle: QrDataModuleStyle(
          //                 dataModuleShape: QrDataModuleShape.square,
          //                 color: Colors.black),
          //           ),
          //           //name
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Drawer SideMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.indigo,
              Colors.indigoAccent,
            ])),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColor.primary,
                  backgroundImage: NetworkImage(widget.data['url']),
                ),
                Text(
                  widget.data['name'],
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              ],
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
            title: Text('Setting'),
            onTap: () => {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => ProfileSetting(data: widget.data,)))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {_auth.signOut()},
          ),
        ],
      ),
    );
  }
}
