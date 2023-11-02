import 'dart:convert';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class Controllers {
  Future<void> printJsonFromCsvFile() async {
    String csvData = await rootBundle.loadString('assets/zeehubTestData.csv');
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvData);

    log("\n $csvData");

    List<Map<String, dynamic>> jsonList = [];

    // Use the first row as keys for each Map
    List<dynamic> keys = rowsAsListOfValues.removeAt(0);

    for (List<dynamic> row in rowsAsListOfValues) {
      Map<String, dynamic> jsonRow = {};
      for (int i = 0; i < keys.length; i++) {
        jsonRow[keys[i]] = row[i];
      }
      jsonList.add(jsonRow);
    }

    log(jsonEncode(jsonList));
  }
}
