import 'package:flutter/material.dart';
import 'package:foodie_app/values/values.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key key,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.SIZE_20),
        boxShadow: [Shadows.infoCard],
      ),
      child: child,
    );
  }
}
