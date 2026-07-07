import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:water_intake_tracker/models/water_model.dart';
import 'package:water_intake_tracker/utils/date_time_herlper.dart';

class WaterData extends ChangeNotifier {
  List<WaterModel> waterDateList = [];

  void addWater(WaterModel water) async {
    final url = Uri.https(
      'water-intaker-e27fe-default-rtdb.asia-southeast1.firebasedatabase.app',
      'water.json',
    );

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'amount': double.parse(water.amount.toString()),
        'unit': 'ml',
        'dateTime': DateTime.now().toString(),
      }),
    );
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      waterDateList.add(
        WaterModel(
          id: extractedData['name'],
          amount: water.amount,
          dateTime: water.dateTime,
          unit: 'ml',
        ),
      );
    } else {
      Exception();
    }
    notifyListeners();
  }

  Future<List<WaterModel>> getWater() async {
    final url = Uri.https(
      'water-intaker-e27fe-default-rtdb.asia-southeast1.firebasedatabase.app',
      'water.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200 && response.body != 'null') {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      for (var element in extractedData.entries) {
        waterDateList.add(
          WaterModel(
            id: element.key,
            amount: element.value['amount'],
            dateTime: DateTime.parse(element.value['dateTime']),
            unit: element.value['unit'],
          ),
        );
      }
      notifyListeners();
      return waterDateList;
    } else {
      return waterDateList;
    }
  }

  String getWeekday(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime getStartofWeek() {
    DateTime? startOfWeek;
    DateTime dateTime = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getWeekday(dateTime.subtract(Duration(days: i))) == 'Sat') {
        startOfWeek = dateTime.subtract(Duration(days: i));
      }
    }
    return startOfWeek!; // Fallback return
  }

  void delete(WaterModel waterModel) async {
    final url = Uri.https(
      'water-intaker-e27fe-default-rtdb.asia-southeast1.firebasedatabase.app',
      'water/${waterModel.id}.json',
    );
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      waterDateList.removeWhere((element) => element.id == waterModel.id);
    } else {
      Exception;
    }
    notifyListeners();
  }

  String calculteWeeklyWaterIntake(WaterData value) {
    double weeklyWaterIntake = 0;

    for (var water in value.waterDateList) {
      weeklyWaterIntake += double.parse(water.amount.toString());
    }

    return weeklyWaterIntake.toStringAsFixed(2);
  }

  Map<String, double> calculateDailyWaterSummary() {
    Map<String, double> dailyWaterSummary = {};

    for (var water in waterDateList) {
      String date = convertdateTimeString(water.dateTime);
      double amount = double.parse(water.toString());

      if (dailyWaterSummary.containsKey(date)) {
        double currentAmoount = dailyWaterSummary[date]!;
        currentAmoount += amount;
        dailyWaterSummary[date];
      } else {
        dailyWaterSummary.addAll({date: amount});
      }
    }

    return dailyWaterSummary;
  }
}
