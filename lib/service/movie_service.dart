import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';

class MovieService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = 'YOUR_API_KEY_HERE';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/movie/popular?api_key=$_apiKey&language=en-US&page=1'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
