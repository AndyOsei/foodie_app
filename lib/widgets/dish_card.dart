import 'package:flutter/material.dart';
import 'package:foodie_app/models/dish.dart';
import 'package:foodie_app/values/values.dart';

class DishCard extends StatelessWidget {
  const DishCard({
    Key key,
    @required this.dish,
  }) : super(key: key);

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.SIZE_30,
        ),
        boxShadow: [Shadows.dishCard],
        color: Colors.white,
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Transform.translate(
            offset: Offset(0.0, -40.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Sizes.SIZE_200,
                  maxHeight: Sizes.SIZE_200,
                ),
                child: Image.asset(
                  dish.image,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, 0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Sizes.SIZE_30, horizontal: Sizes.SIZE_20),
              child: Text(
                '${dish.name}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.6),
            child: Text(
              '${dish.price}',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: AppColors.red200),
            ),
          ),
        ],
      ),
    );
  }
}
