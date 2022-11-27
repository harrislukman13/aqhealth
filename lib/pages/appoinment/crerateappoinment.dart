import 'package:aqhealth/pages/appoinment/list_dr_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({Key? key}) : super(key: key);

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  List specialist = <String>[
    "cardiology",
    "asymptotic",
    "leukimia",
    "blood deasies",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Appointment"),
        backgroundColor: Colors.indigo[800],
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            Text(
              "All specialist",
              style: TextStyle(color: Colors.indigo),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: specialist.length,
                itemBuilder: (context, position) {
                  return listappointment(position);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card listappointment(int i) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(specialist[i]),
          textColor: Colors.indigo,
          onTap: () => Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Listdoctor())),
        ),
      );
}
