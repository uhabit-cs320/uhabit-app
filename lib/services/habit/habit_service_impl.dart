import 'package:UHabit/models/habit_record.dart';
import 'package:UHabit/services/api_utils.dart';
import 'package:UHabit/services/habit/habit_record_service.dart';

class HabitRecordServiceImpl implements HabitRecordService {
  @override
  Future<List<HabitRecord>> getActiveHabits() async {
    final response = await ApiUtils.get<List<HabitRecord>>(
      '/api/v1/habits/record/active',
      (json) => (json as List)
          .map((item) => HabitRecord.fromJson(item))
          .toList(),
    );
    
    return response ?? [];
  }

  @override
  Future<List<HabitRecord>> getUserHabits(int userId) async {
    final response = await ApiUtils.get<List<HabitRecord>>(
      '/api/v1/habits/record/$userId',
      (json) => (json as List)
          .map((item) => HabitRecord.fromJson(item))
          .toList(),
    );
    
    return response ?? [];
  }

  @override
  Future<HabitRecord?> submitHabitRecord(int habitId) async {
    return await ApiUtils.post<HabitRecord>(
      '/api/v1/habits/record/active/$habitId',
      {},
      (json) => HabitRecord.fromJson(json),
    );
  }
} 