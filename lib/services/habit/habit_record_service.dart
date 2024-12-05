import 'package:UHabit/models/habit_record.dart';
import 'package:UHabit/services/api_utils.dart';

abstract class HabitRecordService {
  Future<List<HabitRecord>> getActiveHabits();
  Future<List<HabitRecord>> getUserHabits(int userId);
  Future<HabitRecord?> submitHabitRecord(int habitId);
} 