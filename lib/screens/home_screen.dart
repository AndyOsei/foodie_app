import 'package:flutter/material.dart';
import 'package:foodie_app/models/dish.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.SIZE_30),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<DishType>> dishes;

  @override
  void initState() {
    super.initState();
    dishes = loadDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(flex: 2, child: _buildUpper(context)),
            Flexible(flex: 3, child: _buildDishTabs()),
          ],
        ),
      ),
    );
  }

  Padding _buildUpper(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: Sizes.SIZE_30,
          left: Sizes.SIZE_30,
          right: Sizes.SIZE_30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    CustomDrawer.of(context).toggleDrawer();
                  },
                  child: Image.asset(ImagePath.MENU_ICON),
                ),
                Image.asset(ImagePath.SHOPPING_CART_ICON),
              ],
            ),
            Spacer(),
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
          for (int i = 0; i < categories.length; i++) {
            print('--------${categories[i]}-------');
            categoryDishes[i].forEach((d) => print(d.name));
            print('-------- end -------');
          }

          return DefaultTabController(
            length: categories.length,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 1,
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
                  flex: 4,
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
                            margin: const EdgeInsets.only(
                              left: Sizes.SIZE_40,
                            ),
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
                                  alignment: const Alignment(0.0, 0.1),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(Sizes.SIZE_40),
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
                                  alignment: Alignment(0.0, 0.5),
                                  child: Text(
                                    '${dish.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(color: AppColors.red200),
                                  ),
                                ),
                              ],
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

  FractionallySizedBox _buildSearchButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: InkWell(
        onTap: () {},
        overlayColor: MaterialStateProperty.all(AppColors.black50),
        borderRadius: BorderRadius.circular(Sizes.SIZE_30),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.SIZE_20,
            horizontal: Sizes.SIZE_30,
          ),
          decoration: BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.circular(Sizes.SIZE_30),
          ),
          child: Row(
            children: [
              Image.asset(ImagePath.SEARCH_ICON),
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
