import 'package:UHabit/models/habit.dart';
import 'package:UHabit/models/habit_record.dart';
import 'package:UHabit/services/api_utils.dart';
import 'habit_service.dart';

class HabitServiceImpl implements HabitService {
  Future<List<Habit>> getPublicHabits() async {
    final response = await ApiUtils.get<List<Habit>>(
      '/api/v1/habits/public',
      (json) {
        return (json as List).map((item) => Habit.fromJson(item)).toList();
      },
    );
    return response ?? [];
  }

  Future<Habit?> getHabit(int habitId) async {
    return await ApiUtils.get<Habit>(
      '/api/v1/habits/id/$habitId',
      (json) => Habit.fromJson(json),
    );
  }

  Future<List<Habit>> getUserHabits(int userId) async {
    final response = await ApiUtils.get<List<Habit>>(
      '/api/v1/habits/user/$userId',
      (json) {
        return (json as List).map((item) => Habit.fromJson(item)).toList();
      },
    );
    return response ?? [];
  }

  Future<List<HabitRecord>> getActiveHabits() async {
    final response = await ApiUtils.get<List<HabitRecord>>(
      '/api/v1/habits/record/active',
      (json) {
        return (json as List).map((item) => HabitRecord.fromJson(item)).toList();
      },
    );
    return response ?? [];
  }

  Future<HabitRecord?> submitHabitRecord(int habitId) async {
    return await ApiUtils.post<HabitRecord>(
      '/api/v1/habits/record/active/$habitId',
      {},
      (json) => HabitRecord.fromJson(json),
    );
  }
}
