import 'package:flutter/material.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/info_card.dart';

class RadioGroup extends StatelessWidget {
  const RadioGroup({
    Key key,
    this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.SIZE_8),
        child: Column(
          children: [
            for (int i = 0; i < children.length; i++)
              if (i != children.length - 1) ...[
                children[i],
                const Divider(
                  color: AppColors.gray200,
                  indent: Sizes.SIZE_20,
                ),
              ] else
                children[i]
          ],
        ),
      ),
    );
  }
}
