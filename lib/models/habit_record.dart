class HabitRecord {
  final int id;
  final int habitId;
  final int userId;
  final String status;
  final bool privateHabit;
  final List<DateTime> completedDates;

  HabitRecord({
    required this.id,
    required this.habitId,
    required this.userId,
    required this.status,
    required this.privateHabit,
    required this.completedDates,
  });

  factory HabitRecord.fromJson(Map<String, dynamic> json) {
    return HabitRecord(
      id: json['id'],
      habitId: json['habitId'],
      userId: json['userId'],
      status: json['status'],
      privateHabit: json['privateHabit'],
      completedDates: (json['completedDates'] as List)
          .map((date) => DateTime.parse(date))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habitId': habitId,
      'userId': userId,
      'status': status,
      'privateHabit': privateHabit,
      'completedDates': completedDates.map((date) => date.toIso8601String()).toList(),
    };
  }
}
