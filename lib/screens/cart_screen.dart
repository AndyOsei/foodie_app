import 'package:flutter/material.dart';
import 'package:foodie_app/values/values.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue200,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.SIZE_30,
            vertical: Sizes.SIZE_16,
          ),
          child: Container(),
        ),
      ),
    );
  }
}
