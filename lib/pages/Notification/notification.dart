import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/notification.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return FutureBuilder(
        future: DatabaseController.withoutUID().getNotification(user!.uid),
        builder: (context, AsyncSnapshot<List<Notifications>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Notifications>? notifications = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('Notification'),
                backgroundColor: Colors.indigo[800],
                elevation: 0,
              ),
              body: ListView.builder(
                itemCount: notifications?.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(1.h),
                    child: SizedBox(
                      height: 15.h,
                      width: 8.h,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 3,
                        color: Colors.indigo,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(1.h, 0, 1.h, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.bell_fill,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  Text(
                                    "New Notification",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                notifications![index].notifyText.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormat.yMMMMEEEEd().format(
                                        notifications[index]
                                            .dateTime!
                                            .toDate()),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
