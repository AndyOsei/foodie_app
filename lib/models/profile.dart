import 'package:flutter/foundation.dart';
import 'package:foodie_app/models/payment_method.dart';

class Profile extends ChangeNotifier {
  Profile(
      {this.name, this.email, this.address, this.paymentMethod, this.mobile});

  String name;
  String email;
  String address;
  String mobile;
  PaymentMethod paymentMethod;

  void updateWith({
    String newName,
    String newEmail,
    String newAddress,
    String newMobile,
    PaymentMethod newPaymentMethod,
  }) {
    if (newName != null) {
      name = newName;
    }

    if (newEmail != null) {
      email = newEmail;
    }

    if (newAddress != null) {
      address = newAddress;
    }

    if (paymentMethod != null) {
      paymentMethod = newPaymentMethod;
    }

    if (newMobile != null) {
      mobile = newMobile;
    }

    notifyListeners();
  }
}
