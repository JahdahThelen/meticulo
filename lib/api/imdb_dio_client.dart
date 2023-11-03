import 'package:dio/dio.dart';

import 'api_client.dart';

class IMDBDioClient implements ApiClient{
  /// A client for the IMDB api based on Dio
  /// Works as a facade for the app to handle all requests
  final dio = Dio();

  @override
  Future<void> search(String title) async {
    Response response = await dio.get('http://www.omdbapi.com/?i=tt3896198&apikey=186be766&s=$title');
    print(response.data);
  }
}
