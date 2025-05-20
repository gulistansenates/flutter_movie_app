import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/movie_model.dart';

class FavoriteProvider extends ChangeNotifier {
  static const String boxName = 'favorite_movies';
  late Box<Movie> _favoriteBox;

  List<Movie> _favorites = [];
  List<Movie> get favorites => _favorites;

  FavoriteProvider() {
    _init();
  }

  Future<void> _init() async {
    _favoriteBox = await Hive.openBox<Movie>(boxName);
    _favorites = _favoriteBox.values.toList();
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favoriteBox.containsKey(movie.id);
  }

  void toggleFavorite(Movie movie) {
    if (isFavorite(movie)) {
      _favoriteBox.delete(movie.id);
    } else {
      _favoriteBox.put(movie.id, movie);
    }
    _favorites = _favoriteBox.values.toList();
    notifyListeners();
  }
}
