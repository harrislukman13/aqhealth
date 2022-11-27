import 'package:aqhealth/pages/appoinment/crerateappoinment.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(3.w),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 5.h,
              width: 5.w,
            ),
            GridView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                ),
                children: [
                  MenuBox(
                      icon: 'assets/icons/appoinment.ico',
                      label: 'Make Appoinment',
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CreateAppointment()))),
                  MenuBox(
                      icon: 'assets/icons/appoinment.ico',
                      label: 'Health Screening',
                      onTap: () {}),
                ]),
            SizedBox(
              height: 5.h,
            ),
            const Text(
              "Appoinment Today",
              style: TextStyle(color: Colors.indigo),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 2.h,
            ),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: AppColor.primary,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr Dannea",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "Cardiology Specialist",
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.indigo[200],
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Monday"),
                              Text("22/7/2023"),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class MenuBox extends StatelessWidget {
  const MenuBox({
    required this.icon,
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String icon;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 30.w,
                height: 30.w,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 3.5.w,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
