import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Queue extends StatefulWidget {
  const Queue({Key? key}) : super(key: key);

  @override
  State<Queue> createState() => _QueueState();
}

class _QueueState extends State<Queue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queue"),
        backgroundColor: Colors.indigo[800],
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: [
              //name
              Text(
                "Hi Haris",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
                textAlign: TextAlign.center,
              ),
              Text(
                "Thank you for waiting",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                height: 18.h,
                width: 24.h,
                child: Card(
                  elevation: 5,
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.all(2.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //drname
                        Text(
                          "Dr Dannea",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Cardiology Specialist",
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Room 4",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Here Your position in the queue:",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: 30.w,
                height: 20.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Colors.indigo,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "5",
                      style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "position",
                      style: TextStyle(fontSize: 10.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Waiting time: 30 minute",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "we will notify you when we are almost ready to see you",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.indigo)),
                onPressed: () {},
                child: const Text(
                  "Exit Queue",
                  style: TextStyle(color: Colors.indigo),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
