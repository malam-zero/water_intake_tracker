import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_tracker/data/water_data.dart';
import 'package:water_intake_tracker/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WaterData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Water Intake',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: HomePage(),
      ),
    );
  }
}
