import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/models/dish.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/custom_drawer.dart';
import 'package:foodie_app/widgets/custom_icon.dart';
import 'package:foodie_app/widgets/dish_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<DishType>> dishes;
  String _selectedTab;

  @override
  void initState() {
    super.initState();
    dishes = loadDishes();
    _selectedTab = Routes.homeScreen;
  }

  Color getIndicatorColor({String tab}) {
    if (tab == _selectedTab) {
      return AppColors.red200;
    }
    return AppColors.blue400;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white200,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(flex: 2, child: _buildUpper(context)),
            Flexible(flex: 3, child: _buildDishTabs()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomTabs(),
    );
  }

  void _navigateToCartPage() {
    ExtendedNavigator.root.push(Routes.cartScreen);
  }

  void _navigateToPage(BuildContext context, String screen) async {
    if (screen != _selectedTab) {
      setState(() {
        _selectedTab = screen;
      });
      final result = await ExtendedNavigator.of(context).push(screen);
      if (result) {
        setState(() {
          _selectedTab = Routes.homeScreen;
        });
      }
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white200,
      brightness: Brightness.light,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.SIZE_20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                CustomDrawer.of(context).toggleDrawer();
              },
              child: CustomIcon(name: 'menu'),
            ),
            GestureDetector(
              onTap: _navigateToCartPage,
              child: CustomIcon(name: 'shopping_cart'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomTabs() {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.SIZE_24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                _navigateToPage(context, Routes.homeScreen);
              },
              splashColor: getIndicatorColor(tab: Routes.homeScreen),
              child: Icon(
                Icons.home,
                color: getIndicatorColor(tab: Routes.homeScreen),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Icon(Icons.favorite_border, color: getIndicatorColor()),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                _navigateToPage(context, Routes.profileScreen);
              },
              child: CustomIcon(
                name: 'user_alt',
                size: 24,
                color: getIndicatorColor(tab: Routes.profileScreen),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                _navigateToPage(context, Routes.historyScreen);
              },
              child: Icon(
                Icons.history,
                color: getIndicatorColor(tab: Routes.historyScreen),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildUpper(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: Sizes.SIZE_20,
          left: Sizes.SIZE_20,
          right: Sizes.SIZE_20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConst.DELICIOUS,
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.black,
                  ),
            ),
            Text(
              StringConst.FOOD_FOR_YOU,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.black),
            ),
            Spacer(),
            _buildSearchButton(context),
            Spacer(),
          ],
        ),
      );

  void _onDishCardPressed(Dish dish) {
    ExtendedNavigator.root.push(
      Routes.dishInfoScreen,
      arguments: DishInfoScreenArguments(
        dish: dish,
      ),
    );
  }

  FutureBuilder<List<DishType>> _buildDishTabs() {
    return FutureBuilder(
      future: dishes,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<DishType>> snapshot,
      ) {
        if (snapshot.hasData) {
          final List<DishType> data = snapshot.data;
          final categories = data.map((dish) => dish.name).toList();
          final categoryDishes = data.map((dish) => dish.dishes).toList();

          return DefaultTabController(
            length: categories.length,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.SIZE_30,
                    ),
                    child: TabBar(
                      isScrollable: true,
                      labelColor: AppColors.red200,
                      labelStyle:
                          Theme.of(context).textTheme.subtitle1.copyWith(
                                fontFamily: StringConst.SF_PRO_TEXT,
                              ),
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: Sizes.SIZE_30,
                      ),
                      unselectedLabelColor: AppColors.black50,
                      tabs: List.generate(
                        categories.length,
                        (i) => Tab(text: '${categories[i]}'),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: TabBarView(
                    children: List.generate(
                      categories.length,
                      (i) => ListView.builder(
                        padding: const EdgeInsets.only(
                          top: Sizes.SIZE_60,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryDishes[i].length,
                        itemBuilder: (BuildContext context, int index) {
                          final dish = categoryDishes[i][index];
                          return Container(
                            width: MediaQuery.of(context).size.width / 2,
                            margin: const EdgeInsets.symmetric(
                              horizontal: Sizes.SIZE_20,
                            ),
                            child: DishCard(
                              dish: dish,
                              onPressed: () {
                                _onDishCardPressed(dish);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _navigateToSearchPage() {
    ExtendedNavigator.root.push(Routes.searchScreen);
  }

  FractionallySizedBox _buildSearchButton(BuildContext context) {
    return FractionallySizedBox(
      child: GestureDetector(
        onTap: _navigateToSearchPage,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.SIZE_20,
            horizontal: Sizes.SIZE_20,
          ),
          decoration: BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.circular(Sizes.SIZE_30),
          ),
          child: Row(
            children: [
              CustomIcon(name: 'search', size: Sizes.SIZE_24),
              Padding(
                padding: const EdgeInsets.only(left: Sizes.SIZE_16),
                child: Text(
                  StringConst.SEARCH,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: AppColors.black50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
