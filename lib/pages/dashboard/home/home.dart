import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/appoinment.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/pages/appoinment/crerateappoinment.dart';
import 'package:aqhealth/pages/appoinment/myappoinment/listappointment.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.data, required this.user})
      : super(key: key);

  final Map<dynamic, dynamic> data;
  final UserModel user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final db = DatabaseController(uid: widget.user.uid);
    return FutureBuilder(
        future: DatabaseController.withoutUID()
            .getLatestApointment(widget.user.uid),
        builder: (context, AsyncSnapshot<List<Appointment>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Appointment>? appointment = snapshot.data;
            return Scaffold(
              body: Container(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                      width: 5.w,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'AQHEALTH',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Hello',
                            style: TextStyle(
                                color: Colors.indigo, fontSize: 15.sp),
                          ),
                          Text(
                            widget.data['name'],
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                    SizedBox(
                      height: 2.h,
                      width: 5.w,
                    ),
                    GridView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                        ),
                        children: [
                          MenuBox(
                              icon: 'assets/icons/createappointment.ico',
                              label: 'Make Appoinment',
                              onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => CreateAppointment(
                                            data: widget.data,
                                            db: db,
                                          )))),
                          MenuBox(
                              icon: 'assets/icons/appointments.ico',
                              label: 'My Appointment',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => MyAppointment(
                                              appointment: appointment,
                                              user: widget.user,
                                              data: widget.data,
                                            )));
                              }),
                        ]),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Text(
                      "Upcoming Appointment",
                      style: TextStyle(color: Colors.indigo),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    appointment != null
                        ? Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: appointment.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 10,
                                  child: Card(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: AppColor.primary,
                                    child: Container(
                                        width: 90.w,
                                        height: 100.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 20,
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            appointment[index]
                                                                .docURL!),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      appointment[index]
                                                          .doctorname!,
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      appointment[index]
                                                          .specialistname!,
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Container(
                                                color: Colors.indigo[200],
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(appointment[index]
                                                        .bookdate!),
                                                    Text(appointment[index]
                                                            .time
                                                            .toString() +
                                                        ":00")
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
                    Container(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: SpinKitChasingDots(
                color: AppColor.primary,
              ),
            );
          }
        });
  }
}

class MenuBox extends StatelessWidget {
  const MenuBox({
    required this.icon,
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String icon;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 30.w,
                height: 30.w,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 3.5.w,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
