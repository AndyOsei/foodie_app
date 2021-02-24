import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/models/cart.dart';
import 'package:foodie_app/models/dish.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/rounded_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class DishInfoScreen extends StatefulWidget {
  const DishInfoScreen({Key key, @required this.dish}) : super(key: key);

  final Dish dish;

  @override
  _DishInfoScreenState createState() => _DishInfoScreenState();
}

class _DishInfoScreenState extends State<DishInfoScreen> {
  final _dishImagePagecontroller = PageController();

  void _goBack() {
    ExtendedNavigator.root.pop();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.blue300,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.SIZE_16,
          ),
          child: Column(
            children: [
              ..._buildDishImagePageView(size),
              SizedBox(height: Sizes.SIZE_20),
              Text(
                '${widget.dish.name}',
                style: textTheme.headline3.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: Sizes.SIZE_8),
              Text(
                '${toMoney(widget.dish.price)}',
                style: textTheme.headline3.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.red200,
                ),
              ),
              Expanded(
                child: _buildDishInfo(textTheme, size),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.blue200,
      brightness: Brightness.light,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _goBack,
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDishImagePageView(Size size) => [
        Container(
          height: size.height * 0.25,
          child: PageView(
            controller: _dishImagePagecontroller,
            children: List.generate(
              3,
              (i) => Image.asset(
                widget.dish.image,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
        SmoothPageIndicator(
          controller: _dishImagePagecontroller,
          count: 3,
          effect: WormEffect(
            dotWidth: Sizes.SIZE_8,
            dotHeight: Sizes.SIZE_8,
            dotColor: AppColors.gray200,
            activeDotColor: AppColors.red200,
          ),
        ),
      ];

  Padding _buildDishInfo(TextTheme textTheme, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.SIZE_30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 1),
          Text(
            StringConst.DELIVERY_INFO_TITLE,
            style: textTheme.headline5,
          ),
          SizedBox(height: Sizes.SIZE_8),
          Text(
            StringConst.DELIVERY_INFO_DESC,
            style: textTheme.bodyText2.copyWith(
              fontSize: Sizes.TEXT_SIZE_15,
              color: Color.fromRGBO(0, 0, 0, 0.5),
              letterSpacing: 0.2,
              height: 1.39,
            ),
          ),
          Spacer(flex: 1),
          Text(
            StringConst.RETURN_POLICY_TITLE,
            style: textTheme.headline5,
          ),
          SizedBox(height: Sizes.SIZE_8),
          Text(
            StringConst.RETURN_POLICY_DESC,
            style: textTheme.bodyText2.copyWith(
              fontSize: Sizes.TEXT_SIZE_15,
              color: Color.fromRGBO(0, 0, 0, 0.5),
              letterSpacing: 0.2,
              height: 1.38,
            ),
          ),
          Spacer(flex: 1),
          Align(
            alignment: Alignment.bottomCenter,
            child: AddToCartButton(dish: widget.dish),
          ),
        ],
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    Key key,
    @required this.dish,
  }) : super(key: key);

  final Dish dish;

  void _navigateToCartPage() {
    ExtendedNavigator.root.push(Routes.cartScreen);
  }

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<Cart, bool>((cart) {
      for (CartItem item in cart.items) {
        if ((item.dish != null) && (item.dish.id == dish.id)) {
          return true;
        }
      }
      return false;
    });

    return RoundedButton(
      onPressed: () {
        if (!isInCart) {
          var cart = context.read<Cart>();
          cart.add(CartItem(
            dish: dish,
            quantity: 1,
          ));
          _navigateToCartPage();
        }
      },
      width: MediaQuery.of(context).size.width - Sizes.SIZE_150,
      height: Sizes.SIZE_60,
      label: isInCart ? 'Added' : StringConst.ADD_TO_CART,
    );
  }
}
