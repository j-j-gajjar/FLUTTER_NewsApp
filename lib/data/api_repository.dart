import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiRepository {
  ApiRepository({required String apiKey}) : _apiKey = apiKey;

  final String _baseApi = 'https://newsapi.org/v2/';
  final String _apiKey;

  String topHeadlines(int pageSize, String country, String category, int page, {String? channel = '', String? searchKey = ''}) =>
      '${_baseApi}top-headlines?pageSize=$pageSize&page=$page&country=$country&category=$category&sources=$channel&apiKey=$_apiKey';

  Future<dynamic> requestData(String url) async {
    print(url);
    try {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        if (kDebugMode) {
          debugPrint('Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
