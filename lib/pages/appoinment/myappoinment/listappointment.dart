import 'package:aqhealth/pages/appoinment/myappoinment/history.dart';
import 'package:aqhealth/pages/appoinment/myappoinment/newappointment.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyAppointment extends StatefulWidget {
  const MyAppointment({Key? key}) : super(key: key);

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

enum Menu {
  appointment,
  history,
}

class _MyAppointmentState extends State<MyAppointment> {
  Menu selectedpage = Menu.appointment;

  final PageController _pageController = PageController();

  bool _ispress = false;

  changePage(Menu page, Map<String, dynamic> data) {
    setState(() {
      if (page == Menu.appointment) {
        selectedpage = page;
        _pageController.jumpToPage(0);
      } else if (page == Menu.history) {
        selectedpage = page;
        _pageController.jumpToPage(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();

    /*Scaffold(
      appBar: AppBar(
        title: Text("My Appointment"),
        backgroundColor: Colors.indigo[800],
        elevation: 0,
      ),
      body: Stack(children: [
        Positioned(
          top: 20,
          child: Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * .97,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: _ispress ? Colors.white : Colors.indigo,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    bottomLeft: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0))),
                            child: Center(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          .4),
                                  child: Text(
                                    "History",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _ispress
                                            ? Colors.grey
                                            : Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )),
                      ),
                      onTap: () {
                        setState(() {
                          selectedpage = Menu.history;
                          _pageController.jumpToPage(1);
                          _ispress = !_ispress;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * .5,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: _ispress ? Colors.indigo : Colors.white,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(40.0),
                                    bottomLeft: const Radius.circular(40.0),
                                    bottomRight: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0))),
                            child: Center(
                              child: Text(
                                "Appointment",
                                style: TextStyle(
                                    color:
                                        _ispress ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      onTap: () {
                        setState(() {
                          selectedpage = Menu.appointment;
                          _pageController.jumpToPage(0);
                          _ispress = !_ispress;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              NewAppointment(),
              History(),
            ],
          ),
        )
      ]),
    );*/
  }
}
