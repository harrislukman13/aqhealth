import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/model/specialist.dart';
import 'package:aqhealth/pages/appoinment/list_dr_appointment.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({Key? key, required this.data, required this.db})
      : super(key: key);
  final Map<dynamic, dynamic> data;
  final DatabaseController db;
  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Specialist>>.value(
        initialData: [],
        value: DatabaseController.withoutUID().getSpecialist(),
        catchError: (context, error) => [],
        builder: (context, child) {
          List<Specialist> specialist = Provider.of<List<Specialist>>(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Create Appointment"),
              backgroundColor: Colors.indigo[800],
              elevation: 0,
            ),
            body: Container(
              padding: EdgeInsets.all(5.w),
              child: Column(
                children: [
                  const Text(
                    "All specialist",
                    style: TextStyle(color: Colors.indigo),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: (specialist != null)
                        ? ListView.builder(
                            itemCount: specialist.length,
                            itemBuilder: (context, int index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  title: Text(specialist[index].specialistname),
                                  textColor: Colors.indigo,
                                  onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => Listdoctor(
                                                data: widget.data,
                                                specialistID:
                                                    specialist[index].id,
                                                specialistName:
                                                    specialist[index]
                                                        .specialistname,
                                                db: widget.db,
                                              ))),
                                ),
                              );
                            },
                          )
                        : Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: SpinKitChasingDots(
                              color: AppColor.primary,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
