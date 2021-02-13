import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/custom_icon.dart';

class CustomDrawer extends StatefulWidget {
  final Widget child;

  const CustomDrawer({Key key, @required this.child}) : super(key: key);

  static CustomDrawerState of(BuildContext context) =>
      context.findAncestorStateOfType<CustomDrawerState>();

  @override
  CustomDrawerState createState() => new CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 250);
  static const double maxSlide = 255;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  AnimationController _animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: CustomDrawerState.toggleDuration,
    );
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  void toggleDrawer() => _animationController.isCompleted ? close() : open();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_animationController.isCompleted) {
          close();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          child: widget.child,
          builder: (context, child) {
            double animValue = _animationController.value;
            final slideAmount = maxSlide * animValue;
            final contentScale = 1.0 - (0.3 * animValue);
            return Stack(
              children: <Widget>[
                MyDrawer(),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slideAmount - 20)
                    ..translate(0.0, 20.0)
                    ..scale(contentScale, contentScale),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppColors.orange200,
                    ),
                  ),
                ),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slideAmount)
                    ..scale(contentScale, contentScale),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _animationController.isCompleted ? close : null,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        _animationController.isCompleted ? Sizes.SIZE_30 : 0,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Material(
      color: AppColors.red200,
      child: SafeArea(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark,
            dividerTheme: DividerThemeData(
              space: Sizes.SIZE_30,
              color: Colors.white,
              indent: Sizes.SIZE_50,
              endIndent: size.width / 2.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.SIZE_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: size.height / 12),
                ListTile(
                  leading: CustomIcon(name: 'user'),
                  title: Text(StringConst.PROFILE),
                ),
                const Divider(),
                ListTile(
                  leading: CustomIcon(name: 'buy'),
                  title: Text(StringConst.ORDERS),
                ),
                const Divider(),
                ListTile(
                  leading: CustomIcon(name: 'promo'),
                  title: Text(StringConst.OFFER_AND_PROMO),
                ),
                const Divider(),
                ListTile(
                  leading: CustomIcon(name: 'outline_sticky_note'),
                  title: Text(StringConst.PRIVACY_POLICY),
                ),
                const Divider(),
                ListTile(
                  onTap: () {},
                  leading: CustomIcon(name: 'security'),
                  title: Text(StringConst.SECURITY),
                ),
                Spacer(),
                FractionallySizedBox(
                  widthFactor: 0.4,
                  child: ListTile(
                    onTap: () {
                      ExtendedNavigator.root.pushAndRemoveUntil(
                          Routes.authScreen, (route) => false);
                    },
                    title: Text(StringConst.SIGN_OUT),
                    trailing: CustomIcon(name: 'arrow_right'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
