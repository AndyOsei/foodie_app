import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:foodie_app/models/dish.dart';

class CartItem {
  CartItem({this.dish, this.quantity});

  final Dish dish;
  int quantity;
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  void add(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void updateQuanity(int index, int quantity) {
    if (_items[index] != null) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
