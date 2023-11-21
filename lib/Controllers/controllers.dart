// import 'dart:convert';
// import 'dart:developer';
// import 'package:csv
// import 'package:flutter

// class Controllers {
//   Future<void> printJsonFromCsvFile() async {
//     String csvData = await rootBundle.loadString('assets
//     List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvData);

//     log("

//     List<Map<String, dynamic>> jsonList = [];

//     
//     List<dynamic> keys = rowsAsListOfValues.removeAt(0);

//     for (List<dynamic> row in rowsAsListOfValues) {
//       Map<String, dynamic> jsonRow = {};
//       for (int i = 0; i < keys.length; i++) {
//         jsonRow[keys[i]] = row[i];
//       }
//       jsonList.add(jsonRow);
//     }

//     log(jsonEncode(jsonList));
//   }
// }
