import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class DayData extends StatelessWidget {
  final DateTime date;
  final int hours;
  const DayData({super.key, required this.date, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.0.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.5.w),
        child: Container(
          height: 7.0.h,
          width: 8.0.h,
          decoration: BoxDecoration(
              color: hours == 0
                  ? Colors.red.shade100.withOpacity(0.3)
                  : hours == -1
                      ? Colors.purple.shade100.withOpacity(0.2)
                      : Colors.green.shade100,
              border: Border(
                  bottom: BorderSide(
                      color: hours == 0
                          ? Colors.red
                          : hours == -1
                              ? Colors.purple
                              : Colors.green,
                      width: 6))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date.day.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              hours == 0
                  ? Text(
                      "Absent",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 8.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : hours == -1
                      ? Text(
                          "Sick Leave",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 8.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "Present",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 8.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
