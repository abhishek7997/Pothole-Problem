import 'package:flutter/material.dart';
import './pothole.dart';

class PotHoles with ChangeNotifier {
  // List<PotHole> _items = [
  //   PotHole(
  //     id: 'p1',
  //   ),
  //   PotHole(
  //     id: 'p2',
  //   ),
  //   PotHole(
  //     id: 'p3',
  //   ),
  //   PotHole(
  //     id: 'p4',
  //   ),
  // ];

  List<PotHole> _items = [];

  List<PotHole> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return _items;
  }

  void addPothole(value) {
    _items.add(value);
    //notifyListeners();
  }

  void addAllPotholes(value) {
    _items.addAll(value);
    //notifyListeners();
  }

  void clear() {
    _items.clear();
  }

  bool empty() {
    return _items.isEmpty;
  }
}
