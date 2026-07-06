import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_tracker/data/water_data.dart';
import 'package:water_intake_tracker/models/water_model.dart';

class WaterTile extends StatelessWidget {
  const WaterTile({super.key, required this.waterModel});

  final WaterModel waterModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              size: 20,
              Icons.water_drop_rounded,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              '${waterModel.amount.toStringAsFixed(2)} ml',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        subtitle: Text(
          '${waterModel.dateTime.day} / ${waterModel.dateTime.month}',
        ),
        trailing: IconButton(
          onPressed: () {
            Provider.of<WaterData>(context, listen: false).delete(waterModel);
          },
          icon: Icon(Icons.delete_forever),
        ),
      ),
    );
  }
}
