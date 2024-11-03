import 'dart:convert';
import 'package:flutter/services.dart';

class EnvConfig {
  static Future<String> getApiKey() async {
    try {
      final String jsonString = await rootBundle.loadString('env.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return jsonMap['api_key'] as String;
    } catch (e) {
      throw Exception('Failed to load API key: $e');
    }
  }
}