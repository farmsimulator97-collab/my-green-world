import 'dart:convert';
import 'package:http/http.dart' as http;

/// عنوان Cloudflare Worker سيُضاف بعد نشره.
/// لا تضع مفاتيح مزودي الذكاء الاصطناعي داخل التطبيق.
class ApiClient {
  static const String workerBaseUrl = 'https://REPLACE-WITH-YOUR-WORKER.workers.dev';

  Future<Map<String, dynamic>> healthCheck() async {
    final uri = Uri.parse('$workerBaseUrl/health');
    final response = await http.get(uri).timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) {
      throw Exception('تعذر الاتصال بالخدمة (${response.statusCode})');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
