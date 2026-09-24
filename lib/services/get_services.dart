import 'dart:convert';

import 'package:flutter_kalender/services/get_model.dart';
import 'package:http/http.dart' as http;

class GetServices {
  Future<WikiModel?> getServices(DateTime date) async {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    final url = Uri.parse(
      'https://de.wikipedia.org/api/rest_v1/feed/onthisday/events/$month/$day',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        return WikiModel.fromJson(decoded);
      }
    }

    return null;
  }
}
