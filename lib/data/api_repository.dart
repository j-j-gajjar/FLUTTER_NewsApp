import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiRepository {
  ApiRepository({required String apiKey}) : _apiKey = apiKey;

  final String _baseApi = 'https://newsapi.org/v2/';
  final String _apiKey;

  String topHeadlines(int pageSize, String country, String category, int page, {String? channel = '', String? searchKey = ''}) =>
      '${_baseApi}top-headlines?pageSize=$pageSize&page=$page&country=$country&category=$category&sources=$channel&apiKey=$_apiKey';

  Future<void> requestData(String url) async {
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

// Future<void> getNews({
//   String? channel,
//   String? searchKey,
//   bool reload = false,
// }) async {
//   setState(() => notFound = false);
//
//   if (!reload && !isLoading) {
//     toggleDrawer();
//   } else {
//     country = null;
//     category = null;
//   }
//   if (isLoading) {
//     pageNum++;
//   } else {
//     setState(() => news = []);
//     pageNum = 1;
//   }
//   baseApi = 'https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&';
//
//   baseApi += country == null ? 'country=in&' : 'country=$country&';
//   baseApi += category == null ? '' : 'category=$category&';
//   baseApi += 'apiKey=$apiKey';
//   if (channel != null) {
//     country = null;
//     category = null;
//     baseApi = 'https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&sources=$channel&apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6';
//   }
//   if (searchKey != null) {
//     country = null;
//     category = null;
//     baseApi = 'https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&q=$searchKey&apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6';
//   }
//   //print(baseApi);
//   getDataFromApi(baseApi);
// }
}
