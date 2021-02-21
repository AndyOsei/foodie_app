import 'package:flutter/material.dart';
import 'package:foodie_app/values/values.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key key,
    this.shape,
    this.title,
    this.actions,
    this.content,
  }) : super(key: key);

  final ShapeBorder shape;
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.SIZE_20),
        ),
      ),
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.SIZE_20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Sizes.SIZE_20),
                  topRight: Radius.circular(Sizes.SIZE_20),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: Sizes.SIZE_60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.SIZE_30,
                    vertical: Sizes.SIZE_16,
                  ),
                  child: title,
                ),
              ),
            ),
            SizedBox(height: Sizes.SIZE_20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.SIZE_30),
              child: content,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.SIZE_30,
                vertical: Sizes.SIZE_16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: actions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
