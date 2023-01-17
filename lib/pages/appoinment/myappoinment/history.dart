import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/appoinment.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseController.withoutUID().getHistoryApointment(),
        builder: (context, AsyncSnapshot<List<Appointment>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Appointment>? appointments = snapshot.data;
            return Container(
              padding: EdgeInsets.all(2.h),
              child: ListView.builder(
                  itemCount: appointments?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
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
                                  "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"),
                            ),
                            title: Text(
                              appointments![index].doctorname!,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              appointments[index].specialistname!,
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
                                    Text(appointments[index].bookdate!),
                                    Text(appointments[index].time!.toString() +
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
                                data: "1234567890",
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
                                  child: Text(appointments[index].status!)),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            );
          } else {
            return Container();
          }
        });
  }
}
