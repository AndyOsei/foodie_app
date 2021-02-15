import 'package:foodie_app/models/payment_method.dart';

class Profile {
  Profile({this.name, this.email, this.address, this.paymentMethod});

  String name;
  String email;
  String address;
  PaymentMethod paymentMethod;
}
