import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable(explicitToJson: true)
class Dish {
  Dish({
    this.id,
    this.name,
    this.image,
    this.price,
  });

  final int id;
  final String name;
  final String image;
  final double price;

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);

  Map<String, dynamic> toJson() => _$DishToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DishType {
  DishType({this.name, this.dishes});

  final String name;
  final List<Dish> dishes;

  factory DishType.fromJson(Map<String, dynamic> json) =>
      _$DishTypeFromJson(json);

  Map<String, dynamic> toJson() => _$DishTypeToJson(this);
}

Future<List<DishType>> loadDishes() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  Map<String, dynamic> allDishes = jsonDecode(jsonString);
  List<DishType> dishes = List();
  for (MapEntry<String, dynamic> entry in allDishes.entries) {
    Map<String, dynamic> dishMap = {
      'name': entry.key,
      'dishes': entry.value,
    };
    dishes.add(DishType.fromJson(dishMap));
  }
  return dishes;
}

String toMoney(double value) {
  final formatCurrency = NumberFormat.simpleCurrency(name: 'NGN');
  return formatCurrency.format(value);
}
