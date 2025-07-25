class PayoutModel {
  final int amount;
  final double commission;
  final double finalValue;

  PayoutModel({
    required this.amount,
    required this.commission,
    required this.finalValue,
  });

  factory PayoutModel.fromJson(Map<String, dynamic> json) {
    return PayoutModel(
      amount: json['amount'],
      commission: (json['commission'] as num).toDouble(),
      finalValue: (json['final_value'] as num).toDouble(),
    );
  }
}

class TransactionModel {
  final int id;
  final int amount;
  final String createdAt;
  final String status;
  final String type;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.status,
    required this.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'],
      createdAt: json['created_at'],
      status: json['status'],
      type: json['type'],
    );
  }
}
