class Habit {
  final int id;
  final String name;
  final int ownerId;
  final String visibility;

  Habit({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.visibility,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      visibility: json['visibility'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
