import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class ConfirmAppoinment extends StatefulWidget {
  const ConfirmAppoinment({Key? key}) : super(key: key);

  @override
  State<ConfirmAppoinment> createState() => _ConfirmAppoinmentState();
}

class _ConfirmAppoinmentState extends State<ConfirmAppoinment> {
  DateTime? selectedDate;

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
                          'Dr koh',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0)),
                        Text(
                          "Cardiologist specialist",
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
            TextField(
              enabled: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Ionicons.calendar_clear_outline)),
              style: TextStyle(color: Colors.grey),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(
                    DateTime.now().year + 1,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                );

                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                  //updateAvailability();
                }
              },
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
          ],
        ),
      ),
    );
  }
}
