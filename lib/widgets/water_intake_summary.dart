import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_tracker/data/water_data.dart';
import 'package:water_intake_tracker/widgets/bargraph/bar_graph.dart';

class WaterIntakeSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const WaterIntakeSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: BarGraph(
          maxY: 100,
          satWaterAmnt: 89,
          sunWaterAmnt: 73,
          monWaterAmnt: 94,
          tuesWaterAmnt: 93,
          wedWaterAmnt: 74,
          thursWaterAmnt: 78,
          friWaterAmnt: 55,
        ),
      ),
    );
  }
}
