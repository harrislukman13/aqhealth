import 'package:aqhealth/pages/appoinment/confirmappoinment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Listdoctor extends StatefulWidget {
  const Listdoctor({Key? key}) : super(key: key);

  @override
  State<Listdoctor> createState() => _ListdoctorState();
}

class _ListdoctorState extends State<Listdoctor> {
  @override
  List doctor = <String>[
    'dr Adrian koh',
    'adrian',
    'ismail',
  ];
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
                itemCount: doctor.length,
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

  Widget listappointment(int i) => GestureDetector(
        onTap: () => Navigator.push(context,
            CupertinoPageRoute(builder: (context) => ConfirmAppoinment())),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          color: Colors.indigo,
          child: SizedBox(
            width: 17.w,
            height: 18.h,
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          width: 2.h,
                        ),
                        _DrDescription(
                            name: doctor[i],
                            profesion: 'cardiology',
                            desc: 'selalu bercucuk tanam')
                      ]),
                ],
              ),
            ),
          ),
        ),
      );
}

class _DrDescription extends StatelessWidget {
  const _DrDescription({
    required this.name,
    required this.profesion,
    required this.desc,
  });

  final String name;
  final String profesion;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            profesion,
            style: const TextStyle(
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
