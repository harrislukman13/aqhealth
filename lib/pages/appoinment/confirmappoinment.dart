import 'package:aqhealth/model/appoinment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:aqhealth/styles/app_color.dart';

class ConfirmAppoinment extends StatefulWidget {
  const ConfirmAppoinment(
      {Key? key, required this.doctorname, required this.doctorspecialist})
      : super(key: key);
  final String doctorname;
  final String doctorspecialist;
  @override
  State<ConfirmAppoinment> createState() => _ConfirmAppoinmentState();
}

class _ConfirmAppoinmentState extends State<ConfirmAppoinment> {
  DateTime? selectedDate;
  DateTime focusDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  int length = 0;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  List<Appointment>? booked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Appointment"),
        backgroundColor: Colors.indigo[800],
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(3.w),
        child: ListView(
          scrollDirection: Axis.vertical,
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
                        backgroundImage: NetworkImage(
                            "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctorname,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0)),
                        Text(
                          widget.doctorspecialist,
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
            booked == null
                ? Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: SpinKitChasingDots(
                      color: AppColor.primary,
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: length + 1,
                    itemBuilder: ((context, index) {
                      int start = startTime!.hour + index;
                      String startString =
                          TimeOfDay(hour: start, minute: 0).format(context);
                      int end = start + 1;
                      String endString =
                          TimeOfDay(hour: end, minute: 0).format(context);
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
                              onTap: () {
                                //addOrRemove(start);
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.sp)),
                                child: Container(
                                  height: 5.h,
                                  width: 5.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.sp),
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })),
          ],
        ),
      ),
    );
  }
}