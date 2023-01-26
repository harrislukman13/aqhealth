import 'dart:developer';

import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/appoinment.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/pages/dashboard/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class EditAppointment extends StatefulWidget {
  const EditAppointment(
      {Key? key,
      required this.user,
      required this.appointments,
      required this.data})
      : super(key: key);
  final UserModel user;
  final Appointment appointments;
  final Map<dynamic, dynamic> data;

  @override
  State<EditAppointment> createState() => _EditAppointmentState();
}

class Prebook {
  DateTime date;
  int time;

  Prebook({
    required this.date,
    required this.time,
  });

  toMap() => {
        'book_date': DateFormat('yyyy-MM-dd').format(date),
        'time': time,
      };
}

class _EditAppointmentState extends State<EditAppointment> {
  String? _selectedDate;
  DateTime? selectedDate;
  DateTime focusDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  bool isGettingAvailability = false;
  bool edit = false;
  int length = 0;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  TimeOfDay? pauseTime;
  int? time;
  List<Appointment> _booked = [];
  List<Prebook> selected = [];

  @override
  Widget build(BuildContext context) {
    final db = DatabaseController(uid: widget.user.uid);

    return FutureBuilder(
        future: DatabaseController.withoutUID()
            .getSingleDoctor(widget.appointments.doctorid!),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var doctor = snapshot.data as Map<String, dynamic>;

            int start = doctor['starttime'];
            int end = doctor['endtime'];
            startTime = TimeOfDay(hour: start, minute: 0);
            endTime = TimeOfDay(hour: end, minute: 0);
            length = endTime!.hour - startTime!.hour;

            return Scaffold(
                appBar: AppBar(
                  title: Text('My Appointment'),
                  backgroundColor: Colors.indigo[800],
                  elevation: 0,
                ),
                body: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.w),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 50,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(doctor['url']),
                                    radius: 40,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor['doctorname'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.0)),
                                    Text(
                                      doctor['description'],
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.end,
                              children: [
                                Text("Appointment Date: "),
                                Text(widget.appointments.bookdate!),
                                Text(widget.appointments.time!.toString() +
                                    ":00")
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 40.h,
                        width: 40.h,
                        child: Container(
                          padding: EdgeInsets.all(3.h),
                          child: QrImage(
                            data: widget.appointments.appointmentid!,
                            version: QrVersions.auto,
                            size: 70.0,
                            dataModuleStyle: QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.square,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.indigo),
                              onPressed: () {
                                setState(() {
                                  edit = !edit;
                                });
                              },
                              child: Text("Edit Appointment")),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.indigo),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        title: Text('Delete Appointment'),
                                        actions: [
                                          Center(
                                              child: Text(
                                                  "Do you confirm delete?")),
                                          Divider(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              Colors.indigo),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel")),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              Colors.indigo),
                                                  onPressed: () async {
                                                    await db.deleteAppointment(
                                                        widget.appointments
                                                            .appointmentid!);
                                                    log(widget.appointments
                                                        .appointmentid!
                                                        .toString());

                                                    Navigator.pushReplacement(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: ((context) =>
                                                                Mainpage(
                                                                    data: widget
                                                                        .data,
                                                                    user: widget
                                                                        .user))));
                                                  },
                                                  child: Text("Delete"))
                                            ],
                                          )
                                        ],
                                      );
                                    }));
                              },
                              child: Text("Delete"))
                        ],
                      ),
                    ),
                    edit == true
                        ? Container(
                            padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.indigo),
                                onPressed: () async {
                                  _booked =
                                      await db.getAppointmentAvailability();
                                  setState(() {
                                    isGettingAvailability =
                                        !isGettingAvailability;
                                  });
                                  print(_booked);
                                },
                                child: Text('Check Availability')),
                          )
                        : Container(),
                    SizedBox(
                      height: 2.h,
                    ),
                    isGettingAvailability
                        ? Column(
                            children: [
                              Text(
                                'Select date',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                padding: EdgeInsets.all(1.h),
                                child: TableCalendar(
                                  focusedDay: focusDate,
                                  firstDay: DateTime.now(),
                                  lastDay: DateTime(
                                    DateTime.now().year + 1,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                  ),
                                  selectedDayPredicate: (day) {
                                    return isSameDay(selectedDate, day);
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      selectedDate = selectedDay;
                                      _selectedDate = DateFormat('yyyy-MM-dd')
                                          .format(selectedDate!);
                                      focusDate = focusedDay;
                                    });
                                  },
                                  onFormatChanged: (format) {
                                    if (_calendarFormat != format) {
                                      setState(() {
                                        _calendarFormat = format;
                                      });
                                    }
                                  },
                                  onPageChanged: (focusedDay) {
                                    focusDate = focusedDay;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                'Time',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              _booked != null
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1.5,
                                      ),
                                      itemCount: length + 1,
                                      itemBuilder: ((context, index) {
                                        int start = startTime!.hour + index;
                                        String startString =
                                            TimeOfDay(hour: start, minute: 0)
                                                .format(context);
                                        int end = start + 1;
                                        String endString =
                                            TimeOfDay(hour: end, minute: 0)
                                                .format(context);
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                startString + ' -' + endString),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.sp),
                                              child: InkWell(
                                                onTap: () async {
                                                  time = start;
                                                  addOrRemovebooked(start);
                                                },
                                                child: Card(
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.sp)),
                                                  child: Container(
                                                    height: 5.h,
                                                    width: 5.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.sp),
                                                        color: checkIfSelected(
                                                                start)
                                                            ? Colors.green
                                                            : checkIfBooked(
                                                                    start)
                                                                ? Colors.red
                                                                : checkifPause(
                                                                        start)
                                                                    ? Colors
                                                                        .orange
                                                                    : Colors
                                                                        .white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }))
                                  : SizedBox.shrink(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.indigo),
                                  onPressed: () async {
                                    await db.updateAppointment(Appointment(
                                        appointmentid:
                                            widget.appointments.appointmentid,
                                        bookdate: _selectedDate,
                                        doctorid: doctor['id'],
                                        doctorname: doctor['doctorname'],
                                        patientID:
                                            widget.appointments.patientID,
                                        patientname:
                                            widget.appointments.patientname,
                                        specialistname:
                                            widget.appointments.specialistname,
                                        status: widget.appointments.status,
                                        time: time,
                                        docURL: widget.appointments.docURL));
                                    Future.delayed(Duration(seconds: 3));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => Mainpage(
                                                data: widget.data,
                                                user: widget.user))));
                                  },
                                  child: const Text("Submit")),
                            ],
                          )
                        : Container(),
                  ],
                ));
          } else {
            return Container();
          }
        });
  }

  checkIfSelected(int start) {
    for (int i = 0; i < selected.length; i++) {
      if (selected[i].date == selectedDate! && selected[i].time == start) {
        return true;
      }
    }
    return false;
  }

  checkIfBooked(int start) {
    for (int i = 0; i < _booked.length; i++) {
      if (_booked[i].time == start && _booked[i].bookdate == _selectedDate) {
        return true;
      }
    }
    return false;
  }

  checkifPause(int start) {
    if (start == 12) {
      return true;
    }
    return false;
  }

  addOrRemovebooked(int start) {
    if (!checkIfBooked(start) && !checkifPause(start)) {
      for (int i = 0; i < selected.length; i++) {
        if (selected[i].date == selectedDate! && selected[i].time == start) {
          setState(() {
            selected.removeAt(i);
          });
          return;
        }
      }

      setState(() {
        selected.add(Prebook(
          date: selectedDate!,
          time: start,
        ));
      });
      return;
    }
  }
}
