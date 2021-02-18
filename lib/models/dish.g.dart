// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dish _$DishFromJson(Map<String, dynamic> json) {
  return Dish(
    id: json['id'] as int,
    name: json['name'] as String,
    image: json['image'] as String,
    price: (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
    };

DishType _$DishTypeFromJson(Map<String, dynamic> json) {
  return DishType(
    name: json['name'] as String,
    dishes: (json['dishes'] as List)
        ?.map(
            (e) => e == null ? null : Dish.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DishTypeToJson(DishType instance) => <String, dynamic>{
      'name': instance.name,
      'dishes': instance.dishes?.map((e) => e?.toJson())?.toList(),
    };
