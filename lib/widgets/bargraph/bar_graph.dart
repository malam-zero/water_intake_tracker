import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:water_intake_tracker/widgets/bargraph/bar_data.dart';

class BarGraph extends StatelessWidget {
  final double maxY;
  final double satWaterAmnt;
  final double sunWaterAmnt;
  final double monWaterAmnt;
  final double tuesWaterAmnt;
  final double wedWaterAmnt;
  final double thursWaterAmnt;
  final double friWaterAmnt;

  const BarGraph({
    super.key,
    required this.maxY,
    required this.satWaterAmnt,
    required this.sunWaterAmnt,
    required this.monWaterAmnt,
    required this.tuesWaterAmnt,
    required this.wedWaterAmnt,
    required this.thursWaterAmnt,
    required this.friWaterAmnt,
  });

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
      satWaterAmnt: satWaterAmnt,
      sunWaterAmnt: sunWaterAmnt,
      monWaterAmnt: monWaterAmnt,
      tuesWaterAmnt: tuesWaterAmnt,
      wedWaterAmnt: wedWaterAmnt,
      thursWaterAmnt: thursWaterAmnt,
      friWaterAmnt: friWaterAmnt,
    );
    barData.initBarData();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitlesWidget,
              ),
            ),
          ),
          maxY: maxY,
          minY: 0,
          barGroups: barData.barData
              .map(
                (data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 20,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY,
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget getBottomTitlesWidget(double value, TitleMeta meta) {
    final TextStyle style = TextStyle(
      color: Color.fromARGB(255, 24, 23, 23),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Sat', style: style);
        break;
      case 1:
        text = Text('Sun', style: style);
        break;
      case 2:
        text = Text('Mon', style: style);
        break;
      case 3:
        text = Text('Tue', style: style);
        break;
      case 4:
        text = Text('Wed', style: style);
        break;
      case 5:
        text = Text('Thu', style: style);
        break;
      case 6:
        text = Text('Fri', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(meta: meta, space: 4, child: text);
  }
}
