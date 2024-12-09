import 'api_utils.dart';

class HealthService {
  Future<bool> checkHealth() async {
    try {
      print('Checking health...');
      final response = await ApiUtils.get<String>(
        '/health/user',
        (json) => json['status'] as String,
      );
      print('Health check response: $response');
      return response == 'OK';
    } catch (e) {
      print('Health check failed: $e');
      return false;
    }
  }
}
