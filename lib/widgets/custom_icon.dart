import 'package:flutter/material.dart';
import 'package:foodie_app/values/values.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key key, @required this.name, this.color})
      : super(key: key);

  final String name;
  final Color color;

  static final Map<String, String> icons = {
    "menu": ImagePath.MENU_ICON,
    "search": ImagePath.SEARCH_ICON,
    "user": ImagePath.USER_ICON,
    "promo": ImagePath.PROMO_ICON,
    "buy": ImagePath.BUY_ICON,
    "security": ImagePath.SECURITY_ICON,
    "outline_sticky_note": ImagePath.OUTLINE_STICKY_NOTE_ICON,
    "shopping_cart": ImagePath.SHOPPING_CART_ICON,
    "arrow_right": ImagePath.ARROW_RIGHT_ICON,
  };

  @override
  Widget build(BuildContext context) {
    return Image.asset('${icons[name]}', color: color);
  }
}
