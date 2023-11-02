import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:zeehub_task/Components/DayData.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  List<Map<String, dynamic>> monday = [];
  List<Map<String, dynamic>> tuesday = [];
  List<Map<String, dynamic>> wednesday = [];
  List<Map<String, dynamic>> thursday = [];
  List<Map<String, dynamic>> friday = [];
  List<Map<String, dynamic>> saturday = [];
  List<Map<String, dynamic>> sunday = [];
  int totalHours = 0;

  Future<void> convertCSVtoJson() async {
    try {
      final response = await http.get(Uri.parse(
          'https://docs.google.com/spreadsheets/d/1f31TfiYfih2FfzGdX4LjgfaQO8yPAPpQcLJ8oXQ9xxQ/export?format=xlsx'));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        var decoder = SpreadsheetDecoder.decodeBytes(bytes);
        String firstSheetKey = decoder.tables.keys.first;
        var table = decoder.tables[firstSheetKey];
        int rowLenght = table?.maxRows ?? 0;
        monday.clear();
        tuesday.clear();
        wednesday.clear();
        thursday.clear();
        friday.clear();
        saturday.clear();
        sunday.clear();
        for (int i = 1; i < rowLenght; i++) {
          var ithRow = table?.rows[i];
          DateTime baseDate = DateTime(1899, 12, 30);
          DateTime date = baseDate.add(Duration(days: ithRow?.first));
          int hour = ithRow?.last;
          if (hour > 0) {
            totalHours += hour;
          }
          Map<String, dynamic> tempMap = {'date': date, 'hours': hour, 'weekday': date.weekday};
          switch (date.weekday) {
            case 1:
              monday.add(tempMap);
              break;
            case 2:
              tuesday.add(tempMap);
              break;
            case 3:
              wednesday.add(tempMap);
              break;
            case 4:
              thursday.add(tempMap);
              break;
            case 5:
              friday.add(tempMap);
              break;
            case 6:
              saturday.add(tempMap);
              break;
            case 7:
              sunday.add(tempMap);
              break;
            default:
          }
        }
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      log("\n fatal Error:- \n ${e.toString()}");
    }
  }

  @override
  void initState() {
    convertCSVtoJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const SizedBox()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 1.0.h),
                    height: 8.0.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.0.w),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade200, spreadRadius: 4, blurRadius: 5)
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                            child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 0.5.h),
                              child: Image.asset("assets/meterImage.png", fit: BoxFit.contain),
                            ),
                            // Positioned(
                            //   top: 3.0.h,
                            //   left: 12.5.w,
                            //   child: Container(
                            //     height: 4.5.h,
                            //     width: 12.w,
                            //     color: Colors.white,
                            //   ),
                            // )
                          ],
                        )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                          constraints: BoxConstraints(maxHeight: 5.0.h),
                          padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 1.0.h),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(1.0.w)),
                          child: Center(
                            child: Text(
                              'Total Working Hours: $totalHours',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  getMonthView(),
                ],
              ),
            ),
    );
  }

  Container getMonthView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 1.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 15.0.w,
            height: 100.0.h,
            child: Column(
              children: [
                Text(
                  "Sunday",
                  style: TextStyle(
                      color: Colors.black54, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: sunday.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (cotext, index) =>
                      DayData(date: sunday[index]['date'], hours: sunday[index]['hours']),
                ))
              ],
            ),
          ),
          SizedBox(
            width: 15.0.w,
            height: 100.0.h,
            child: Column(
              children: [
                Text(
                  "Monday",
                  style: TextStyle(
                      color: Colors.black54, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: monday.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (cotext, index) =>
                      DayData(date: monday[index]['date'], hours: monday[index]['hours']),
                ))
              ],
            ),
          ),
          SizedBox(
            width: 15.0.w,
            height: 100.0.h,
            child: Column(
              children: [
                Text(
                  "Tuesday",
                  style: TextStyle(
                      color: Colors.black54, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: tuesday.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (cotext, index) =>
                      DayData(date: tuesday[index]['date'], hours: tuesday[index]['hours']),
                ))
              ],
            ),
          ),
          SizedBox(
            width: 15.0.w,
            height: 100.0.h,
            child: Column(
              children: [
                Text(
                  "Wednesday",
                  style: TextStyle(
                      color: Colors.black54, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: wednesday.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (cotext, index) =>
                      DayData(date: wednesday[index]['date'], hours: wednesday[index]['hours']),
                ))
              ],
            ),
          ),
          SizedBox(
            width: 15.0.w,
            height: 100.0.h,
            child: Column(
              children: [
                Text(
                  "Thursday",
                  style: TextStyle(
                      color: Colors.black54, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: thursday.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (cotext, index) =>
                      DayData(date: thursday[index]['date'], hours: thursday[index]['hours']),
                ))
              ],
            ),
          ),
          SizedBox(
            width: 15.0.w,
            height: 100.0.h,
            child: Column(
              children: [
                Text(
                  "Friday",
                  style: TextStyle(
                      color: Colors.black54, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: friday.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (cotext, index) =>
                      DayData(date: friday[index]['date'], hours: friday[index]['hours']),
                ))
              ],
            ),
          ),
          SizedBox(
            width: 15.0.w,
            height: 100.0.h,
            child: Column(
              children: [
                Text(
                  "Saturday",
                  style: TextStyle(
                      color: Colors.black54, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: saturday.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (cotext, index) =>
                      DayData(date: saturday[index]['date'], hours: saturday[index]['hours']),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
