import 'dart:ui';

import 'package:foodie_app/values/values.dart';

class PaymentMethod {
  const PaymentMethod({this.name, this.icon, this.color});

  final String name;
  final String icon;
  final Color color;
}

List<PaymentMethod> defaultPaymentMethods() => [
      PaymentMethod(name: 'Card', icon: 'credit_card', color: AppColors.orange),
      PaymentMethod(name: 'Bank Account', icon: 'bank', color: AppColors.pink),
      PaymentMethod(name: 'Paypal', icon: 'paypal', color: AppColors.blue100),
    ];
