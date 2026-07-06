import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:water_intake_tracker/models/water_model.dart';

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
}
