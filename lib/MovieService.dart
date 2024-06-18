import 'api_config.dart';
import 'Models/Movie.dart';
import 'package:dio/dio.dart';

class MovieService {
  static Future<List<Movie>> readMovies() async {
    final dio = Dio();

    final response = await dio.get(
      '${ApiConfig.baseUrl}/movie/popular?api_key=${ApiConfig.apiKey}',
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<Movie> getMovieById(int movieId) async {
    final dio = Dio();
    final response = await dio.get(
      '${ApiConfig.baseUrl}/movie/$movieId?language=en-US&api_key=${ApiConfig.apiKey}',
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
