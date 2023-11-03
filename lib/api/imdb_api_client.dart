import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/result.dart';
import 'api_client.dart';

class ImdbApiClient implements ApiClient {
  /// A client for the IMDB api based on Dio
  /// Works as a facade for the app to handle all requests
  final dio = Dio();

  @override
  Future<List<Result>> search(String title) async {
    Response response = await dio
        .get('http://www.omdbapi.com/?i=tt3896198&apikey=186be766&s=$title');

    return _parseResults(response.data);
  }

  List<Result> _parseResults(String responseBody) {
    {
      final parsed =
          (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

      return parsed
          .map<Result>((json) => Result(json['Title'], json['imdbID']))
          .toList();
    }
  }
}
