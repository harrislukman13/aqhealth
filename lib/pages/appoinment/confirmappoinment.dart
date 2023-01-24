import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/appoinment.dart';
import 'package:aqhealth/model/doctor.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/pages/dashboard/home/home.dart';
import 'package:aqhealth/pages/dashboard/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:aqhealth/styles/app_color.dart';

class ConfirmAppoinment extends StatefulWidget {
  const ConfirmAppoinment(
      {Key? key, required this.doctor, required this.data, required this.db})
      : super(key: key);

  final Doctor doctor;
  final Map<dynamic, dynamic> data;
  final DatabaseController db;
  @override
  State<ConfirmAppoinment> createState() => _ConfirmAppoinmentState();
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

class _ConfirmAppoinmentState extends State<ConfirmAppoinment> {
  String? _selectedDate;
  DateTime? selectedDate;
  DateTime focusDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  bool isGettingAvailability = false;
  int length = 0;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  TimeOfDay? pauseTime;
  int? time;
  List<Appointment> _booked = [];
  List<Prebook> selected = [];

  @override
  void initState() {
    int start = widget.doctor.startTime!;
    int end = widget.doctor.endTime!;
    startTime = TimeOfDay(hour: start, minute: 0);
    endTime = TimeOfDay(hour: end, minute: 0);
    length = endTime!.hour - startTime!.hour;
    super.initState();
    setState(() {
      widget.db.getAppointmentAvailability();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final db = DatabaseController(uid: user!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Appointment"),
        backgroundColor: Colors.indigo[800],
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(3.w),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.all(5.w),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.doctor.url!),
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
                          widget.doctor.doctorName!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0)),
                        Text(
                          widget.doctor.description!,
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5.h, 0, 5.h, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.indigo),
                  onPressed: () async {
                    _booked = await db.getAppointmentAvailability();
                    setState(() {
                      isGettingAvailability = !isGettingAvailability;
                    });
                    print(_booked);
                  },
                  child: Text('Check Availability')),
            ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(startString + ' -' + endString),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(2.sp),
                                      child: InkWell(
                                        onTap: () async {
                                          time = start;
                                          addOrRemovebooked(start);
                                        },
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.sp)),
                                          child: Container(
                                            height: 5.h,
                                            width: 5.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.sp),
                                                color: checkIfSelected(start)
                                                    ? Colors.green
                                                    : checkIfBooked(start)
                                                        ? Colors.red
                                                        : checkifPause(start)
                                                            ? Colors.orange
                                                            : Colors.white),
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
                            String id = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();
                            await db.createAppointment(Appointment(
                                appointmentid: id,
                                doctorid: widget.doctor.doctorID,
                                doctorname: widget.doctor.doctorName,
                                specialistname: widget.doctor.specialistname,
                                patientname: widget.data['name'],
                                bookdate: _selectedDate,
                                time: time,
                                patientID: user.uid,
                                status: "success",
                                docURL: widget.doctor.url));

                            Future.delayed(Duration(seconds: 3));

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Mainpage(
                                        data: widget.data, user: user))));
                          },
                          child: const Text("Submit")),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
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
