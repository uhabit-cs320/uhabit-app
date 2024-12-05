import 'package:UHabit/models/habit.dart';

abstract class HabitService {
  Future<List<Habit>> getPublicHabits();
  Future<Habit?> getHabit(int habitId);
  Future<List<Habit>> getUserHabits(int userId);
} 