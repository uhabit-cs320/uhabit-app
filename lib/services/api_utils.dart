import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class ApiUtils {
  static const String baseUrl = 'http://10.0.2.2:8081';
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get Firebase ID token with error handling
  static Future<String> _getIdToken() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('User is null');
        await _handleInvalidToken();
        throw Exception('Not authenticated');
      }

      final token = await user.getIdToken(true);
      if (token == null || token.isEmpty) {
        print('Token is null or empty');
        await _handleInvalidToken();
        throw Exception('Invalid token');
      }

      return token;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-token-expired' || 
          e.code == 'invalid-credential' ||
          e.code == 'user-token-revoked' ||
          e.message!.contains('INVALID_REFRESH_TOKEN')
          ) {
        print('Invalid token: ${e.message} with code ${e.code}');
        await _handleInvalidToken();
      }
      throw Exception('Authentication failed: ${e.message} with code ${e.code}');
    } catch (e) {
      print('Token refresh failed: $e');
      await _handleInvalidToken();
      rethrow;
    }
  }

  // Handle invalid token by signing out
  static Future<void> _handleInvalidToken() async {
    try {
      print('Signing out...');
      await _auth.signOut();
      // You can add navigation to login screen here if needed
      // Example: NavigationService.navigateToLogin();
    } catch (e) {
      print('Sign out failed: $e');
    }
  }

  // Get standard headers with auth token
  static Future<Map<String, String>> getHeaders() async {
    final token = await _getIdToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // GET request wrapper
  static Future<T?> get<T>(String endpoint, T Function(dynamic) fromJson) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: await getHeaders(),
      );

      if (response.statusCode == 200) {
        print('GET request response: ${response.body}');
        return fromJson(json.decode(response.body));
      } else {
        _handleErrorResponse(response);
        return null;
      }
    } catch (e) {
      print('GET request failed: $e');
      rethrow;
    }
  }

  // POST request wrapper
  static Future<T?> post<T>(
    String endpoint, 
    dynamic body, 
    T Function(Map<String, dynamic>) fromJson
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: await getHeaders(),
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return fromJson(json.decode(response.body));
      } else {
        _handleErrorResponse(response);
        return null;
      }
    } catch (e) {
      print('POST request failed: $e');
      rethrow;
    }
  }

  // PUT request wrapper
  static Future<T?> put<T>(
    String endpoint, 
    dynamic body, 
    T Function(Map<String, dynamic>) fromJson
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: await getHeaders(),
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return fromJson(json.decode(response.body));
      } else {
        _handleErrorResponse(response);
        return null;
      }
    } catch (e) {
      print('PUT request failed: $e');
      rethrow;
    }
  }

  // DELETE request wrapper
  static Future<bool> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: await getHeaders(),
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        _handleErrorResponse(response);
        return false;
      }
      return true;
    } catch (e) {
      print('DELETE request failed: $e');
      rethrow;
    }
  }

  // Error handling with token validation
  static void _handleErrorResponse(http.Response response) {
    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else if (response.statusCode == 403) {
      throw Exception('Forbidden');
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
