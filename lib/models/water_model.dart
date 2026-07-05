class WaterModel {
  final String? id;
  final double amount;
  final DateTime dateTime;

  WaterModel({
    this.id,
    required this.amount,
    required this.dateTime,
    required unit,
  });

  factory WaterModel.fromJson(Map<String, dynamic> json, String id) {
    return WaterModel(
      id: id,
      amount: json['amount'],
      dateTime: DateTime.parse(json['dataTime']),
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'unit': 'ml', 'dateTime': DateTime.now()};
  }
}
