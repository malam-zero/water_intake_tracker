import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_tracker/data/water_data.dart';
import 'package:water_intake_tracker/utils/date_time_herlper.dart';
import 'package:water_intake_tracker/widgets/bargraph/bar_graph.dart';

class WaterIntakeSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const WaterIntakeSummary({super.key, required this.startOfWeek});

  double calculateMaxAmount(
    WaterData waterData,
    String saturday,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
  ) {
    double? maxAmount = 100;
    List<double> values = [
      waterData.calculateDailyWaterSummary()[saturday] ?? 0,
      waterData.calculateDailyWaterSummary()[sunday] ?? 0,
      waterData.calculateDailyWaterSummary()[monday] ?? 0,
      waterData.calculateDailyWaterSummary()[tuesday] ?? 0,
      waterData.calculateDailyWaterSummary()[wednesday] ?? 0,
      waterData.calculateDailyWaterSummary()[thursday] ?? 0,
      waterData.calculateDailyWaterSummary()[friday] ?? 0,
    ];

    values.sort();
    maxAmount = values.last * 1.05;
    return maxAmount == 0 ? 100 : maxAmount;
  }

  @override
  Widget build(BuildContext context) {
    String saturday = convertdateTimeString(startOfWeek.add(Duration(days: 0)));
    String sunday = convertdateTimeString(startOfWeek.add(Duration(days: 1)));
    String monday = convertdateTimeString(startOfWeek.add(Duration(days: 2)));
    String tuesday = convertdateTimeString(startOfWeek.add(Duration(days: 3)));
    String wednesday = convertdateTimeString(
      startOfWeek.add(Duration(days: 4)),
    );
    String thursday = convertdateTimeString(startOfWeek.add(Duration(days: 5)));
    String friday = convertdateTimeString(startOfWeek.add(Duration(days: 6)));

    return Consumer<WaterData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: BarGraph(
          maxY: calculateMaxAmount(
            value,
            saturday,
            sunday,
            monday,
            tuesday,
            wednesday,
            thursday,
            friday,
          ),
          satWaterAmnt: value.calculateDailyWaterSummary()[saturday] ?? 0,
          sunWaterAmnt: value.calculateDailyWaterSummary()[sunday] ?? 0,
          monWaterAmnt: value.calculateDailyWaterSummary()[monday] ?? 0,
          tuesWaterAmnt: value.calculateDailyWaterSummary()[tuesday] ?? 0,
          wedWaterAmnt: value.calculateDailyWaterSummary()[wednesday] ?? 0,
          thursWaterAmnt: value.calculateDailyWaterSummary()[thursday] ?? 0,
          friWaterAmnt: value.calculateDailyWaterSummary()[friday] ?? 0,
        ),
      ),
    );
  }
}
