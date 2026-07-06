import 'package:water_intake_tracker/widgets/barsgraph/individual_bar.dart';

class BarData {
  final double satWaterAmnt;
  final double sunWaterAmnt;
  final double monWaterAmnt;
  final double tuesWaterAmnt;
  final double wedWaterAmnt;
  final double thursWaterAmnt;
  final double friWaterAmnt;

  BarData({
    required this.satWaterAmnt,
    required this.sunWaterAmnt,
    required this.monWaterAmnt,
    required this.tuesWaterAmnt,
    required this.wedWaterAmnt,
    required this.thursWaterAmnt,
    required this.friWaterAmnt,
  });

  List<IndividualBar> barData = [];

  void initBarData() {
    barData = [
      IndividualBar(x: 0, y: satWaterAmnt),
      IndividualBar(x: 1, y: sunWaterAmnt),
      IndividualBar(x: 2, y: monWaterAmnt),
      IndividualBar(x: 3, y: tuesWaterAmnt),
      IndividualBar(x: 4, y: wedWaterAmnt),
      IndividualBar(x: 5, y: thursWaterAmnt),
      IndividualBar(x: 6, y: friWaterAmnt),
    ];
  }
}
