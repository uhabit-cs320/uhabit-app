import 'package:UHabit/models/habit.dart';
import 'package:UHabit/models/habit_record.dart';

abstract class HabitService {
  Future<List<Habit>> getPublicHabits();
  Future<Habit?> getHabit(int habitId);
  Future<List<Habit>> getUserHabits(int userId);
  Future<HabitRecord?> submitHabitRecord(int habitId);
} 