import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/appoinment.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/pages/appoinment/myappoinment/editappointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment(
      {Key? key, this.appointment, required this.user, required this.data})
      : super(key: key);

  final List<Appointment>? appointment;
  final UserModel user;
  final Map<dynamic, dynamic> data;
  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2.h),
        child: widget.appointment != null
            ? ListView.builder(
                itemCount: widget.appointment?.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => EditAppointment(
                                    data: widget.data,
                                    user: widget.user,
                                    appointments: widget.appointment![index],
                                  )));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 3,
                      color: Colors.indigo,
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  widget.appointment![index].docURL!),
                            ),
                            title: Text(
                              widget.appointment![index].doctorname!,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              widget.appointment![index].specialistname!,
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.h),
                            child: Container(
                              height: 4.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.indigo[200]),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.appointment![index].bookdate!),
                                    Text(widget.appointment![index].time!
                                            .toString() +
                                        ":00")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              QrImage(
                                data:
                                    widget.appointment![index].patientID ?? '',
                                version: QrVersions.auto,
                                size: 70.0,
                                dataModuleStyle: QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.square,
                                    color: Colors.white),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: (() {}),
                                  child:
                                      Text(widget.appointment![index].status!)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })
            : Container());
  }
}
