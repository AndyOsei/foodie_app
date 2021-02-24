import 'package:flutter/material.dart';
import 'package:foodie_app/values/values.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key key,
    @required this.name,
    this.color,
    this.width,
    this.height,
    this.size,
  }) : super(key: key);

  final String name;
  final Color color;
  final double width;
  final double height;
  final double size;

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
    "edit": ImagePath.EDIT_ICON,
    "credit_card": ImagePath.CREDIT_CARD_ICON,
    "bank": ImagePath.BANK_ICON,
    "paypal": ImagePath.PAYPAL_ICON,
    "swipe": ImagePath.SWIPE_ICON,
    "trash": ImagePath.TRASH_ICON,
    "shopping_cart_alt": ImagePath.SHOPPING_CART_ALT_ICON,
    "user_alt": ImagePath.USER_ALT_ICON,
    "doc": ImagePath.DOC_ICON,
  };

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      '${icons[name]}',
      color: color,
      width: size ?? width,
      height: size ?? height,
      fit: BoxFit.contain,
    );
  }
}
