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
    return Scaffold(
      appBar: AppBar(
        title: Text("My Appointment"),
        backgroundColor: Colors.indigo[800],
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(3.w),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * .44,
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                        color: _ispress ? Colors.white : Colors.indigo,
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(20)),
                      ),
                      child: Center(
                          child: Text(
                        "History",
                        style: TextStyle(
                            fontSize: 16,
                            color: _ispress ? Colors.grey : Colors.white,
                            fontWeight: FontWeight.bold),
                      ))),
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
                  width: MediaQuery.of(context).size.width * .44,
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                          color: _ispress ? Colors.indigo : Colors.white,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(20))),
                      child: Center(
                        child: Text(
                          "Appointment",
                          style: TextStyle(
                              color: _ispress ? Colors.white : Colors.grey,
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 75.h,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                NewAppointment(),
                History(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
