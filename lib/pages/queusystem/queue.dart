import 'dart:developer';
import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/queu.dart';
import 'package:aqhealth/model/appoinment.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_database/firebase_database.dart';

class Queue extends StatefulWidget {
  const Queue({Key? key, required this.user, required this.data})
      : super(key: key);

  final UserModel user;
  final Map<dynamic, dynamic> data;
  @override
  State<Queue> createState() => _QueueState();
}

class _QueueState extends State<Queue> {
  final FirebaseDatabase _urldatabase = FirebaseDatabase.instance;
  List<Queues> queues = [];

  Stream<DatabaseEvent> listen() {
    _urldatabase.databaseURL =
        "https://aqhealth-d8be5-default-rtdb.asia-southeast1.firebasedatabase.app";
    DatabaseReference ref = _urldatabase.ref('Task');
    return ref.onValue;
  }

  Future<void> deleteQueue(String? appointmentid) async {
    _urldatabase.databaseURL =
        "https://aqhealth-d8be5-default-rtdb.asia-southeast1.firebasedatabase.app";
    DatabaseReference ref = _urldatabase.ref('Task/${appointmentid}');
    await ref.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamProvider<DatabaseEvent?>.value(
          value: listen(),
          initialData: null,
          builder: (context, child) {
            return Consumer<DatabaseEvent?>(
              builder: (context, event, child) {
                if (event == null) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text("Queue"),
                      backgroundColor: Colors.indigo[800],
                      elevation: 0,
                    ),
                    body: Container(
                      padding: EdgeInsets.all(3.h),
                      child: Text('You not entering the Queue'),
                    ),
                  );
                }
                log(event.toString());
                if (event != null) {
                  queues = [];
                  //log(event.snapshot.value.toString());
                  final data = Map<String, dynamic>.from(
                      event.snapshot.value as dynamic);
                  // Map<String, dynamic> data =
                  //     (event.snapshot.value! as Map<String, dynamic>);

                  data.forEach((key, value) {
                    queues.add(Queues.fromJson(value));
                  });

                  log(queues.toString());

                  queues.sort(
                    (a, b) {
                      if (a.priority! < b.priority!) {
                        return 1;
                      } else if (a.timeStamp! > b.timeStamp!) {
                        return 1;
                      }
                      return 0;
                    },
                  );

                  int getIndex() {
                    int index = queues.indexWhere(
                        ((element) => element.patientid == widget.user.uid));
                    return index;
                  }

                  log(queues.elementAt(getIndex()).appointmentId.toString());
                  log(getIndex().toString());

                  Future.delayed(Duration(microseconds: 10));

                  return FutureBuilder(
                      future: DatabaseController.withoutUID()
                          .getSingleAppointment(queues
                              .elementAt(getIndex())
                              .appointmentId
                              .toString()),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (!snapshot.hasData) {
                            return Scaffold(
                              appBar: AppBar(
                                title: const Text("Queue"),
                                backgroundColor: Colors.indigo[800],
                                elevation: 0,
                              ),
                              body: Container(
                                padding: EdgeInsets.all(3.h),
                                child: Text('You not entering the Queue'),
                              ),
                            );
                          }
                          var appointment = snapshot.data as Map;
                          //if (int.parse(getIndex.toString()) != 0) {
                          return Scaffold(
                            appBar: AppBar(
                              title: const Text("Queue"),
                              backgroundColor: Colors.indigo[800],
                              elevation: 0,
                            ),
                            body: Center(
                              child: Container(
                                padding: EdgeInsets.all(5.w),
                                child: Column(
                                  children: [
                                    //name
                                    Text(
                                      "Hi " + widget.data['name'],
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Thank you for waiting",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    SizedBox(
                                      height: 18.h,
                                      width: 24.h,
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.indigo,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          padding: EdgeInsets.all(2.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //drname
                                              Text(
                                                "Dr " +
                                                    appointment['doctorname'],
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                appointment['specialistname'],
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                "Room " +
                                                    queues
                                                        .elementAt(getIndex())
                                                        .room
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "Here Your position in the queue:",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Container(
                                      width: 30.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        shape: BoxShape.circle,
                                        color: Colors.indigo,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            getIndex().toString(),
                                            style: TextStyle(
                                                fontSize: 35.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "position",
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "your Waiting Time: " +
                                          queues
                                              .elementAt(getIndex())
                                              .delay
                                              .toString(),
                                      //'xczx',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "Your Queue has arrive",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side:
                                              BorderSide(color: Colors.indigo)),
                                      onPressed: () async {
                                        await deleteQueue(
                                          queues
                                              .elementAt(getIndex())
                                              .appointmentId
                                              .toString(),
                                        );
                                      },
                                      child: const Text(
                                        "Exit Queue",
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                    )
                                  ],
                                ),
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
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text("Queue"),
                      backgroundColor: Colors.indigo[800],
                      elevation: 0,
                    ),
                    body: Container(
                      padding: EdgeInsets.all(3.h),
                      child: Text('You not entering the Queue'),
                    ),
                  );
                }
              },
            );
          }),
    );
  }
}
