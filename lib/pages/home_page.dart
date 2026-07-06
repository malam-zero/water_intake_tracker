import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_tracker/data/water_data.dart';
import 'package:water_intake_tracker/models/water_model.dart';
import 'package:water_intake_tracker/widgets/water_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();

  @override
  void initState() {
    Provider.of<WaterData>(context, listen: false).getWater();
    super.initState();
  }

  void saveWater() async {
    Provider.of<WaterData>(context, listen: false).addWater(
      WaterModel(
        amount: double.parse(amountController.text.toString()),
        dateTime: DateTime.now(),
        unit: 'ml',
      ),
    );
    if (!context.mounted) {
      return;
    }
  }

  void addWater() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "Add Water",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter Water to your daily Intake'),
            Gap(10).column,
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Amount"),
              ),
            ),
            Gap(10).column,
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              saveWater();
              amountController.clear();
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu_outlined),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.handyman_sharp)),
          ],
          elevation: 2,
          centerTitle: true,
          title: Text('Water'),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          onPressed: addWater,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.waterDateList.length,
          itemBuilder: (context, index) {
            final waterModel = value.waterDateList[index];
            return WaterTile(waterModel: waterModel);
          },
        ),
      ),
    );
  }
}
