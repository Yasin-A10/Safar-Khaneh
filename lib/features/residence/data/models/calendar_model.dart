class CalendarModel {
  final String date;
  final String status;

  CalendarModel({
    required this.date,
    required this.status,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'status': status,
    };
  }
}
