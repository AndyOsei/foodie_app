import 'package:flutter/foundation.dart';

import 'cart.dart';

class Order {
  Order({
    @required this.name,
    @required this.address,
    @required this.mobile,
    @required this.deliveryMethod,
    this.total = 0.0,
    this.items,
  });

  String name;
  String address;
  String mobile;
  String deliveryMethod;
  List<CartItem> items;
  double total;
}

class Orders extends ChangeNotifier {
  List<Order> _items = [];

  void add(Order item) {
    _items.add(item);
    notifyListeners();
  }
}
