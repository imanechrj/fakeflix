import 'package:fakeflix/Models/Movie.dart';
import 'package:flutter/material.dart';

class LikedItemsProvider with ChangeNotifier {
  final Map<int, Movie> _likedItems = {};

  Map<int, Movie> get likedItems => _likedItems;

  void addItem(int movieId, Movie movie) {
    if (!_likedItems.containsKey(movieId)) {
      _likedItems[movieId] = movie;
      notifyListeners();
    }
  }

  void removeItem(int movieId) {
    if (_likedItems.containsKey(movieId)) {
      _likedItems.remove(movieId);
      notifyListeners();
    }
  }
}
